# filename: ./spec/features/user/core/coach_patients_spec.rb

require './spec/support/users/coach_patients_helper'

feature 'Patient Dasbhoard', :core, sauce: sauce_labs do
  feature 'Group 1' do
    background do
      clinician.sign_in unless ENV['safari']
      visit navigation.arms_page
      patient_dashboard.navigate_to_patient_dashboard
    end

    scenario 'Coach views active participants assigned to them' do
      expect(participant_1_dashboard)
        .to have_participant_visible_in_patient_table
    end

    scenario 'Coach views inactive participants assigned to them' do
      patient_dashboard.navigate_to_inactive_patients

      expect(completer_dashboard).to have_participant_visible_in_patient_table
    end

    scenario 'Coach selects Terminate Access' do
      withdraw_dashboard.terminate_access

      expect(withdraw_dashboard)
        .to_not have_participant_visible_in_patient_table

      patient_dashboard.navigate_to_inactive_patients

      expect(withdraw_dashboard).to have_withdrawal_date
    end

    scenario 'Coach uses breadcrumbs to return to home' do
      click_on 'Group'
      find('p', text: 'Title: Group 1')
      within('.breadcrumb') do
        click_on 'Home'
      end

      expect(page).to have_content 'Arms'
    end
  end

  feature 'Participant \'TFD-Data\'' do
    background do
      clinician.sign_in unless ENV['safari']
      visit navigation.arms_page
      patient_dashboard.navigate_to_patient_dashboard
      data_dashboard.select_patient
    end

    scenario 'Coach views General Patient Info' do
      expect(data_dashboard).to have_general_patient_info
    end

    scenario 'Coach views Login Info' do
      expect(data_dashboard).to have_login_info
    end

    scenario 'Coach uses the table of contents in the patient report' do
      navigation.scroll_down
      within('.list-group') do
        ['Mood and Emotions Visualizations', 'Feelings', 'Logins',
         'Lessons', 'Audio Access', 'Activities - Future',
         'Activities - Past', 'Messages', 'Tasks'].each do |tool|
          find('a', text: tool).click
        end
        all('a', text: 'Mood')[1].click
        all('a', text: 'Thoughts')[1].click
      end

      find('.list-group').find('a', text: 'Activities visualization').click

      expect(page).to have_content 'Daily Averages'

      patient_dashboard.return_to_dashboard

      expect(patient_dashboard).to be_visible

      navigation.scroll_down
      find('.list-group').find('a', text: 'Thoughts visualization').click

      expect(page).to have_css('#ThoughtVizContainer')

      patient_dashboard.return_to_dashboard

      expect(patient_dashboard).to be_visible
    end

    scenario 'Coach views Mood and Emotions viz' do
      patient_dashboard.select_mood_emotions_viz_from_toc

      expect(patient_dashboard).to have_mood_emotions_viz_visible
    end

    scenario 'Coach navigates to 28 day view in Mood and Emotions viz' do
      patient_dashboard.select_mood_emotions_viz_from_toc
      within(patient_dashboard.mood_emotions_viz) do
        expect(patient_dashboard).to have_week_view_visible

        patient_dashboard.switch_to_28_day_view

        expect(patient_dashboard).to have_28_day_view
      end
    end

    scenario 'Coach navigates to Previous Period in Mood and Emotions viz' do
      patient_dashboard.select_mood_emotions_viz_from_toc
      within(patient_dashboard.mood_emotions_viz) do
        patient_dashboard.switch_to_previous_period

        expect(patient_dashboard).to have_previous_period_visible
      end
    end

    scenario 'Coach views Mood' do
      data_dashboard.select_mood_from_toc

      expect(data_dashboard).to have_mood_data
    end

    scenario 'Coach views Feelings' do
      data_dashboard.select_feel_from_toc

      expect(data_dashboard).to have_feelings_data
    end

    scenario 'Coach views Logins' do
      data_dashboard.select_logins_from_toc

      expect(data_dashboard).to have_login_data
    end

    scenario 'Coach views Lessons' do
      data_dashboard.select_lessons_from_toc

      expect(data_dashboard).to have_lessons_data
    end

    scenario 'Coach views Audio Access' do
      within('#media-access-container') do
        expect(page.all('tr:nth-child(1)')[1]).to have_content 'Audio! ' \
                                     "#{Date.today.strftime('%m/%d/%Y')}" \
                                     " #{Date.today.strftime('%b %d %Y')}"

        expect(page.all('tr:nth-child(1)')[1]).to have_content '2 minutes'
      end
    end

    scenario 'Coach views Activities viz' do
      page.execute_script('window.scrollTo(0,5000)')
      within('h3', text: 'Activities visualization') do
        click_on 'Activities visualization'
      end

      expect(page).to have_content 'Daily Averages for ' \
                                   "#{Date.today.strftime('%b %d %Y')}"
    end

    scenario 'Coach collapses Daily Summaries in Activities viz' do
      page.execute_script('window.scrollTo(0,5000)')
      within('h3', text: 'Activities visualization') do
        click_on 'Activities visualization'
      end

      find('h3', text: 'Daily Averages')
      page.execute_script('window.scrollBy(0,500)')
      click_on 'Previous Day'
      find('p', text: 'Average Accomplishment Discrepancy')
      click_on 'Daily Summaries'
      expect(page).to_not have_content 'Average Accomplishment Discrepancy'
    end

    scenario 'Coach navigates to previous day in Activities viz' do
      page.execute_script('window.scrollTo(0,5000)')
      within('h3', text: 'Activities visualization') do
        click_on 'Activities visualization'
      end

      find('h3', text: 'Daily Averages')
      page.execute_script('window.scrollBy(0,500)')
      click_on 'Previous Day'
      prev_day = Date.today - 1
      expect(page)
        .to have_content "Daily Averages for #{prev_day.strftime('%b %d %Y')}"
    end

    scenario 'Coach views ratings of an activity in Activity Viz' do
      page.execute_script('window.scrollTo(0,5000)')
      within('h3', text: 'Activities visualization') do
        click_on 'Activities visualization'
      end

      find('h3', text: 'Daily Averages')
      page.execute_script('window.scrollTo(0,5000)')
      prev_day = Date.today - 1
      click_on 'Previous Day'
      find('h3', text: "Daily Averages for #{prev_day.strftime('%b %d %Y')}")
      endtime = Time.now + (60 * 60)
      page.execute_script('window.scrollBy(0,500)')
      within('.panel.panel-default',
             text: "#{Time.now.strftime('%-l %P')} - " \
                   "#{endtime.strftime('%-l %P')}: Parkour") do
        click_on "#{Time.now.strftime('%-l %P')} - " \
                 "#{endtime.strftime('%-l %P')}: Parkour"
        within('.collapse.in') do
          expect(page).to have_content 'Predicted'
        end
      end
    end

    scenario 'Coach uses the visualization in Activities viz' do
      page.execute_script('window.scrollTo(0,5000)')
      within('h3', text: 'Activities visualization') do
        click_on 'Activities visualization'
      end

      find('h3', text: 'Daily Averages')
      click_on 'Visualize'
      click_on 'Last 3 Days'
      date1 = Date.today - 1
      expect(page).to have_content date1.strftime('%A, %m/%d')

      click_on 'Day'
      expect(page).to have_css('#datepicker')
    end

    scenario 'Coach views Activities - Future' do
      page.execute_script('window.scrollTo(0,5000)')
      within('#activities-future-container') do
        within('tr', text: 'Going to school') do
          two_days = Date.today + 2
          expect(page).to have_content 'Going to school  2 6 Scheduled for ' \
                                       "#{two_days.strftime('%b %d %Y')}"
        end
      end
    end

    scenario 'Coach views Activities - Past' do
      page.execute_script('window.scrollBy(0,5500)')
      within('#activities-past-container') do
        within('tr', text: 'Parkour') do
          expect(page).to have_content '9 4'
          prev_day = Date.today - 1
          expect(page).to have_content prev_day.strftime('%b %d %Y')
        end
      end
    end

    scenario 'Coach views noncompliance reason in Activities - Past' do
      page.execute_script('window.scrollBy(0,5500)')
      within('#activities-past-container') do
        within('tr', text: 'Jogging') do
          click_on 'Noncompliance'
          within('.popover.fade.right.in') do
            expect(page).to have_content 'Why was this not completed?' \
                                         "\nI didn't have time"
          end
        end
      end
    end

    scenario 'Coach views Thoughts viz' do
      page.execute_script('window.scrollTo(0,10000)')
      within('h3', text: 'Thoughts visualization') do
        click_on 'Thoughts visualization'
      end

      find('#ThoughtVizContainer')
      find('.thoughtviz_text.viz-clickable',
           text: 'Magnification or Catastro...').click
      expect(page).to have_content 'Testing add a new thought'

      click_on 'Close'
      find('text', text: 'Click a bubble for more info')
    end

    scenario 'Coach views Thoughts' do
      within('#thoughts-container') do
        within('tr', text: 'Testing negative thought') do
          expect(page).to have_content 'Testing negative thought ' \
                                       'Magnification or Catastrophizing ' \
                                       'Example challenge Example ' \
                                       'act-as-if ' \
                                       "#{Date.today.strftime('%b %d %Y')}"
        end
      end
    end

    scenario 'Coach views Messages' do
      within('#messages-container') do
        within('tr', text: 'Test') do
          expect(page)
            .to have_content "Test message #{Date.today.strftime('%b %d %Y')}"
        end
      end
    end

    scenario 'Coach views Tasks' do
      within('#tasks-container') do
        within('tr', text: 'Do - Planning Introduction') do
          tom = Date.today + 1
          expect(page).to have_content "#{tom.strftime('%m/%d/%Y')} Incomplete"
        end
      end
    end
  end

  feature 'Group 2' do
    background do
      unless ENV['safari']
        users.sign_in_user(ENV['Clinician_Email'], 'participant2',
                           ENV['Clinician_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
      click_on 'Arm 1'
      click_on 'Group 2'
      click_on 'Patient Dashboard'
      find('h1', text: 'Patient Dashboard')
    end

    scenario 'Coach sees data for a patient who has been withdrawn' do
      click_on 'Inactive Patients'
      within('.inactive', text: 'TFD-inactive') do
        click_on 'TFD-inactive'
      end

      find('h1', text: 'Participant TFD-inactive')
      find('.label-warning', text: 'Inactive')
      page.execute_script('window.scrollTo(0,5000)')
      within('#activities-future-container') do
        expect(page).to have_content 'Knitting'
      end
    end
  end
end
