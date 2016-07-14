# frozen_string_literal: true
# filename: ./spec/features/user/social_networking/researcher_reports_spec.rb

require 'uuid'
require 'fileutils'

def confirm_file(link)
  @driver.find_element(link: link).click
  file = (link == 'Thought' || link == 'Activity') ? "patient#{link}" : link
  file_path = "#{@download_dir}/#{file.downcase.delete(' ')}.csv"
  File.size(file_path).should be > 0
end

feature 'Researcher downloads CSV Exports', :social_networking do
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
    confirm_file('Comment')
  end

  scenario 'Goal' do
    confirm_file('Goal')
  end

  scenario 'Like' do
    confirm_file('Like')
  end

  scenario 'Nudge' do
    confirm_file('Nudge')
  end

  scenario 'Off Topic Post' do
    confirm_file('Off Topic Post')
  end

  scenario 'Tool Share' do
    confirm_file('Tool Share')
  end

  scenario 'Emotional Rating' do
    confirm_file('Emotional Rating')
  end

  scenario 'Thought' do
    confirm_file('Thought')
  end

  scenario 'Activity' do
    confirm_file('Activity')
  end
end
