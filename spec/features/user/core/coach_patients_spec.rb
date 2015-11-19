# filename: ./spec/features/user/core/coach_patients_spec.rb

describe 'Coach signs in,', :core, type: :feature, sauce: sauce_labs do
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

    it 'views a list of active participants assigned to the coach' do
      within('#patients') do
        expect(page).to have_content 'TFD-1111'
      end
    end

    it 'views a list of inactive participants assigned to the coach' do
      within('.btn-toolbar') do
        page.all('.btn.btn-default')[1].click
      end

      expect(page).to have_content 'Completer'
    end

    it 'selects Terminate Access to end active status of participant' do
      within('tr', text: 'TFD-Withdraw') do
        if ENV['safari'] || ENV['chrome']
          page.driver
            .execute_script('window.confirm = function() {return true}')
        end

        click_on 'Terminate Access'
      end

      unless ENV['safari'] || ENV['chrome']
        page.accept_alert 'Are you sure you would like to terminate access ' \
                          'to this membership? This option should also be ' \
                          'used before changing membership of the patient to ' \
                          'a different group or to completely revoke access ' \
                          'to this membership. You will not be able to undo ' \
                          'this.'
      end

      expect(page).to_not have_content 'TFD-Withdraw'

      click_on 'Inactive Patients'
      find('.inactive', text: 'TFD-Withdraw')
      within('.inactive', text: 'TFD-Withdraw') do
        prev_day = Date.today - 1
        expect(page)
          .to have_content "Withdrawn #{prev_day.strftime('%m/%d/%Y')}"
      end
    end

    it 'views General Patient Info' do
      select_patient('TFD-data')
      within('.panel.panel-default', text: 'General Patient Info') do
        if ENV['tfd']
          weeks_later = Date.today + 20 * 7
          week_num = 20
        else
          weeks_later = Date.today + 56
          week_num = 8
        end

        expect(page)
          .to have_content 'Started on: ' \
                           "#{Date.today.strftime('%A, %m/%d/%Y')}" \
                           "\n#{week_num} weeks from the start date is: " \
                           "#{weeks_later.strftime('%A, %m/%d/%Y')}" \
                           "\nStatus: Active Currently in week 1" \
                           "\nLessons read this week: 1"
      end
    end

    it 'views Login Info' do
      select_patient('TFD-data')
      within('.panel.panel-default', text: 'Login Info') do
        expect(page).to have_content 'Last Logged In: ' \
                                     "#{Date.today.strftime('%A, %b %d %Y')}"
        expect(page).to have_content "Logins Today: 1\nLogins during this " \
                                     "treatment week: 1\nTotal Logins: 1"
        expect(page).to have_content 'Last Activity Detected At: ' \
                                     "#{Date.today.strftime('%A, %b %d %Y')}"
        expect(page).to have_content 'Duration of Last Session: 10 minutes'
      end
    end

    it 'uses the table of contents in the patient report' do
      select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
      page.execute_script('window.scrollTo(0,5000)')
      within('.list-group') do
        ['Mood and Emotions Visualizations', 'Feelings', 'Logins',
         'Lessons', 'Audio Access', 'Activities - Future',
         'Activities - Past', 'Messages', 'Tasks'].each do |tool|
          find('a', text: tool).click
        end
        page.all('a', text: 'Mood')[1].click
        page.all('a', text: 'Thoughts')[1].click
      end

      within('.list-group') do
        find('a', text: 'Activities visualization').click
      end

      expect(page).to have_content 'Daily Averages'

      click_on 'Patient Dashboard'
      find('h3', text: 'General Patient Info')
      page.execute_script('window.scrollTo(0,5000)')
      within('.list-group') do
        find('a', text: 'Thoughts visualization').click
      end

      expect(page).to have_css('#ThoughtVizContainer')

      click_on 'Patient Dashboard'
      find('h3', text: 'General Patient Info')
    end

    it 'views Mood and Emotions viz' do
      select_patient('TFD-data')
      within('#viz-container') do
        find('.title', text: 'Mood')
        find('.title', text: 'Positive and Negative Emotions')
        expect(page).to have_css('.bar', count: 2)
      end
    end

    it 'navigates to 28 day view in Mood and Emotions viz' do
      select_patient('TFD-data')
      within('#viz-container') do
        find('.title', text: 'Mood')
        one_week_ago = Date.today - 6
        one_month_ago = Date.today - 27
        find('#date-range', text: "#{one_week_ago.strftime('%b %d %Y')} " \
             "- #{Date.today.strftime('%b %d %Y')}")
        page.execute_script('window.scrollTo(0,5000)')
        within('.btn-group') do
          find('.btn.btn-default', text: '28').click
        end

        expect(page).to have_content "#{one_month_ago.strftime('%b %d %Y')} " \
                                     "- #{Date.today.strftime('%b %d %Y')}"
      end
    end

    it 'navigates to Previous Period in Mood and Emotions viz' do
      select_patient('TFD-data')
      within('#viz-container') do
        find('.title', text: 'Mood')
        page.execute_script('window.scrollTo(0,5000)')
        click_on 'Previous Period'
        one_week_ago_1 = Date.today - 7
        two_weeks_ago = Date.today - 13
        expect(page).to have_content "#{two_weeks_ago.strftime('%b %d %Y')} " \
                                     "- #{one_week_ago_1.strftime('%b %d %Y')}"
      end
    end

    it 'views Mood' do
      select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
      page.execute_script('window.scrollTo(0,5000)')
      within('#mood-container') do
        expect(page.all('tr:nth-child(1)')[1])
          .to have_content "9 #{Date.today.strftime('%b %d %Y')}"
      end
    end

    it 'views Feelings' do
      select_patient('TFD-data')
      within('#feelings-container') do
        expect(page.all('tr:nth-child(1)')[1])
          .to have_content "longing 2 #{Date.today.strftime('%b %d %Y')}"
      end
    end

    it 'views Logins' do
      select_patient('TFD-data')
      within('#logins-container') do
        expect(page.all('tr:nth-child(1)')[1])
          .to have_content Date.today.strftime('%b %d %Y')
      end
    end

    it 'views Lessons' do
      select_patient('TFD-data')
      within('#lessons-container') do
        expect(page.all('tr:nth-child(1)')[1])
          .to have_content 'Do - Awareness Introduction This is just the ' \
                           "beginning... #{Date.today.strftime('%b %d %Y')}"

        expect(page.all('tr:nth-child(1)')[1]).to have_content '10 minutes'
      end
    end

    it 'views Audio Access' do
      select_patient('TFD-data')
      within('#media-access-container') do
        expect(page.all('tr:nth-child(1)')[1]).to have_content 'Audio! ' \
                                     "#{Date.today.strftime('%m/%d/%Y')}" \
                                     " #{Date.today.strftime('%b %d %Y')}"

        expect(page.all('tr:nth-child(1)')[1]).to have_content '2 minutes'
      end
    end

    it 'views Activities viz' do
      select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
      page.execute_script('window.scrollTo(0,5000)')
      within('h3', text: 'Activities visualization') do
        click_on 'Activities visualization'
      end

      expect(page).to have_content 'Daily Averages for ' \
                                   "#{Date.today.strftime('%b %d %Y')}"
    end

    it 'collapses Daily Summaries in Activities viz' do
      select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
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

    it 'navigates to previous day in Activities viz' do
      select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
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

    it 'views ratings of an activity in Activity Viz' do
      select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
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

    it 'uses the visualization in Activities viz' do
      select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
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

    it 'views Activities - Future' do
      select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
      page.execute_script('window.scrollTo(0,5000)')
      within('#activities-future-container') do
        within('tr', text: 'Going to school') do
          two_days = Date.today + 2
          expect(page).to have_content 'Going to school  2 6 Scheduled for ' \
                                       "#{two_days.strftime('%b %d %Y')}"
        end
      end
    end

    it 'views Activities - Past' do
      select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
      page.execute_script('window.scrollBy(0,5500)')
      within('#activities-past-container') do
        within('tr', text: 'Parkour') do
          expect(page).to have_content '9 4'
          prev_day = Date.today - 1
          expect(page).to have_content "#{prev_day.strftime('%b %d %Y')}"
        end
      end
    end

    it 'views noncompliance reason in Activities - Past' do
      select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
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

    it 'views Thoughts viz' do
      select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
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

    it 'views Thoughts' do
      select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
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

    it 'views Messages' do
      select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
      within('#messages-container') do
        within('tr', text: 'Test') do
          expect(page)
            .to have_content "Test message #{Date.today.strftime('%b %d %Y')}"
        end
      end
    end

    it 'views Tasks' do
      select_patient('TFD-data')
      find('h3', text: 'General Patient Info')
      within('#tasks-container') do
        within('tr', text: 'Do - Planning Introduction') do
          tom = Date.today + 1
          expect(page).to have_content "#{tom.strftime('%m/%d/%Y')} Incomplete"
        end
      end
    end

    it 'uses breadcrumbs to return to home' do
      click_on 'Group'
      find('p', text: 'Title: Group 1')
      within('.breadcrumb') do
        click_on 'Home'
      end

      expect(page).to have_content 'Arms'
    end
  end

  describe 'navigates to Patient Dashboard of Group 2,' do
    before do
      unless ENV['safari']
        sign_in_user(ENV['Clinician_Email'], "#{moderator}",
                     ENV['Clinician_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
      click_on 'Arm 1'
      click_on 'Group 2'
      click_on 'Patient Dashboard'
      find('h1', text: 'Patient Dashboard')
    end

    it 'sees data for a patient who has been withdrawn' do
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
