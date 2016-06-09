# frozen_string_literal: true
# filename: ./spec/features/user/social_networking/researcher_reports_spec.rb

require 'uuid'
require 'fileutils'

def check_file(file)
  @driver.find_element(link: file).click
  file_path = "#{@download_dir}/#{file.downcase.delete(' ')}.csv"
  File.size(file_path).should be > 0
end

feature 'Researcher downloads CSV Exports', :social_networking, :marigold do
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

  scenario 'Comment' do
    check_file('Comment')
  end

  scenario 'Goal' do
    check_file('Goal')
  end

  scenario 'Like' do
    check_file('Like')
  end

  scenario 'Nudge' do
    check_file('Nudge')
  end

  scenario 'Off Topic Post' do
    check_file('Off Topic Post')
  end

  scenario 'Tool Share' do
    check_file('Tool Share')
  end

  scenario 'Emotional Rating' do
    check_file('Emotional Rating')
  end

  scenario 'Thought' do
    check_file('Thought')
  end

  scenario 'Activity' do
    check_file('Activity')
  end
end
