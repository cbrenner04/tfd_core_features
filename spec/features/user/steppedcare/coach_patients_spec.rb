# filename ./spec/features/user/steppedcare/coach_patients_spec.rb

describe 'Coach signs in,', :tfd, type: :feature, sauce: sauce_labs do
  describe 'navigates to Patient Dashboard of active patient in Group 1,' do
    before do
      unless ENV['safari']
        sign_in_user(ENV['Clinician_Email'], "#{moderator}",
                     ENV['Clinician_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
      click_on 'Arm 1'
      click_on 'Group 1'
      click_on 'Patient Dashboard'
      find('h1', text: 'Patient Dashboard')
    end

    it 'sees consistent # of Logins' do
      within('#patients') do
        within('table#patients tr', text: 'participant61') do
          expect(page).to have_content 'participant61 0 6'

          date1 = Date.today - 4
          expect(page).to have_content "11 #{date1.strftime('%b %d %Y')}"
        end
      end
    end

    it 'uses the table of contents in the patient report' do
      select_patient('TFD-1111')
      expect(page).to have_content 'General Patient Info'

      page.execute_script('window.scrollTo(0,5000)')
      within('.list-group') do
        find('a', text: 'PHQ9').click
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
  end
end

describe 'Coach signs in,', :tfd, type: :feature, sauce: sauce_labs do
  describe 'navigates to Patient Dashboard of active patient in Group 1,' do
    before do
      unless ENV['safari']
        sign_in_user(ENV['Clinician_Email'], "#{moderator}",
                     ENV['Clinician_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
      click_on 'Arm 1'
      click_on 'PHQ Group'
      click_on 'Patient Dashboard'
      find('h1', text: 'Patient Dashboard')
    end

    it 'checks details for stepping' do
      within('#patients') do
        within first('tr', text: 'PHQ-1') do
          date1 = Date.today - 4
          expect(page).to have_content "17 on #{date1.strftime('%m/%d/%Y')}"

          expect(page).to have_css('.label.label-danger', text: 'YES')

          click_on 'Details'
        end
      end

      startdate = Date.today - 25
      within('.modal-content') do
        expect(page).to have_content 'Week 4 - Started on ' \
                                     "#{startdate.strftime('%m/%d/%Y')}\n" \
                                     'Suggestion: Step to t-CBT'
        date1 = Date.today - 4
        date2 = Date.today + 2
        expect(page)
          .to have_css('.danger.suffix_row',
                       text: "4 (#{date1.strftime('%m/%d/%Y')} - " \
                             "#{date2.strftime('%m/%d/%Y')}) " \
                             "#{date1.strftime('%m/%d/%Y')} 17")

        within('tr', text: 'PHQ-9 Score >= 17 for two consecutive weeks') do
          expect(page)
            .to have_css('.label.label-danger.label-adj_danger', text: 'True')
        end
      end
    end

    it 'does not see a suggestion for a participant in week 3' do
      within('#patients') do
        within('tr', text: 'PHQ-6') do
          date1 = Date.today - 4
          expect(page).to have_content "17 on #{date1.strftime('%m/%d/%Y')}"

          expect(page)
            .to have_css('.label.label-warning', text: 'No; Too Early')
        end
      end
    end

    it 'sees a suggestion to step for a participant in week 4' do
      within('#patients') do
        within('tr', text: 'PHQ-7') do
          date1 = Date.today - 4
          expect(page).to have_content "17 on #{date1.strftime('%m/%d/%Y')}"

          expect(page).to have_css('.label.label-danger', text: 'YES')
        end
      end
    end

    it 'sees a suggestion to stay for a participant in week 4' do
      within('#patients') do
        within('tr', text: 'PHQ-8') do
          date1 = Date.today - 4
          expect(page).to have_content "16 on #{date1.strftime('%m/%d/%Y')}"

          expect(page).to have_css('.label.label-success', text: 'No')
        end
      end
    end

    it 'sees a suggestion to discontinue for a participant in week 4' do
      within('#patients') do
        within('tr', text: 'PHQ-9') do
          date1 = Date.today - 4
          expect(page).to have_content "4 on #{date1.strftime('%m/%d/%Y')}"

          expect(page)
            .to have_css('.label.label-success', text: 'No - Low Scores')
        end
      end
    end

    it 'sees a suggestion to step for a participant in week 8' do
      within('#patients') do
        within('tr', text: 'PHQ-10') do
          date1 = Date.today - 4
          expect(page).to have_content "17 on #{date1.strftime('%m/%d/%Y')}"

          expect(page).to have_css('.label.label-danger', text: 'YES')
        end
      end
    end

    it 'sees a suggestion to stay for a participant in week 8' do
      within('#patients') do
        within('tr', text: 'PHQ-11') do
          date1 = Date.today - 4
          expect(page).to have_content "16 on #{date1.strftime('%m/%d/%Y')}"

          expect(page).to have_css('.label.label-success', text: 'No')
        end
      end
    end

    it 'sees a suggestion to discontinue for a participant in week 9' do
      within('#patients') do
        within('tr', text: 'PHQ-12') do
          date1 = Date.today - 4
          expect(page).to have_content "4 on #{date1.strftime('%m/%d/%Y')}"

          expect(page)
            .to have_css('.label.label-success', text: 'No - Low Scores')
        end
      end
    end

    it 'sees a suggestion to step for a participant in week 9' do
      within('#patients') do
        within('tr', text: 'PHQ-13') do
          date1 = Date.today - 4
          expect(page).to have_content "17 on #{date1.strftime('%m/%d/%Y')}"

          expect(page).to have_css('.label.label-danger', text: 'YES')
        end
      end
    end

    it 'sees a suggestion to stay for a participant in week 9' do
      within('#patients') do
        within('tr', text: 'PHQ-14') do
          date1 = Date.today - 4
          expect(page).to have_content "12 on #{date1.strftime('%m/%d/%Y')}"

          expect(page).to have_css('.label.label-success', text: 'No')
        end
      end
    end

    it 'sees a suggestion to step for a participant in week 10' do
      within('#patients') do
        within('tr', text: 'PHQ-15') do
          date1 = Date.today - 4
          expect(page).to have_content "13 on #{date1.strftime('%m/%d/%Y')}"

          expect(page).to have_css('.label.label-danger', text: 'YES')
        end
      end
    end

    it 'sees a suggestion to stay for a participant in week 10' do
      within('#patients') do
        within('tr', text: 'PHQ-16') do
          date1 = Date.today - 4
          expect(page).to have_content "12 on #{date1.strftime('%m/%d/%Y')}"

          expect(page).to have_css('.label.label-success', text: 'No')
        end
      end
    end

    it 'steps a participant' do
      within('#patients') do
        within('table#patients tr', text: 'PHQ-2') do
          if ENV['chrome'] || ENV['safari']
            page.driver
              .execute_script('window.confirm = function() {return true}')
          end

          click_on 'Step'
        end
      end

      unless ENV['chrome'] || ENV['safari']
        page.accept_alert "You can't undo this! Please make sure you really " \
                        'want to STEP this participant before confirming. ' \
                        'Otherwise click CANCEL.'
      end

      within('#patients') do
        expect(page).to_not have_css('tr', text: 'PHQ-2')
      end

      within('#stepped-patients') do
        expect(page).to have_css('tr', text: 'PHQ-2')

        within('tr', text: 'PHQ-2') do
          expect(page)
            .to have_content "Stepped #{Date.today.strftime('%m/%d/%Y')}"
          expect(page).to_not have_content 'Details'
        end
      end
    end

    it 'views PHQ9' do
      select_patient('PHQ-3')

      within('#phq9-container') do
        within('tr:nth-child(2)') do
          three_weeks_ago = Date.today - 18
          expect(page)
            .to have_content 'Released ' \
                             "#{three_weeks_ago.strftime('%m/%d/%Y')}" \
                             ' Created ' \
                             "#{three_weeks_ago.strftime('%m/%d/%Y')}" \
                             ' 9 * 1 2  1 2 1 1 1  '
        end
      end
    end

    it 'creates a new PHQ9 assessment' do
      select_patient('PHQ-4')

      within('.list-group') do
        find('a', text: 'PHQ9').click
      end

      click_on 'Manage'
      expect(page).to have_css('h2', text: 'PHQ assessments for PHQ-4')

      click_on 'New Phq assessment'
      (1..9).each do |i|
        fill_in "phq_assessment_q#{i}", with: '2'
      end

      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Create Phq assessment'
      expect(page).to have_content 'Phq assessment was successfully created.'

      within('tr', text: "#{Date.today.strftime('%Y-%m-%d')}") do
        expect(page).to have_content '2 2 2 2 2 2 2 2 2 Edit Delete'

        expect(page).to have_css('.fa.fa-flag', count: '9')
      end
    end

    it 'manages an existing PHQ9 assessment' do
      select_patient('PHQ-1')

      within('.list-group') do
        find('a', text: 'PHQ9').click
      end

      click_on 'Manage'
      expect(page).to have_css('h2', text: 'PHQ assessments for PHQ-1')

      three_weeks_ago = Date.today - 18
      within('tr', text: "#{three_weeks_ago.strftime('%Y-%m-%d')}") do
        click_on 'Edit'
      end

      fill_in 'phq_assessment_q3', with: '2'
      fill_in 'phq_assessment_q9', with: '2'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Update Phq assessment'
      expect(page).to have_content 'Phq assessment was successfully updated.'

      within('tr', text: "#{three_weeks_ago.strftime('%Y-%m-%d')}") do
        expect(page).to have_content '1 2 2 1 2 1 1 1 2 Edit Delete'

        expect(page).to have_css('.fa.fa-flag', count: '2')
      end
    end

    it 'deletes an existing PHQ9 assessment' do
      select_patient('PHQ-5')

      within('.list-group') do
        find('a', text: 'PHQ9').click
      end

      click_on 'Manage'
      expect(page).to have_css('h2', text: 'PHQ assessments for PHQ-5')

      four_weeks_ago = Date.today - 25
      within('tr', text: "#{four_weeks_ago.strftime('%Y-%m-%d')}") do
        page.driver.execute_script('window.confirm = function() {return true}')
        click_on 'Delete'
      end

      expect(page).to have_content 'Phq assessment was successfully destroyed.'

      expect(page)
        .to_not have_css('tr', text: "#{four_weeks_ago.strftime('%Y-%m-%d')}")
    end
  end
end
