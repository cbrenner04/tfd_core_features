# filename: Rakefile

namespace :sunnyside do
  # load development version of sunnyside locally
  desc 'Set and start sunnyside for full suite testing locally'
  task :load_app_local do
    Dir.chdir(ENV['sunnyside_path']) do
      system('rake db:drop db:create db:migrate')
      system('rake selenium_seed:app_fixtures')
      system('rake selenium_seed:with_fixtures')
      system('rake reports:generate')
      system('rake goal_tasks:share_past_due')
      system('rails s')
    end
  end

  # dump database
  desc 'Dump database'
  task :dump_db do
    system '/Applications/Postgres.app/Contents/Versions/9.3/bin/pg_dump -c -C -o -U Chris sunnyside_development -f /Users/Chris/Work/dbs/sunnyside_db.sql'
  end

  # load database with data from database dump
  desc 'Restore database'
  task :restore_db do
    system('/Applications/Postgres.app/Contents/Versions/9.3/bin/dropdb sunnyside_development')
    system('/Applications/Postgres.app/Contents/Versions/9.3/bin/createdb sunnyside_development')
    system('/Applications/Postgres.app/Contents/Versions/9.3/bin/psql -U Chris -d sunnyside_development -f /Users/Chris/Work/dbs/sunnyside_db.sql')
    Dir.chdir(ENV['sunnyside_path']) do
      system('rails s')
    end
  end

  # load development version of sunnyside on staging, keeping selenium as driver
  desc 'Set test database for testing on staging and keep driver'
  task :load_app_staging do
    system('export Base_URL=https://sunnyside-staging.cbits.northwestern.edu')
    Dir.chdir(ENV['sunnyside_path']) do
      system('cap staging deploy:use_test_db')
      system('cap staging deploy:clean_db')
      system('cap staging deploy:migrate')
      system('cap staging deploy:seed_selenium_db')
      system('rake goal_tasks:share_past_due')
    end
  end

  # If there are errors you may need to run:
  # ssh deploy@sunnyside-staging.cbits.northwestern.edu "pg_dump -h
  #  localhost -d tfdo_aux -U tfdo_user -f
  #  /var/www/apps/sunnyside/shared/db/clean.sql -c"

  # If you get the error `pg_dump: [archiver] could not open output file
  # "/var/www/apps/sunnyside/shared/db/clean.sql": No such file or directory`,
  # you will need to run:
  # ssh deploy@sunnyside-staging.cbits.northwestern.edu
  #   "mkdir -p /var/www/apps/sunnyside/shared/db"

  # then run again:
  # ssh deploy@sunnyside-staging.cbits.northwestern.edu "pg_dump -h
  #  localhost -d tfdo_aux -U tfdo_user -f
  #  /var/www/apps/sunnyside/shared/db/clean.sql -c"

  # then you will need to hand clean (remove all CREATE table blocks at
  # bottom of file): /var/www/apps/sunnyside/shared/db/clean.sql
  # by opening it using vi after ssh-ing into the server:
  # ssh deploy@sunnyside-staging.cbits.northwestern.edu

  # exit vm by typing 'exit'
  #
  # run cap commands from clean_db

  # load development version of sunnyside on staging and switch driver to sauce
  desc 'Set test database for testing on staging and switch driver'
  task :load_app_sauce do
    system('export Base_URL=https://sunnyside-staging.cbits.northwestern.edu')
    system('Sauce=true')
    Dir.chdir(ENV['sunnyside_path']) do
      system('cap staging deploy:use_test_db')
      system('cap staging deploy:clean_db')
      system('cap staging deploy:migrate_db')
      system('cap staging deploy:seed_selenium_db')
      system('rake goal_tasks:share_past_due')
    end
  end

  # load staging version of sunnyside on staging
  desc 'Returning staging database on staging'
  task :return_staging do
    Dir.chdir(ENV['sunnyside_path']) do
      system('cap staging deploy:use_staging_db')
    end
  end
end

namespace :run_sunnyside do
  desc 'Run the test suite for the SunnySide host application on Chrome'
  task :chrome do
    system('sunnyside=true chrome=true rspec --tag core --tag social_networking --tag sunnyside')
  end

  desc 'Run the test suite for the SunnySide host application on Safari'
  task :safari do
    system('sunnyside=true safari=true rspec --tag core --tag social_networking --tag sunnyside')
  end

  desc 'Run the test suite for the SunnySide host application on Firefox'
  task :firefox do
    system('sunnyside=true rspec --tag core --tag social_networking --tag sunnyside')
  end

  desc 'Run the test suite for SunnySide on Chrome without certain example groups to increase speed'
  task :fast do
    system('sunnyside=true rspec --tag core --tag social_networking --tag sunnyside --tag ~superfluous')
  end

  # this requires switching databases on staging
  desc 'Run the test suite for the SunnySide host application on SauceLabs'
  task :sauce do
    system('sunnyside=true sauce=true rspec --tag core --tag social_networking --tag sunnyside')
  end
end
