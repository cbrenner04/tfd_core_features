# frozen_string_literal: true
# filename: ./lib/tasks/marigold.rake

require './spec/env_variables'

namespace :marigold do
  # load development version of marigold locally
  desc 'Set and start marigold for full suite testing locally'
  task :load_app_local do
    Dir.chdir("#{ENV['Path']}/marigold") do
      system('rake db:drop db:create db:migrate')
      system('rake selenium_seed:app_fixtures')
      system('marigold=true rake selenium_seed:with_fixtures')
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
    Dir.chdir("#{ENV['Path']}/marigold") do
      system('rails s')
    end
  end

  # load development version of marigold on staging, keeping selenium as driver
  desc 'Set test database for testing on staging and keep driver'
  task :load_app_staging do
    system('export Base_URL=https://marigold-staging.cbits.northwestern.edu')
    Dir.chdir("#{ENV['Path']}/marigold") do
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
    Dir.chdir("#{ENV['Path']}/marigold") do
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
    Dir.chdir("#{ENV['Path']}/marigold") do
      system('cap staging deploy:use_staging_db')
    end
  end
end

SET_MARIGOLD_TRUE = 'marigold=true'
MARIGOLD_TAGS = '--tag marigold'

namespace :run_marigold do
  desc 'Run the test suite for the Marigold host application on Chrome'
  task :chrome do
    system("#{SET_MARIGOLD_TRUE} chrome=true rspec #{MARIGOLD_TAGS}")
  end

  desc 'Run the test suite for the Marigold host application on Safari'
  task :safari do
    system("#{SET_MARIGOLD_TRUE} safari=true rspec #{MARIGOLD_TAGS}")
  end

  desc 'Run the test suite for the Marigold host application on Firefox'
  task :firefox do
    system("#{SET_MARIGOLD_TRUE} rspec #{MARIGOLD_TAGS}")
  end

  desc 'Run the test suite for Marigold on Firefox without certain example groups to increase speed'
  task :fast do
    system("#{SET_MARIGOLD_TRUE} rspec #{MARIGOLD_TAGS} --tag ~superfluous")
  end

  desc 'Run the participants test suite for Marigold on Firefox'
  task :participants do
    system("#{SET_MARIGOLD_TRUE} rspec #{MARIGOLD_TAGS}")
  end

  desc 'Run the users test suite for Marigold on Firefox'
  task :users do
    system("#{SET_MARIGOLD_TRUE} rspec ./spec/features/user #{MARIGOLD_TAGS}")
  end

  desc 'Run the test suite for Marigold headlessly'
  task :headless do
    system("driver=poltergeist #{SET_MARIGOLD_TRUE} rspec #{MARIGOLD_TAGS} --tag ~browser")
  end

  # setting the marigold tag here basically nullifies the browser tag
  # exclusions are added to the script to try to minimize wrong specs being run
  desc 'Run only browser specs (this is usually only for after running headlessly)'
  task :browser_only do
    system("#{SET_MARIGOLD_TRUE} rspec --tag browser --tag ~tfd --tag ~tfdso --tag ~incentives --tag ~core_csv --tag ~social_csv")
  end

  # this requires switching databases on staging
  desc 'Run the test suite for the Marigold host application on SauceLabs'
  task :sauce do
    system("#{SET_MARIGOLD_TRUE} sauce=true rspec #{MARIGOLD_TAGS}")
  end
end
