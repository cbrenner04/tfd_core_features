# filename: ./spec/features/user/social_networking/coach_patients_spec.rb

describe 'Patient Dashboard - ',
         :social_networking, type: :feature, sauce: sauce_labs do
  describe 'Coach signs in, navigates to Patient Dashboard of ' \
           'active patient in Group 1,' do
    before do
      unless ENV['safari']
        sign_in_user(ENV['Clinician_Email'], 'TFD Moderator',
                     ENV['Clinician_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
      click_on 'Arm 1'
      click_on 'Group 1'
      click_on 'Patient Dashboard'
      find('h1', text: 'Patient Dashboard')
    end

    it 'views Tool Use table' do
      select_patient('TFD-1111')
      within('.table.table-hover', text: 'Tool Use') do
        table_row = page.all('tr:nth-child(1)')
        content = ['Tool Use  Today Last 7 Days Totals', 'Lessons Read 1 1 1']
        (0..1).zip(content) do |i, c|
          check_data(table_row[i], c)
        end

        content = ['Moods 1 1 3', 'Thoughts 12 12 12',
                   'Activities Monitored 18 18 18',
                   'Activities Planned 14 16 16',
                   'Activities Reviewed and Completed 1 2 2',
                   'Activities Reviewed and Incomplete 1 1 1']
        (2..7).zip(content) do |i, c|
          check_data("tr:nth-child(#{i})", c)
        end
      end
    end

    it 'uses the links within Tool Use table' do
      select_patient('TFD-1111')
      within('.table.table-hover', text: 'Tool Use') do
        item = ['Lessons Read', 'Moods', 'Thoughts', 'Activities Planned',
                'Activities Monitored', 'Activities Reviewed and Completed',
                'Activities Reviewed and Incomplete']
        item.each do |tool|
          click_on tool
        end
      end
    end

    it 'views Social Activity' do
      select_patient('TFD-1111')
      within('.table.table-hover', text: 'Social Activity') do
        table_row = page.all('tr:nth-child(1)')
        check_data(table_row[0], 'Social Activity Today Last 7 Days Totals')

        check_data(table_row[1], 'Likes 1 1 1')

        if ENV['tfd'] || ENV['tfdso']
          num = ['Nudges 2 3 3', 'Comments 1 1 1', 'Goals 5 6 8',
                 '"On My Mind" Statements 2 2 2']
        elsif ENV['sunnyside'] || ENV['marigold']
          num = ['Nudges 2 3 3', 'Comments 4 4 4', 'Goals 5 6 8',
                 '"On My Mind" Statements 2 2 2']
        end

        (2..5).zip(num) do |i, n|
          check_data("tr:nth-child(#{i})", "#{n}")
        end
      end
    end

    it 'uses the links within Social Activity table' do
      select_patient('TFD-1111')
      expect(page).to have_content 'General Patient Info'

      page.execute_script('window.scrollTo(0,5000)')
      within('.table.table-hover', text: 'Social Activity') do
        item = ['Nudges', 'Comments', 'Goals', '"On My Mind" Statements']
        item.each do |data|
          click_on data
        end
      end
    end
  end

  describe 'Coach signs in, navigates to Patient Dashboard ' \
           'of active patient in Group 6,' do
    before do
      unless ENV['safari']
        sign_in_user(ENV['Clinician_Email'], 'TFD Moderator',
                     ENV['Clinician_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
      click_on 'Arm 1'
      click_on 'Group 6'
      click_on 'Patient Dashboard'
    end

    it 'sees consistent # of Logins' do
      within('#patients') do
        within('table#patients tr', text: 'participant61') do
          date1 = Date.today - 4
          expect(page).to have_content 'participant61 0 6 11 ' \
                                       "#{date1.strftime('%b %d %Y')}"
        end
      end
    end

    it 'views Login Info' do
      select_patient('participant61')
      within('.panel.panel-default', text: 'Login Info') do
        date1 = Date.today - 4
        expect(page).to have_content 'Last Logged In: ' \
                                     "#{date1.strftime('%A, %b %d %Y')}"

        expect(page).to have_content "Logins Today: 0\nLogins during this " \
                                     "treatment week: 0\nTotal Logins: 11"
      end
    end

    it 'views Likes' do
      select_patient('participant61')
      within('#likes-container', text: 'Item Liked') do
        table_row = page.all('tr:nth-child(1)')
        within table_row[1] do
          created_date = Date.today - 24
          expect(page).to have_content 'Goal: participant63, Get crazy ' \
                                       "#{created_date.strftime('%b %d %Y')}"

          expect(page).to have_content '2'
        end
      end
    end

    it 'views Goals' do
      select_patient('participant61')
      within('#goals-container', text: 'Goals') do
        table_row = page.all('tr:nth-child(1)')
        within table_row[1] do
          due_date = Date.today - 26
          created_date = Date.today - 34
          deleted_date = Date.today - 30
          expect(page).to have_content 'do something  Incomplete ' \
                                       "#{deleted_date.strftime('%b %d %Y')} "

          expect(page).to have_content "#{due_date.strftime('%m/%d/%Y')} "

          expect(page).to have_content "#{created_date.strftime('%b %d %Y')}"

          expect(page).to have_content ' 1 0 0'
        end
      end
    end

    it 'views Comments' do
      select_patient('participant61')
      within('#comments-container') do
        table_row = page.all('tr:nth-child(1)')
        within table_row[1] do
          created_date = Date.today - 18
          expect(page).to have_content 'Great activity! Activity: ' \
                                       'participant62, Jumping, ' \
                                       "#{created_date.strftime('%b %d %Y')}"

          expect(page).to have_content '3'
        end
      end
    end

    it 'views Nudges Initiated' do
      select_patient('participant61')
      within('.panel.panel-default', text: 'Nudges Initiated') do
        table_row = page.all('tr:nth-child(1)')
        within table_row[1] do
          expect(page).to have_content Date.today.strftime('%b %d %Y')

          expect(page).to have_content 'participant62'
        end
      end
    end

    it 'views Nudges Received' do
      select_patient('participant61')
      within('.panel.panel-default', text: 'Nudges Received') do
        table_row = page.all('tr:nth-child(1)')
        within table_row[1] do
          expect(page).to have_content Date.today.strftime('%b %d %Y')

          expect(page).to have_content 'participant65'
        end
      end
    end

    it 'views On-My-Mind Statements' do
      select_patient('participant61')
      within('#on-my-mind-container') do
        table_row = page.all('tr:nth-child(1)')
        within table_row[1] do
          created_date = Date.today - 14
          expect(page).to have_content "I'm feeling great! " \
                                       "#{created_date.strftime('%b %d %Y')}"

          expect(page).to have_content '4 0 0'
        end
      end
    end
  end

  describe 'Terminate Access - ' do
    it 'Coach signs in, navigates to Patient Dashboard, ' \
       'selects Terminate Access to end active status of participant,' \
       ' checks to make sure profile is removed' do
      unless ENV['safari']
        sign_in_user(ENV['Clinician_Email'], 'TFD Moderator',
                     ENV['Clinician_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
      click_on 'Arm 1'
      click_on 'Group 6'
      click_on 'Patient Dashboard'
      within('#patients', text: 'participant65') do
        within('table#patients tr', text: 'participant65') do
          if ENV['safari'] || ENV['chrome']
            page.driver
              .execute_script('window.confirm = function() {return true}')
          end

          click_on 'Terminate Access'
        end
      end

      unless ENV['safari'] || ENV['chrome']
        page.accept_alert 'Are you sure you would like to terminate access to' \
                          ' this membership? This option should also be used ' \
                          'before changing membership of the patient to a ' \
                          'different group or to completely revoke access to ' \
                          'this membership. You will not be able to undo this.'
      end

      expect(page).to_not have_content 'participant65'

      click_on 'Inactive Patients'
      expect(page).to have_content 'participant65'

      unless ENV['safari']
        visit "#{ENV['Base_URL']}/participants/sign_in"
        sign_in_pt(ENV['PT61_Email'], 'TFD Moderator',
                   ENV['PT61_Password'])
        expect(page).to have_content 'HOME'

        expect(page).to_not have_content 'Fifth'
      end
    end
  end
end