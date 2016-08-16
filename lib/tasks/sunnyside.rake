# frozen_string_literal: true
# filename: ./lib/tasks/sunnyside.rake

require './spec/env_variables'

namespace :sunnyside do
  # load development version of sunnyside locally
  desc 'Set and start sunnyside for full suite testing locally'
  task :load_app_local do
    Dir.chdir("#{ENV['Path']}/sunnyside") do
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
    Dir.chdir("#{ENV['Path']}/sunnyside") do
      system('rails s')
    end
  end

  # load development version of sunnyside on staging, keeping selenium as driver
  desc 'Set test database for testing on staging and keep driver'
  task :load_app_staging do
    system('export Base_URL=https://sunnyside-staging.cbits.northwestern.edu')
    Dir.chdir("#{ENV['Path']}/sunnyside") do
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
    Dir.chdir("#{ENV['Path']}/sunnyside") do
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
    Dir.chdir("#{ENV['Path']}/sunnyside") do
      system('cap staging deploy:use_staging_db')
    end
  end
end

SET_SUNNYSIDE_TRUE = 'sunnyside=true'
SUNNYSIDE_TAGS = '--tag core --tag social_networking --tag incentives'

namespace :run_sunnyside do
  desc 'Run the test suite for the SunnySide host application on Chrome'
  task :chrome do
    system("#{SET_SUNNYSIDE_TRUE} chrome=true rspec #{SUNNYSIDE_TAGS}")
  end

  desc 'Run the test suite for the SunnySide host application on Safari'
  task :safari do
    system("#{SET_SUNNYSIDE_TRUE} safari=true rspec #{SUNNYSIDE_TAGS}")
  end

  desc 'Run the test suite for the SunnySide host application on Firefox'
  task :firefox do
    system("#{SET_SUNNYSIDE_TRUE} rspec #{SUNNYSIDE_TAGS}")
  end

  desc 'Run the test suite for SunnySide on Firefox without certain example groups to increase speed'
  task :fast do
    system("#{SET_SUNNYSIDE_TRUE} rspec #{SUNNYSIDE_TAGS} --tag ~superfluous")
  end

  desc 'Run the participants test suite for SunnySide on Firefox'
  task :participants do
    system("#{SET_SUNNYSIDE_TRUE} rspec ./spec/features/participant/ #{SUNNYSIDE_TAGS}")
  end

  desc 'Run the users test suite for SunnySide on Firefox'
  task :users do
    system("#{SET_SUNNYSIDE_TRUE} rspec ./spec/features/user/ #{SUNNYSIDE_TAGS}")
  end

  desc 'Run the test suite for SunnySide headlessly'
  task :headless do
    system("driver=poltergeist #{SET_SUNNYSIDE_TRUE} rspec #{SUNNYSIDE_TAGS} --tag ~browser")
  end

  # setting the sunnyside tags here basically nullifies the browser tag
  # exclusions are added to the script to try to minimize wrong specs being run
  # this will have a rspec report and then immediately run another set of specs
  # make sure to check all three reports
  desc 'Run only browser specs (this is usually only for after running headlessly)'
  task :browser_only do
    system("#{SET_SUNNYSIDE_TRUE} rspec --tag browser --tag ~marigold --tag ~tfdso --tag ~tfd")
    system("#{SET_SUNNYSIDE_TRUE} rspec --tag browser ./spec/features/user/core/content_author_slides_spec.rb")
    system("#{SET_SUNNYSIDE_TRUE} rspec --tag browser --tag ~tfdso ./spec/features/participant/social_networking/landing_page_spec.rb")
  end

  # this requires switching databases on staging
  desc 'Run the test suite for the SunnySide host application on SauceLabs'
  task :sauce do
    system("#{SET_SUNNYSIDE_TRUE} sauce=true rspec #{SUNNYSIDE_TAGS}")
  end
end
