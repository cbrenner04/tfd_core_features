# frozen_string_literal: true

require 'uuid'
require 'fileutils'

module Users
  # page object for reports
  class Reports
    include RSpec::Matchers
    include Capybara::DSL

    def set_up
      set_up_download_directory
      set_up_driver
      sign_in_user
    end

    def tear_down
      @driver.quit
      FileUtils.rm_rf @download_dir
    end

    def select_and_check_file(link)
      select_file(link)
      check_file(link)
    end

    def select_file(link)
      @driver.find_element(link: link).click
    end

    def check_file(link)
      file = if link == 'Thought' || link == 'Activity'
               "patient#{link}"
             elsif link == 'Events'
               'event'
             else
               link
             end
      file_path = "#{@download_dir}/#{file.downcase.delete(' ')}.csv"
      File.size(file_path).should be > 0
    end

    def scroll_down
      @driver.execute_script('window.scrollBy(0,100)')
    end

    private

    def set_up_download_directory
      @download_dir = File.join(Dir.pwd, UUID.new.generate)
      FileUtils.mkdir_p @download_dir
    end

    def set_up_driver
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile['browser.download.dir'] = @download_dir
      profile['browser.download.folderList'] = 2
      profile['browser.helperApps.neverAsk.saveToDisk'] = 'text/csv'
      profile['pdfjs.disabled'] = true
      @driver = Selenium::WebDriver.for :firefox, profile: profile
    end

    def sign_in_user
      @driver.get "#{ENV['Base_URL']}/users/sign_in"
      @driver.find_element(id: 'user_email').send_keys(ENV['Researcher_Email'])
      @driver.find_element(id: 'user_password')
             .send_keys(ENV['Researcher_Password'])
      @driver.find_element(css: '.btn.btn-default').submit
      @driver.get "#{ENV['Base_URL']}/think_feel_do_dashboard/reports"
    end
  end
end
