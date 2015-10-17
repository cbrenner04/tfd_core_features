# filename: ./lib/tasks/run.rake

namespace :run do
  desc 'Run the test suite for the TeleHealth host application on Chrome'
  task :tfd_suite_chrome do
    system('tfd=true chrome=true rspec --tag core')
  end

  desc 'Run the test suite for the TeleHealth host application on Safari'
  task :tfd_suite_safari do
    system('tfd=true safari=true rspec --tag core')
  end

  desc 'Run the test suite for the TeleHealth host application on Firefox'
  task :tfd_suite_firefox do
    system('tfd=true rspec --tag core')
  end

  desc 'Run the test suite for the MoodTech host application on Chrome'
  task :tfdso_suite_chrome do
    system('tfdso=true chrome=true rspec --tag core --tag social_networking')
  end

  desc 'Run the test suite for the MoodTech host application on Safari'
  task :tfdso_suite_safari do
    system('tfdso=true safari=true rspec --tag core --tag social_networking')
  end

  desc 'Run the test suite for the MoodTech host application on Firefox'
  task :tfdso_suite_firefox do
    system('tfdso=true rspec --tag core --tag social_networking')
  end
end
