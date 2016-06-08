# frozen_string_literal: true
# filename: ./spec/features/user/core/user_bugs_spec.rb

require './spec/support/users/core_bugs_helper'

feature 'User Dashboard Bugs,', :core, :marigold, sauce: sauce_labs do
  feature 'Researcher' do
    scenario 'Researcher creates a participant, assigns a group membership, ' \
             'sees correct calculation of end date' do
      researcher.sign_in
      visit user_navigation.dashboard
      visit bug_participant.landing_page
      bug_participant.create

      expect(bug_participant).to be_created_successfully

      bug_participant.assign_group

      expect(bug_participant).to have_group_assigned_successfully
    end
  end

  feature 'Clinician, Patient Dashboard' do
    scenario 'Clinician sees consistent Logins in listing, Patient Report' do
      clinician.sign_in
      visit user_navigation.arms_page
      arm_1.open
      group_6.open
      participant_61_dashboard.open

      expect(participant_61_dashboard).to have_login_info_in_patients_list

      participant_61_dashboard.select_patient

      expect(participant_61_dashboard).to have_partial_login_info
    end
  end

  feature 'Clincian, Patient Dashboard' do
    scenario 'Clinician sees correct duration calculation' do
      participant_1.sign_in
      visit bug_lesson.landing_page
      bug_lesson.read_lesson
      participant_1.sign_out

      clinician.sign_in
      visit user_navigation.arms_page
      arm_1.open
      group_1.open
      patient_1_dashboard.open
      patient_1_dashboard.select_patient

      expect(patient_1_dashboard).to have_lessons_data
    end
  end
end

feature 'Super User', :core, sauce: sauce_labs do
  scenario 'Super User cannot access Lesson Modules or Slideshows' \
           'in Manage Content of Arm without tools' do
    super_user.sign_in
    visit user_navigation.arms_page
    bug_arm.create

    expect(bug_arm).to be_created_successfully

    bug_lesson_2.manage_lessons_with_no_tools

    expect(bug_arm).to be_visible
    expect(bug_lesson_2).to_not be_visible

    bug_slideshow.manage_slideshows_with_no_tools

    expect(bug_arm).to be_visible
    expect(bug_slideshow).to_not have_slideshow_list_visible
  end
end

feature 'CSV Exports', :core, type: :feature do
  background do
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
    @driver
      .find_element(id: 'user_password')
      .send_keys(ENV['Researcher_Password'])
    @driver.find_element(css: '.btn.btn-default').submit
  end

  after do
    @driver.quit
    FileUtils.rm_rf @download_dir
  end

  scenario 'Researcher navigates to CSV reports, downloads CSVs, does not ' \
           'receive exception' do
    @driver.get "#{ENV['Base_URL']}/think_feel_do_dashboard/reports"
    (12..13).each do |i|
      download_link = @driver.find_elements(class: 'list-group-item')[i]
      download_link.click
    end

    files = Dir.glob("#{@download_dir}/**")
    files.count.should be == 2

    sorted_files = files.sort_by { |file| File.mtime(file) }
    File.size(sorted_files.last).should be > 0
  end
end
