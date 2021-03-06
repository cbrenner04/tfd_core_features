# frozen_string_literal: true
# filename: ./spec/spec_helper.rb

require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'
require 'selenium-webdriver'
# require 'sauce'
# require 'sauce/capybara'
# require 'sauce_whisk'

# define methods for setting the driver
def sauce_labs
  ENV['sauce'] || false
end

def browser
  if ENV['safari']
    :safari
  elsif ENV['chrome']
    :chrome
  else
    :firefox
  end
end

def sanity_check
  puts "Sauce Labs is set to #{sauce_labs}" \
       "\nAuto screenshots is set to #{!sauce_labs}" \
       "\nRunning in #{ENV['driver'] || browser}" \
       "\nThe time is #{Time.now.strftime('%H:%M:%S')}" \
       "\nRunning tests for #{app}"
end

# declare Firefox binary path, this is needed for csv specs
Selenium::WebDriver::Firefox::Binary.path = ENV['Firefox_Path']

# RSpec configuration options
RSpec.configure do |config|
  config.full_backtrace = false
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.run_all_when_everything_filtered = true
  config.profile_examples = 10
  config.before(:suite) { sanity_check }
end

# Capybara configuration options
Capybara.configure do |config|
  config.default_max_wait_time = 1
  config.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: browser)
  end
  config.register_driver :poltergeist do |app|
    options = { js: true, js_errors: false, window_size: [1280, 743] }
    Capybara::Poltergeist::Driver.new(app, options)
  end
  # set `driver=poltergeist` on the command line when you want to run headless
  # or `driver=suace` when running on sauce labs
  config.default_driver = ENV['driver'].nil? ? :selenium : ENV['driver'].to_sym
  unless ENV['driver'] == 'poltergeist'
    config.page.driver.browser.manage.window.resize_to(1280, 743)
  end
  config.save_path = "#{ENV['Path']}/tfd_core_features/screenshots/"
end

# capybara-screenshot configuration options
Capybara::Screenshot.register_driver(:sauce) do |driver, path|
  driver.render(path)
end
Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  example.description.tr(' ', '-').gsub(/^.*\/spec\//, '')
end
Capybara::Screenshot.autosave_on_failure = !sauce_labs
Capybara::Screenshot.prune_strategy = :keep_last_run

# sauce configurations need to be updated
# # Sauce configuration options
# Sauce.config do |config|
#   config[:job_name] = "#{ENV['App']}-Staging " \
#                       "#{Time.now.strftime('%-m/%-d/%Y')}"
#   config[:start_tunnel] = false
#   config[:browsers] = [
#     ['Windows XP', 'Firefox', '32'],
#     ['Windows XP', 'Chrome', nil],
#     ['Windows 7', 'Firefox', '32'],
#     ['Windows 7', 'Chrome', nil],
#     ['OS X 10.6', 'Firefox', '32'],
#     ['OS X 10.6', 'Chrome', nil],
#     ['OS X 10.9', 'Firefox', '32'],
#     ['OS X 10.9', 'Chrome', nil],
#     ['OS X 10.10', 'Firefox', '32'],
#     ['OS X 10.10', 'Chrome', nil]
#   ].sample
# end

# sauce_whisk configuration options
# SauceWhisk::Jobs.pass_job job_id
# SauceWhisk::Jobs.fail_job job_id
# SauceWhisk::Jobs.change_status job_id, true_for_passed_false_for_failed
