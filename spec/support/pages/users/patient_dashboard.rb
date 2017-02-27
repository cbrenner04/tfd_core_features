# frozen_string_literal: true
require './spec/support/pages/users/navigation'
require './spec/support/pages/shared/activities_viz'
require './spec/support/pages/shared/mood_emotions_viz'
require './spec/support/pages/users/patient_dashboard/phq_assessments'
require './spec/support/pages/users/patient_dashboard/social_networking'

module Users
  # page object for the patient dashboard
  class PatientDashboard
    include RSpec::Matchers
    include Capybara::DSL
    include SharedMoodEmotionsViz
    include SharedActivitiesViz
    include Users::PatientDashboards::PHQAssessments
    include Users::PatientDashboards::SocialNetworking

    def initialize(patient_dashboard)
      @participant ||= patient_dashboard[:participant]
      @date ||= patient_dashboard[:date]
      @group ||= patient_dashboard[:group]
      @total_logins ||= patient_dashboard[:total_logins]
      @lesson_duration ||= patient_dashboard.fetch(:lesson_duration, 10)
      @most_recent_phq_score ||= patient_dashboard[:most_recent_phq_score]
    end

    def visible?
      sleep(1)
      has_css?('h3', text: 'General Patient Info')
    end

    def has_inactive_label?
      has_css?('.label-warning', text: 'Inactive')
    end

    def has_general_patient_info?
      within('.panel-default', text: 'General Patient Info') do
        week_num = if ENV['tfd']
                     20
                   elsif ENV['marigold']
                     5
                   else
                     8
                   end
        # this may be removed and everything uses ' Active'
        # when stylesheets are updated
        active_badge = if ENV['driver'] == 'poltergeist' && ENV['tfd']
                         ''
                       else
                         ' Active'
                       end
        has_text? "Started on: #{today.strftime('%A, %m/%d/%Y')}" \
                  "\n#{week_num} weeks from the start date is: " \
                  "#{(today + (week_num * 7)).strftime('%A, %m/%d/%Y')}" \
                  "\nStatus:#{active_badge} Currently in week 1" \
                  "\nLessons read this week: 1"
      end
    end

    def has_login_info?
      within('.panel-default', text: 'Login Info') do
        has_text?("Last Logged In: #{today.strftime('%A, %b %d %Y')}") &&
          has_text?("Logins Today: 1\nLogins during this treatment week: 1\n" \
                    'Total Logins: 1') &&
          has_text?('Last Activity Detected At: ' \
                    "#{today.strftime('%A, %b %d %Y')}") &&
          has_text?('Duration of Last Session: 10 minutes')
      end
    end

    def has_partial_login_info?
      within('.panel-default', text: 'Login Info') do
        has_text?("Last Logged In: #{@date.strftime('%A, %b %d %Y')}") &&
          has_text?("Total Logins: #{@total_logins}")
      end
    end

    def return_to_dashboard
      click_on 'Patient Dashboard'
      sleep(0.25)
    end

    def mood_emotions_viz
      find('#viz-container')
    end

    def has_mood_emotions_viz_visible?
      within(mood_emotions_viz) do
        has_css?('.title', text: 'Mood') &&
          has_css?('.title', text: 'Positive and Negative Emotions') &&
          has_css?('.bar', count: 2)
      end
    end

    def has_mood_data?
      find('#mood-container')
        .all('tr:nth-child(1)')[1]
        .has_text? "9 #{long_date(today)}"
    end

    def has_feelings_data?
      find('#feelings-container')
        .all('tr:nth-child(1)')[1]
        .has_text? "longing 2 #{long_date(today)}"
    end

    def has_login_data?
      find('#logins-container')
        .all('tr:nth-child(1)')[1]
        .has_text? long_date(today)
    end

    def has_lessons_data?
      within('#lessons-container') do
        table_row[1].has_text?('Do - Awareness Introduction') &&
          table_row[1].has_text?(long_date(today)) &&
          table_row[1].has_text?("#{@lesson_duration} minutes")
      end
    end

    def has_audio_access_data?
      within('#media-access-container') do
        table_row[1].has_text?("Audio! #{short_date(today)}" \
                               " #{long_date(today)}") &&
          table_row[1].has_text?('2 minutes')
      end
    end

    def has_activity_viz_visible?
      has_text? 'Daily Averages'
    end

    def select_activity_viz_from_body
      user_navigation.scroll_to_bottom
      within('h3', text: 'Activities visualization') do
        click_on 'Activities visualization'
      end
    end

    def view_activity_in_viz
      user_navigation.scroll_down
      within('.panel.panel-default', text: 'Parkour') { click_on 'Parkour' }
    end

    def has_activity_ratings_in_viz?
      find('.collapse.in').has_text? 'Predicted'
    end

    def on_three_day_view?
      has_text?((today - 1).strftime('%A, %m/%d'))
    end

    def has_activities_future_data?
      find('#activities-future-container')
        .find('tr', text: 'Going to school')
        .has_text? 'Going to school  2 6 Scheduled for ' \
                   "#{long_date(today + 2)}"
    end

    def has_completed_activities_past_data?
      within('#activities-past-container') do
        within('tr', text: 'Parkour') do
          has_text?('9 4') && has_text?(long_date(today - 1))
        end
      end
    end

    def has_incomplete_activities_past_data?
      within('#activities-past-container') do
        within('tr', text: 'Jogging') do
          click_on 'Noncompliance'
          find('.popover', match: :first)
          find('.popover.fade.right.in')
            .has_text? "Why was this not completed?\nI didn't have time"
        end
      end
    end

    def has_thoughts_viz_container?
      has_css?('#ThoughtVizContainer') ||
        has_text?('Not enough harmful thoughts yet exist for graphical display')
    end

    def select_thoughts_viz_from_body
      within('h3', text: 'Thoughts visualization') do
        click_on 'Thoughts visualization'
      end
    end

    def has_thought_viz_detail?
      find('.viz-clickable', text: 'Magnification or Catastro...').click
      has_text? 'Testing add a new thought'
    end

    def has_thoughts_data?
      find('#thoughts-container')
        .find('tr', text: 'Testing negative thought')
        .has_text? 'Testing negative thought Magnification or ' \
                   'Catastrophizing Example challenge Example ' \
                   "act-as-if #{long_date(today)}"
    end

    def has_messages_data?
      find('#messages-container')
        .find('tr', text: 'Test')
        .has_text? "Test message #{long_date(today)}"
    end

    def has_tasks_data?
      find('#tasks-container')
        .find('tr', text: 'Do - Planning Introduction')
        .has_text? "#{short_date(today + 1)} Incomplete"
    end

    private

    def user_navigation
      @user_navigation ||= Users::Navigation.new
    end

    def has_patient_data?(item, data)
      within(item) { has_text? data }
    end

    def table_row
      all('tr:nth-child(1)')
    end
  end
end
