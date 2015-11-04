# filename: ./spec/features/user/social_networking/user_bugs_spec.rb

describe 'User Dashboard Bugs,',
         :social_networkting, type: :feature, sauce: sauce_labs do
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

    it 'creates a participant, assigns a social group membership without a ' \
       'display name, receives alert that display name is needed' do
      click_on 'Participants'
      click_on 'New'
      fill_in 'participant_study_id', with: 'Fake'
      fill_in 'participant_email', with: 'fake@test.com'
      select 'Email', from: 'participant_contact_preference'
      click_on 'Create'
      expect(page).to have_content 'Participant was successfully created.'

      click_on 'Assign New Group'
      select 'Group 6', from: 'membership_group_id'
      fill_in 'membership_display_name', with: ''
      unless ENV['chrome']
        fill_in 'membership_start_date',
                with: Date.today.prev_day.strftime('%Y-%m-%d')
        next_year = Date.today + 365
        fill_in 'membership_end_date', with: next_year.strftime('%Y-%m-%d')
      end

      click_on 'Assign'
      expect(page).to have_content 'Group 6 is part of a social arm. ' \
                                   'Display name is required for social arms.'

      within('#membership_group_id') do
        expect(page).to have_content 'Group 6'
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
      unless ENV['safari']
        sign_in_user(ENV['Clinician_Email'], 'TFD Moderator',
                     ENV['Clinician_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard"
    end

    it 'navigates to Patient Dashboard, views Tool Use table, sees correct ' \
       'data for activities' do
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
  end
end
