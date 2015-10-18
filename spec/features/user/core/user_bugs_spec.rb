# filename: ./spec/features/user/core/user_bugs_spec.rb

describe 'User Dashboard Bugs,', :core, type: :feature, sauce: sauce_labs do
  describe 'Researcher signs in,' do
    if ENV['safari']
      before(:all) do
        sign_in_user(ENV['Researcher_Email'], 'TFD Moderator',
                     ENV['Researcher_Password'])
      end
    end

    before do
      unless ENV['safari']
        sign_in_user(ENV['Researcher_Email'], 'TFD Moderator',
                     ENV['Researcher_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard"
    end

    it 'creates a participant, assigns a group membership, sees correct ' \
       'calculation of end date' do
      click_on 'Participants'
      click_on 'New'
      fill_in 'participant_study_id', with: 'Tests'
      fill_in 'participant_email', with: 'test@test.com'
      fill_in 'participant_phone_number', with: ENV['Participant_Phone_Number']
      select 'Email', from: 'participant_contact_preference'
      click_on 'Create'
      expect(page).to have_content 'Participant was successfully created.'

      click_on 'Assign New Group'
      select 'Group 1', from: 'membership_group_id'
      unless ENV['tfd']
        fill_in 'membership_display_name', with: 'Tester'
      end

      unless driver == :chrome
        fill_in 'membership_start_date',
                with: Date.today.prev_day.strftime('%Y-%m-%d')
        next_year = Date.today + 365
        fill_in 'membership_end_date', with: next_year.strftime('%Y-%m-%d')
      end

      if ENV['tfd']
        weeks_later = Date.today + 20 * 7
        week_num = 20
      else
        weeks_later = Date.today + 56
        week_num = 8
      end

      expect(page).to have_content "Standard number of weeks: #{week_num}, " \
                                   'Projected End Date from today: ' \
                                   "#{weeks_later.strftime('%m/%d/%Y')}"

      click_on 'Assign'
      expect(page).to have_content 'Group was successfully assigned'

      unless driver == :chrome
        expect(page).to have_content "Membership Status: Active\nCurrent " \
                                     'Group: Group 1'
      end
    end
  end

  describe 'Clinician signs in,' do
    if ENV['safari']
      before(:all) do
        sign_in_user(ENV['Clinician_Email'], 'TFD Moderator',
                     ENV['Clinician_Password'])
      end
    end

    before do
      unless ENV['safair']
        sign_in_user(ENV['Clinician_Email'], 'TFD Moderator',
                     ENV['Clinician_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard"
    end

    it 'navigates to Patient Dashboard, see consistent # of Logins in ' \
       'listing page and Patient Report' do
      click_on 'Arms'
      find('h1', text: 'Arms')
      click_on 'Arm 1'
      click_on 'Group 6'
      click_on 'Patient Dashboard'
      within('#patients') do
        within('table#patients tr', text: 'participant61') do
          expect(page).to have_content 'participant61 0 6'
          
          date1 = Date.today - 4
          expect(page).to have_content "11 #{date1.strftime('%b %d %Y')}"
        end
      end

      select_patient('participant61')
      within('.panel.panel-default', text: 'Login Info') do
        date1 = Date.today - 4
        expect(page).to have_content 'Last Logged In: ' \
                                     "#{date1.strftime('%A, %b %d %Y')}"

        expect(page).to have_content "Logins Today: 0\nLogins during this " \
                                     "treatment week: 0\nTotal Logins:#{total}"
      end
    end
  end

  it 'navigates to Patient Dashboard, views Tool Use table, sees correct ' \
     'data for activities'do
    click_on 'Arms'
    find('h1', text: 'Arms')
    click_on 'Arm 1'
    click_on 'Group 1'
    click_on 'Patient Dashboard'
    select_patient('TFD-1111')
    within('.table.table-hover', text: 'Tool Use') do
      within('tr', text: 'Activities Monitored') do
        expect(page).to have_content '18 18 18'
      end

      within('tr', text: 'Activities Planned') do
        expect(page).to have_content '14 16 16'
      end

      within('tr', text: 'Activities Reviewed and Completed') do
        expect(page).to have_content '1 2 2'
      end

      within('tr', text: 'Activities Reviewed and Incomplete') do
        expect(page).to have_content '1 1 1'
      end
    end
  end

  describe 'Participant reads lesson' do
    it 'Clinician sees correct duration calculation' do
      sign_in_pt(ENV['Participant_Email'], 'TFD Moderator',
                 ENV['Participant_Password'])
      visit "#{ENV['Base_URL']}/navigator/contexts/LEARN"
      click_on 'Do - Awareness Introduction'
      sleep(60 * 2)
      click_on 'Next'
      click_on 'Finish'
      find('h1', text: 'LEARN')
      visit ENV['Base_URL']
      sign_out('participant1')

      sign_in_user(ENV['Clinician_Email'], 'participant1',
                   ENV['Clinician_Password'])
      visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
      click_on 'Arm 1'
      click_on 'Group 1'
      click_on 'Patient Dashboard'
      select_patient('TFD-1111')
      within('#lessons-container') do
        expect(page.all('tr:nth-child(1)')[1])
          .to have_content 'Do - Awareness Introduction This is just the ' \
                           "beginning... #{Time.now.strftime('%b %d %Y %I')}"

        expect(page.all('tr:nth-child(1)')[1]).to have_content '2 minutes'
      end
    end
  end
end

require 'selenium-webdriver'
require 'rspec/expectations'
include RSpec::Matchers
require 'uuid'
require 'fileutils'

describe 'Researcher signs in,', :core, type: :feature do
  before do
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
    @driver.find_element(id: 'user_password').send_keys(ENV['Researcher_Passw' \
                                                        'ord'])
    @driver.find_element(css: '.btn.btn-default').submit
  end

  after do
    @driver.quit
    FileUtils.rm_rf @download_dir
  end

  it 'navigates to CSV reports, downloads CSVs, does not receive exception' do
    @driver.get "#{ENV['Base_URL']}/think_feel_do_dashboard/reports"
    download_link = @driver.find_elements(class: 'list-group-item')[12]
    download_link.click

    download_link = @driver.find_elements(class: 'list-group-item')[13]
    download_link.click

    files = Dir.glob("#{@download_dir}/**")
    files.count.should be == 2

    sorted_files = files.sort_by { |file| File.mtime(file) }
    File.size(sorted_files.last).should be > 0
  end
end
