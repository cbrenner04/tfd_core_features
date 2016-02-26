# filename: ./spec/features/user/social_networking/coach_patients_spec.rb

feature 'Coach, Patient Dashboard', :social_networking, sauce: sauce_labs do
  feature 'Group 1' do
    background do
      unless ENV['safari']
        users.sign_in_user(ENV['Clinician_Email'], 'participant2',
                     ENV['Clinician_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
      click_on 'Arm 1'
      click_on 'Group 1'
      click_on 'Patient Dashboard'
      find('h1', text: 'Patient Dashboard')
    end

    scenario 'Coach views Tool Use table' do
      users.select_patient('TFD-data')
      within('.table.table-hover', text: 'Tool Use') do
        table_row = page.all('tr:nth-child(1)')
        content = ['Tool Use  Today Last 7 Days Totals', 'Lessons Read 1 1 1']
        (0..1).zip(content) do |i, c|
          users.check_data(table_row[i], c)
        end

        content = ['Moods 1 1 1', 'Thoughts 3 3 3',
                   'Activities Monitored 0 0 0', 'Activities Planned 1 4 4',
                   'Activities Reviewed and Completed 0 1 1',
                   'Activities Reviewed and Incomplete 0 1 1']
        (2..7).zip(content) do |i, c|
          users.check_data("tr:nth-child(#{i})", c)
        end
      end
    end

    scenario 'Coach uses the links within Tool Use table' do
      users.select_patient('TFD-data')
      within('.table.table-hover', text: 'Tool Use') do
        ['Lessons Read', 'Moods', 'Thoughts', 'Activities Planned',
         'Activities Monitored', 'Activities Reviewed and Completed',
         'Activities Reviewed and Incomplete'].each do |tool|
          click_on tool
        end
      end
    end

    scenario 'Coach uses the links within Social Activity table' do
      users.select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
      page.execute_script('window.scrollTo(0,5000)')
      within('.table.table-hover', text: 'Social Activity') do
        ['Nudges', 'Comments', 'Goals', '"On My Mind" Statements'].each do |x|
          click_on x
        end
      end
    end
  end

  feature 'Group 6' do
    background do
      unless ENV['safari']
        users.sign_in_user(ENV['Clinician_Email'], 'participant2',
                     ENV['Clinician_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
      click_on 'Arm 1'
      click_on 'Group 6'
      click_on 'Patient Dashboard'
    end

    scenario 'Coach sees consistent # of Logins' do
      within('#patients') do
        within('table#patients tr', text: 'participant61') do
          date1 = Date.today - 4
          expect(page).to have_content 'participant61 0 6 11 ' \
                                       "#{date1.strftime('%b %d %Y')}"
        end
      end
    end

    scenario 'Coach views Social Activity' do
      users.select_patient('participant61')
      within('.table.table-hover', text: 'Social Activity') do
        table_row = page.all('tr:nth-child(1)')
        users.check_data(table_row[0], 'Social Activity Today Last 7 Days Totals')
        users.check_data(table_row[1], 'Likes 0 0 1')
        num = ['Nudges 1 1 1', 'Comments 0 0 1', 'Goals 0 0 1',
               '"On My Mind" Statements 0 0 1']

        (2..5).zip(num) do |i, n|
          users.check_data("tr:nth-child(#{i})", "#{n}")
        end
      end
    end

    scenario 'Coach views Likes' do
      users.select_patient('participant61')
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

    scenario 'Coach views Goals' do
      users.select_patient('participant61')
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

    scenario 'Coach views Comments' do
      users.select_patient('participant61')
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

    scenario 'Coach views Nudges Initiated' do
      users.select_patient('participant61')
      within('.panel.panel-default', text: 'Nudges Initiated') do
        table_row = page.all('tr:nth-child(1)')
        within table_row[1] do
          expect(page).to have_content Date.today.strftime('%b %d %Y')

          expect(page).to have_content 'participant62'
        end
      end
    end

    scenario 'Coach views Nudges Received' do
      users.select_patient('participant61')
      within('.panel.panel-default', text: 'Nudges Received') do
        table_row = page.all('tr:nth-child(1)')
        within table_row[1] do
          expect(page).to have_content Date.today.strftime('%b %d %Y')

          expect(page).to have_content 'participant65'
        end
      end
    end

    scenario 'Coach views On-My-Mind Statements' do
      users.select_patient('participant61')
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

  feature 'Terminate Access' do
    scenario 'Coach Terminates Access, checks profile is removed' do
      unless ENV['safari']
        users.sign_in_user(ENV['Clinician_Email'], 'participant2',
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
        users.sign_in_pt(ENV['PT61_Email'], 'participant2',
                   ENV['PT61_Password'])
        find('h1', text: 'HOME')
        expect(page).to_not have_content 'Fifth'
      end
    end
  end
end
