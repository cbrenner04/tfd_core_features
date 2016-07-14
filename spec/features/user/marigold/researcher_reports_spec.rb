# frozen_string_literal: true
# filename: ./spec/features/user/marigold/researcher_reports_spec.rb

require 'uuid'
require 'fileutils'

def select_and_check_file(link, file_name)
  @driver.find_element(link: link).click
  file_path = "#{@download_dir}/#{file_name}.csv"
  File.size(file_path).should be > 0
end

feature 'Researcher, downloads CSV exports', :marigold do
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

  scenario 'Emotional Rating' do
    select_and_check_file('Emotional Rating', 'emotionalrating')
  end

  scenario 'Gamification: Behavior' do
    select_and_check_file('Gamification: Behavior', 'behavior')
  end

  scenario 'Gamification: Incentive' do
    select_and_check_file('Gamification: Incentive', 'incentive')
  end

  scenario 'Gamification: Participant Behavior' do
    select_and_check_file('Gamification: Participant Behavior',
                          'participantbehavior')
  end

  scenario 'Gamification: Participant Incentive' do
    select_and_check_file('Gamification: Participant Incentive',
                          'participantincentive')
  end

  scenario 'Login' do
    select_and_check_file('Login', 'login')
  end

  scenario 'Module Page View' do
    select_and_check_file('Module Page View', 'modulepageview')
  end

  scenario 'Module Session' do
    select_and_check_file('Module Session', 'modulesession')
  end

  scenario 'Participant Profile' do
    select_and_check_file('Participant Profile', 'participantprofile')
  end

  scenario 'Practice: Activation Activity' do
    select_and_check_file('Practice: Activation Activity',
                          'activationactivity')
  end

  scenario 'Practice: Gratitude Journal' do
    select_and_check_file('Practice: Gratitude Journal', 'gratituderecording')
  end

  scenario 'Practice: Kindness' do
    select_and_check_file('Practice: Kindness', 'kindness')
  end

  scenario 'Practice: Mindfulness Activity' do
    select_and_check_file('Practice: Mindfulness Activity', 'mindfulactivity')
  end

  scenario 'Practice: Mindfulness Meditation' do
    select_and_check_file('Practice: Mindfulness Meditation', 'meditation')
  end

  scenario 'Practice: Positive Experience' do
    select_and_check_file('Practice: Positive Experience', 'experience')
  end

  scenario 'Practice: Reappraisal' do
    select_and_check_file('Practice: Reappraisal', 'reappraisal')
  end

  scenario 'Practice: Strength' do
    select_and_check_file('Practice: Strength', 'strength')
  end

  scenario 'Site Session' do
    select_and_check_file('Site Session', 'sitesession')
  end

  scenario 'Skill: Feedback' do
    select_and_check_file('Skill: Feedback', 'lessonfeedback')
  end

  scenario 'Skill: Slide View' do
    select_and_check_file('Skill: Slide View', 'lessonslideview')
  end

  scenario 'Skill: Viewing' do
    select_and_check_file('Skill: Viewing', 'lessonviewing')
  end

  scenario 'Social: Comment' do
    select_and_check_file('Social: Comment', 'comment')
  end

  scenario 'Social: Like' do
    select_and_check_file('Social: Like', 'like')
  end

  scenario 'Social: Nudge' do
    select_and_check_file('Social: Nudge', 'nudge')
  end

  scenario 'Social: On My Mind Statements' do
    select_and_check_file('Social: On My Mind Statements', 'offtopicpost')
  end

  scenario 'Task Completion' do
    select_and_check_file('Task Completion', 'taskcompletion')
  end

  scenario 'Tool Access' do
    select_and_check_file('Tool Access', 'toolaccess')
  end

  scenario 'Unsubscribed Phone Numbers' do
    select_and_check_file('Unsubscribed Phone Numbers',
                          'smsdeliveryerrorrecord')
  end

  scenario 'User Agent' do
    select_and_check_file('User Agent', 'useragent')
  end

  scenario 'Video Session' do
    select_and_check_file('Video Session', 'videosession')
  end
end
