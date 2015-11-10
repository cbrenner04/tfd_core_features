# filename: ./lib/tasks/marigold.rake

namespace :marigold do
  # load development version of marigold locally
  desc 'Set and start marigold for full suite testing locally'
  task :load_app_local do
    Dir.chdir('/Users/Chris/Work/marigold') do
      system('rake db:drop db:create db:migrate')
      system('rake selenium_seed:with_fixtures')
      system('rake reports:generate')
      system('rake goal_tasks:share_past_due')
      system('rails s')
    end
  end

  # dump database
  desc 'Dump database'
  task :dump_db do
    system '/Applications/Postgres.app/Contents/Versions/9.3/bin/pg_dump -c -C -o -U Chris marigold_development -f /Users/Chris/Work/dbs/marigold_db.sql'
  end

  # load database with data from database dump
  desc 'Restore database'
  task :restore_db do
    system('/Applications/Postgres.app/Contents/Versions/9.3/bin/dropdb marigold_development')
    system('/Applications/Postgres.app/Contents/Versions/9.3/bin/createdb marigold_development')
    system('/Applications/Postgres.app/Contents/Versions/9.3/bin/psql -U Chris -d marigold_development -f /Users/Chris/Work/dbs/marigold_db.sql')
    Dir.chdir('/Users/Chris/Work/marigold') do
      system('rails s')
    end
  end

  # load development version of marigold on staging, keeping selenium as driver
  desc 'Set test database for testing on staging and keep driver'
  task :load_app_staging do
    system('export Base_URL=https://marigold-staging.cbits.northwestern.edu')
    Dir.chdir('/Users/Chris/Work/marigold') do
      system('cap staging deploy:use_test_db')
      system('cap staging deploy:clean_db')
      system('cap staging deploy:migrate')
      system('cap staging deploy:seed_selenium_db')
      system('rake goal_tasks:share_past_due')
    end
  end

  # If there are errors you may need to run:
  # ssh deploy@marigold-staging.cbits.northwestern.edu "pg_dump -h
  #  localhost -d tfdo_aux -U tfdo_user -f
  #  /var/www/apps/marigold/shared/db/clean.sql -c"

  # If you get the error `pg_dump: [archiver] could not open output file
  # "/var/www/apps/marigold/shared/db/clean.sql": No such file or directory`,
  # you will need to run:
  # ssh deploy@marigold-staging.cbits.northwestern.edu
  #   "mkdir -p /var/www/apps/marigold/shared/db"

  # then run again:
  # ssh deploy@marigold-staging.cbits.northwestern.edu "pg_dump -h
  #  localhost -d tfdo_aux -U tfdo_user -f
  #  /var/www/apps/marigold/shared/db/clean.sql -c"

  # then you will need to hand clean (remove all CREATE table blocks at
  # bottom of file): /var/www/apps/marigold/shared/db/clean.sql
  # by opening it using vi after ssh-ing into the server:
  # ssh deploy@marigold-staging.cbits.northwestern.edu

  # exit vm by typing 'exit'

  # run cap commands from clean_db

  # load development version of marigold on staging and switch driver to sauce
  desc 'Set test database for testing on staging and switch driver'
  task :load_app_sauce do
    system('export Base_URL=https://marigold-staging.cbits.northwestern.edu')
    system('Sauce=true')
    Dir.chdir('/Users/Chris/Work/marigold') do
      system('cap staging deploy:use_test_db')
      system('cap staging deploy:clean_db')
      system('cap staging deploy:migrate_db')
      system('cap staging deploy:seed_selenium_db')
      system('rake goal_tasks:share_past_due')
    end
  end

  # load staging version of marigold on staging
  desc 'Returning staging database on staging'
  task :return_staging do
    Dir.chdir('/Users/Chris/Work/marigold') do
      system('cap staging deploy:use_staging_db')
    end
  end
end

namespace :run_marigold do
  desc 'Run the test suite for the Marigold host application on Chrome'
  task :chrome do
    system('marigold=true chrome=true rspec --tag core --tag social_networking --tag sunnyside')
  end

  desc 'Run the test suite for the Marigold host application on Safari'
  task :safari do
    system('marigold=true safari=true rspec --tag core --tag social_networking --tag sunnyside')
  end

  desc 'Run the test suite for the Marigold host application on Firefox'
  task :firefox do
    system('marigold=true rspec --tag core --tag social_networking --tag sunnyside')
  end

  desc 'Run the test suite for Marigold on Chrome without certain example groups to increase speed'
  task :fast do
    system('marigold=true rspec --tag core --tag social_networking --tag sunnyside --tag ~skip')
  end

  # this requires switching databases on staging
  desc 'Run the test suite for the Marigold host application on SauceLabs'
  task :sauce do
    system('marigold=true sauce=true rspec --tag core --tag social_networking --tag sunnyside')
  end
end
