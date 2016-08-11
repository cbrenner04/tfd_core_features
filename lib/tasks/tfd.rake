# frozen_string_literal: true
# filename: ./lib/tasks/tfd.rake

require './spec/env_variables'

namespace :tfd do
  # load development version of think_feel_do locally
  desc 'Set and start think_feel_do for full suite testing locally'
  task :load_app_local do
    Dir.chdir("#{ENV['Path']}/think_feel_do") do
      system('rake db:drop db:create db:migrate')
      system('rake selenium_seed:app_fixtures')
      system('tfd=true rake selenium_seed:with_fixtures')
      system('rake reports:generate')
      system('rails s')
    end
  end

  # dump database
  desc 'Dump think_feel_do_development database'
  task :dump_db do
    system '/Applications/Postgres.app/Contents/Versions/9.3/bin/pg_dump -c -C -o -U Chris think_feel_do_development -f /Users/Chris/Work/dbs/tfd_db.sql'
  end

  # load database with data from database dump
  desc 'Restore think_feel_do_development database'
  task :restore_db do
    system('/Applications/Postgres.app/Contents/Versions/9.3/bin/dropdb think_feel_do_development')
    system('/Applications/Postgres.app/Contents/Versions/9.3/bin/createdb think_feel_do_development')
    system('/Applications/Postgres.app/Contents/Versions/9.3/bin/psql -U Chris -d think_feel_do_development -f /Users/Chris/Work/dbs/tfd_db.sql')
    Dir.chdir("#{ENV['Path']}/think_feel_do") do
      system('rails s')
    end
  end

  # load development version of think_feel_do on staging, keeping selenium as driver
  desc 'Set test database for testing think_feel_do on staging and keep driver'
  task :load_app_staging do
    system('export Base_URL=https://steppedcare-staging.cbits.northwestern.edu')
    Dir.chdir("#{ENV['Path']}/think_feel_do") do
      system('cap staging deploy:use_test_db')
      system('cap staging deploy:clean_db')
      system('cap staging deploy:migrate')
      system('cap staging deploy:seed_selenium_db')
    end
  end

  # If there are errors you may need to run:
  # ssh deploy@steppedcare-staging.cbits.northwestern.edu "pg_dump -h
  #  localhost -d tfdo_aux -U tfdo_user -f
  #  /var/www/apps/think_feel_do/shared/db/clean.sql -c"

  # then you will need to hand clean (remove all CREATE table blocks at
  # bottom of file): /var/www/apps/think_feel_do/shared/db/clean.sql
  # by opening it using vi after ssh-ing into the server:
  # ssh deploy@steppedcare-staging.cbits.northwestern.edu

  # exit vm by typing 'exit'

  # run cap commands from clean_db

  # load development version of think_feel_do on staging and switch driver to sauce
  desc 'Set test database for testing think_feel_do on staging, switch driver'
  task :load_app_sauce do
    system('export Base_URL=https://steppedcare-staging.cbits.northwestern.edu')
    system('Sauce=true')
    Dir.chdir("#{ENV['Path']}/think_feel_do") do
      system('cap staging deploy:use_test_db')
      system('cap staging deploy:clean_db')
      system('cap staging deploy:migrate_db')
      system('cap staging deploy:seed_selenium_db')
    end
  end

  # load staging version of think_feel_do on staging
  desc 'Returning think_feel_do staging database on staging'
  task :return_staging do
    Dir.chdir("#{ENV['Path']}/think_feel_do") do
      system('cap staging deploy:use_staging_db')
    end
  end
end

SET_TFD_TRUE = 'tfd=true'
TFD_TAGS = '--tag core --tag tfd'

namespace :run_tfd do
  desc 'Run the test suite for the TeleHealth host application on Chrome'
  task :chrome do
    system("#{SET_TFD_TRUE} chrome=true rspec #{TFD_TAGS}")
  end

  desc 'Run the test suite for the TeleHealth host application on Safari'
  task :safari do
    system("#{SET_TFD_TRUE} safari=true rspec #{TFD_TAGS}")
  end

  desc 'Run the test suite for the TeleHealth host application on Firefox'
  task :firefox do
    system("#{SET_TFD_TRUE} rspec #{TFD_TAGS}")
  end

  desc 'Run the test suite for TeleHealth on Firefox without certain example groups to increase speed'
  task :fast do
    system("#{SET_TFD_TRUE} rspec #{TFD_TAGS} --tag ~superfluous")
  end

  desc 'Run the participants test suite for TeleHealth on Firefox'
  task :participants do
    system("#{SET_TFD_TRUE} rspec ./spec/features/participant/ #{TFD_TAGS}")
  end

  desc 'Run the users test suite for TeleHealth on Firefox'
  task :users do
    system("#{SET_TFD_TRUE} rspec ./spec/features/user/ #{TFD_TAGS}")
  end

  desc 'Run the test suite for TeleHealth headlessly'
  task :headless do
    system("driver=poltergeist #{SET_TFD_TRUE} rspec #{TFD_TAGS} --tag ~browser")
  end

  desc 'Run only browser specs (this is usually only for after running headlessly)'
  task :browser_only do
    system("#{SET_TFD_TRUE} rspec #{TFD_TAGS} --tag browser")
  end

  # this requires switching databases on staging
  desc 'Run the test suite for the TeleHealth host application on SauceLabs'
  task :sauce do
    system("#{SET_TFD_TRUE} sauce=true rspec #{TFD_TAGS}")
  end
end
