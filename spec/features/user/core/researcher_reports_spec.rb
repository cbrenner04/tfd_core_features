# frozen_string_literal: true
# filename: ./spec/features/user/core/researcher_reports_spec.rb

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

  scenario 'Module Page View' do
    check_file('Module Page View')
  end

  scenario 'Module Session' do
    check_file('Module Session')
  end

  scenario 'Lesson Viewing' do
    check_file('Lesson Viewing')
  end

  scenario 'Lesson Slide View' do
    check_file('Lesson Slide View')
  end

  scenario 'Video Session' do
    check_file('Video Session')
  end

  scenario 'Task Completion' do
    check_file('Task Completion')
  end

  scenario 'Site Session' do
    @driver.execute_script('window.scrollBy(0,100)')
    check_file('Site Session')
  end

  scenario 'Tool Access' do
    check_file('Tool Access')
  end

  scenario 'User Agent' do
    @driver.execute_script('window.scrollBy(0,100)')
    check_file('User Agent')
  end

  scenario 'Login' do
    check_file('Login')
  end
end
