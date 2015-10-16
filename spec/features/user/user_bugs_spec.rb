# filename: user_bugs_spec.rb

describe 'User Dashboard Bugs,', type: :feature, sauce: sauce_labs do
  describe 'Researcher signs in,' do
    before do
      sign_in_user(ENV['Researcher_Email'], ENV['Researcher_Password'])
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
      unless driver == :chrome
        fill_in 'membership_start_date',
                with: Date.today.prev_day.strftime('%Y-%m-%d')
        next_year = Date.today + 365
        fill_in 'membership_end_date', with: next_year.strftime('%Y-%m-%d')
      end

      weeks_later = Date.today + 20 * 7
      expect(page).to have_content 'Standard number of weeks: 20, Projected ' \
                                   'End Date from today: ' \
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
    before do
      sign_in_user(ENV['Clinician_Email'], ENV['Clinician_Password'])
    end

    it 'navigates to Patient Dashboard, see consistent # of Logins in ' \
       'listing page and Patient Report' do
      click_on 'Arms'
      find('h1', text: 'Arms')
      click_on 'Arm 1'
      click_on 'Group 1'
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
                                     "treatment week: 0\nTotal Logins: 11"
      end
    end
  end

  describe 'Participant reads lesson' do
    it 'Clinician sees correct duration calculation' do
      sign_in_pt(ENV['Participant_Email'], ENV['Participant_Password'])
      visit "#{ENV['Base_URL']}/navigator/contexts/LEARN"
      click_on 'Do - Awareness Introduction'
      sleep(60 * 2)
      click_on 'Next'
      click_on 'Finish'
      find('h1', text: 'LEARN')
      visit ENV['Base_URL']
      sign_out

      sign_in_user(ENV['Clinician_Email'], ENV['Clinician_Password'])
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
