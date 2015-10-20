# filename: ./lib/tasks/run.rake

namespace :run do
  desc 'Run the test suite for the TeleHealth host application on Chrome'
  task :tfd_suite_chrome do
    system('tfd=true chrome=true rspec --tag core --tag tfd')
  end

  desc 'Run the test suite for the TeleHealth host application on Safari'
  task :tfd_suite_safari do
    system('tfd=true safari=true rspec --tag core --tag tfd')
  end

  desc 'Run the test suite for the TeleHealth host application on Firefox'
  task :tfd_suite_firefox do
    system('tfd=true rspec --tag core --tag tfd')
  end

  desc 'Run the test suite for the MoodTech host application on Chrome'
  task :tfdso_suite_chrome do
    system('tfdso=true chrome=true rspec --tag core --tag social_networking --tag ~tfd')
  end

  desc 'Run the test suite for the MoodTech host application on Safari'
  task :tfdso_suite_safari do
    system('tfdso=true safari=true rspec --tag core --tag social_networking --tag ~tfd')
  end

  desc 'Run the test suite for the MoodTech host application on Firefox'
  task :tfdso_suite_firefox do
    system('tfdso=true rspec --tag core --tag social_networking --tag ~tfd')
  end

  desc 'Run the test suite for the SunnySide host application on Chrome'
  task :sunnyside_suite_chrome do
    system('tfd=true chrome=true rspec --tag core --tag social_networking --tag sunnyside --tag ~tfd')
  end

  desc 'Run the test suite for the SunnySide host application on Safari'
  task :sunnyside_suite_safari do
    system('tfd=true safari=true rspec --tag core --tag social_networking --tag sunnyside --tag ~tfd')
  end

  desc 'Run the test suite for the SunnySide host application on Firefox'
  task :sunnyside_suite_firefox do
    system('tfd=true rspec --tag core --tag social_networking --tag sunnyside --tag ~tfd')
  end

  desc 'Run the test suite for the Marigold host application on Chrome'
  task :marigold_suite_chrome do
    system('tfdso=true chrome=true rspec --tag core --tag social_networking --tag sunnyside --tag ~tfd')
  end

  desc 'Run the test suite for the Marigold host application on Safari'
  task :marigold_suite_safari do
    system('tfdso=true safari=true rspec --tag core --tag social_networking --tag sunnyside --tag ~tfd')
  end

  desc 'Run the test suite for the Marigold host application on Firefox'
  task :marigold_suite_firefox do
    system('tfdso=true rspec --tag core --tag social_networking --tag sunnyside --tag ~tfd')
  end
end
