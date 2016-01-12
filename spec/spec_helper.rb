# filename: ./spec/spec_helper.rb

require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'selenium-webdriver'
require 'sauce'
require 'sauce/capybara'
require 'sauce_whisk'

# define methods for setting the driver
def sauce_labs
  ENV['sauce'] || false
end

def driver
  if ENV['safari']
    puts 'Running in Safari'
    :safari
  elsif ENV['chrome']
    puts 'Running in Chrome'
    :chrome
  else
    puts 'Running in Firefox'
    :firefox
  end
end

def test_driver
  puts "Sauce Labs is set to #{sauce_labs}"
  puts "Auto screenshots is set to #{!sauce_labs}"
  puts "The time is #{Time.now.strftime('%H:%M:%S')}"
  if sauce_labs == false
    :selenium
  else
    :sauce
  end
end

# RSpec configuration options
RSpec.configure do |config|
  config.full_backtrace = false
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.profile_examples = 10
end

# Capybara configuration options
Capybara.configure do |config|
  config.default_wait_time = 5
  config.default_driver = test_driver
  config.register_driver :selenium do |app|
    if driver == :firefox
      Selenium::WebDriver::Firefox::Binary.path =
        '/Applications/firefox33/Firefox.app/Contents/MacOS/firefox-bin'
    end
    Capybara::Selenium::Driver.new(app, browser: driver)
  end
  config.page.driver.browser.manage.window.resize_to(1280, 743)
  config.save_and_open_page_path = 'screenshots/'
end

# capybara-screenshot configuration options
Capybara::Screenshot.register_driver(:sauce) do |driver, path|
  driver.render(path)
end
Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  "#{example.description.tr(' ', '-').gsub(/^.*\/spec\//, '')}"
end
Capybara::Screenshot.autosave_on_failure = !sauce_labs
Capybara::Screenshot.prune_strategy = :keep_last_run

# Sauce configuration options
Sauce.config do |config|
  config[:job_name] = "#{ENV['App']}-Staging #{Time.now.strftime('%-m/%-d/%Y')}"
  config[:start_tunnel] = false
  config[:browsers] = [
    ['Windows XP', 'Firefox', '32'],
    ['Windows XP', 'Chrome', nil],
    ['Windows 7', 'Firefox', '32'],
    ['Windows 7', 'Chrome', nil],
    ['OS X 10.6', 'Firefox', '32'],
    ['OS X 10.6', 'Chrome', nil],
    ['OS X 10.9', 'Firefox', '32'],
    ['OS X 10.9', 'Chrome', nil],
    ['OS X 10.10', 'Firefox', '32'],
    ['OS X 10.10', 'Chrome', nil]
  ].sample

  config.after do |example|
    if example.exception.nil?
      SauceWhisk::Jobs.pass_job @driver.session_id
    else
      SauceWhisk::Jobs.fail_job @driver.session_id
    end
    @driver.quit
  end
end
