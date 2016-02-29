require './lib/pages/users/navigation'

class Users
  # page object for the patient dashboard
  class PatientDashboard
    include Capybara::DSL
    include SharedMoodEmotionsViz

    def initialize(patient_dashboard)
      @participant ||= patient_dashboard[:participant]
      @date ||= patient_dashboard[:date]
    end

    def navigate_to_patient_dashboard
      click_on 'Arm 1'
      click_on 'Group 1'
      click_on 'Patient Dashboard'
      find('h1', text: 'Patient Dashboard')
    end

    def has_participant_visible_in_patient_table?
      find('#patients').has_text? @participant
    end

    def navigate_to_inactive_patients
      click_on 'Inactive Patients'
    end

    def terminate_access
      within('tr', text: @participant) do
        if ENV['safari'] || ENV['chrome']
          execute_script('window.confirm = function() {return true}')
        end
        click_on 'Terminate Access'
      end
      unless ENV['safari'] || ENV['chrome']
        accept_alert 'Are you sure you would like to terminate access ' \
                     'to this membership? This option should also be ' \
                     'used before changing membership of the patient to ' \
                     'a different group or to completely revoke access ' \
                     'to this membership. You will not be able to undo ' \
                     'this.'
      end
    end

    def has_withdrawal_date?
      find('.inactive', text: @participant).has_text? "Withdrawn #{@date}"
    end

    def visible?
      has_css?('h3', text: 'General Patient Info')
    end

    def select_patient
      within('#patients', text: @participant) { click_on @participant }
      visible?
    end

    def has_general_patient_info?
      within('.panel-default', text: 'General Patient Info') do
        if ENV['tfd']
          weeks_later = Date.today + 20 * 7
          week_num = 20
        else
          weeks_later = Date.today + 56
          week_num = 8
        end

        has_text? "Started on: #{Date.today.strftime('%A, %m/%d/%Y')}" \
                  "\n#{week_num} weeks from the start date is: " \
                  "#{weeks_later.strftime('%A, %m/%d/%Y')}" \
                  "\nStatus: Active Currently in week 1" \
                  "\nLessons read this week: 1"
      end
    end

    def has_login_info?
      within('.panel-default', text: 'Login Info') do
        has_text? "Last Logged In: #{Date.today.strftime('%A, %b %d %Y')}"
        has_text? "Logins Today: 1\nLogins during this treatment week: 1\n" \
                  'Total Logins: 1'
        has_text? 'Last Activity Detected At: ' \
                  "#{Date.today.strftime('%A, %b %d %Y')}"
        has_text? 'Duration of Last Session: 10 minutes'
      end
    end

    def return_to_dashboard
      click_on 'Patient Dashboard'
    end

    def select_mood_emotions_viz_from_toc
      navigation.scroll_down
      find('.list-group')
        .find('a', text: 'Mood and Emotions Visualization').click
    end

    def mood_emotions_viz
      '#viz-container'
    end

    def has_mood_emotions_viz_visible?
      within(mood_emotions_viz) do
        has_css?('.title', text: 'Mood')
        has_css?('.title', text: 'Positive and Negative Emotions')
        has_css?('.bar', count: 2)
      end
    end

    def select_mood_from_toc
      navigation.scroll_down
      find('.list-group').all('a', text: 'Mood')[1].click
    end

    def has_mood_data?
      find('#mood-container').first_row
        .has_text? "9 #{Date.today.strftime('%b %d %Y')}"
    end

    def select_feel_from_toc
      select_from_toc('Feelings')
    end

    def has_feelings_data?
      find('#feelings-container').first_row
        .has_text? "longing 2 #{Date.today.strftime('%b %d %Y')}"
    end

    def select_logins_from_toc
      select_from_toc('Logins')
    end

    def has_login_data?
      find('#logins-container').first_row
        .has_text Date.today.strftime('%b %d %Y')
    end

    def select_lessons_from_toc
      select_from_toc('Lessons')
    end

    def has_lessons_data?
      find('#lessons-container').first_row
        .has_text? 'Do - Awareness Introduction This is just the ' \
                   "beginning... #{Date.today.strftime('%b %d %Y')}"
      first_row.has_text? '10 minutes'
    end

    private

    def navigation
      @navigation ||= Users::Navigation.new
    end

    def select_from_toc(link)
      navigation.scroll_down
      find('.list-group').find('a', text: link).click
    end

    def first_row
      all('tr:nth-child(1)')[1]
    end
  end
end
