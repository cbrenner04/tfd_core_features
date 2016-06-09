# frozen_string_literal: true
# filename: ./spec/features/user/steppedcare/researcher_reports_spec.rb

require 'uuid'
require 'fileutils'

def check_file(file)
  @driver.find_element(link: file).click
  file_path = "#{@download_dir}/#{file.downcase.delete(' ')}.csv"
  File.size(file_path).should be > 0
end

feature 'Researcher, downloads CSV exports', :core, :marigold do
  background(:all) do
    @download_dir = File.join(Dir.pwd, UUID.new.generate)
    FileUtils.mkdir_p @download_dir

    profile = Selenium::WebDriver::Firefox::Profile.new
    profile['browser.download.dir'] = @download_dir
    profile['browser.download.folderList'] = 2
    profile['browser.helperApps.neverAsk.saveToDisk'] = 'text/csv'
    profile['pdfjs.disabled'] = true
    @driver = Selenium::WebDriver.for :firefox, profile: profile

    @driver.get "#{ENV['Base_URL']}/users/sign_in"
    @driver.find_element(id: 'user_email').send_keys(ENV['Researcher_Email'])
    @driver.find_element(id: 'user_password')
           .send_keys(ENV['Researcher_Password'])
    @driver.find_element(css: '.btn.btn-default').submit
    @driver.get "#{ENV['Base_URL']}/think_feel_do_dashboard/reports"
  end

  after(:all) do
    @driver.quit
    FileUtils.rm_rf @download_dir
  end

  scenario 'PHQ9 Assessment' do
    @driver.execute_script('window.scrollBy(0,500)')
    check_file('PHQ9 Assessment')
  end

  scenario 'WAI Assessment' do
    check_file('WAI Assessment')
  end
end
