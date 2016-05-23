require './lib/pages/users/navigation'
require './lib/pages/shared/activities_viz'
require './lib/pages/shared/mood_emotions_viz'

module Users
  # page object for the patient dashboard
  class PatientDashboard
    include Capybara::DSL
    include SharedMoodEmotionsViz
    include SharedActivitiesViz

    def initialize(patient_dashboard)
      @participant ||= patient_dashboard[:participant]
      @date ||= patient_dashboard[:date]
      @group ||= patient_dashboard[:group]
      @total_logins ||= patient_dashboard[:total_logins]
      @lesson_duration ||= patient_dashboard.fetch(:lesson_duration, 10)
    end

    def navigate_to_patient_dashboard
      click_on 'Arm 1'
      click_on @group
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
        user_navigation.confirm_with_js if ENV['safari'] || ENV['chrome']
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
      find('h3', text: 'General Patient Info')
    end

    def has_inactive_label?
      has_css?('.label-warning', text: 'Inactive')
    end

    def has_general_patient_info?
      within('.panel-default', text: 'General Patient Info') do
        weeks_later = ENV['tfd'] ? Date.today + (20 * 7) : Date.today + 56
        week_num = ENV['tfd'] ? 20 : 8
        has_text? "Started on: #{Date.today.strftime('%A, %m/%d/%Y')}" \
                  "\n#{week_num} weeks from the start date is: " \
                  "#{weeks_later.strftime('%A, %m/%d/%Y')}" \
                  "\nStatus: Active Currently in week 1" \
                  "\nLessons read this week: 1"
      end
    end

    def has_login_info_in_patients_list?
      within('#patients') do
        within('table#patients tr', text: @participant) do
          has_text?("#{@participant} 0 6") &&
            has_text?("#{@total_logins} #{@date.strftime('%b %d %Y')}")
        end
      end
    end

    def has_login_info?
      within('.panel-default', text: 'Login Info') do
        has_text?("Last Logged In: #{Date.today.strftime('%A, %b %d %Y')}") &&
          has_text?("Logins Today: 1\nLogins during this treatment week: 1\n" \
                    'Total Logins: 1') &&
          has_text?('Last Activity Detected At: ' \
                    "#{Date.today.strftime('%A, %b %d %Y')}") &&
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
    end

    def select_all_toc_links
      select_mood_emotions_viz_from_toc
      select_mood_from_toc
      select_feel_from_toc
      select_logins_from_toc
      select_lessons_from_toc
      select_audio_access_from_toc
      select_activities_future_from_toc
      select_activities_past_from_toc
      select_thoughts_from_toc
      select_messages_from_toc
      select_tasks_from_toc
    end

    def select_mood_emotions_viz_from_toc
      select_from_toc('Mood and Emotions Visualization')
    end

    def mood_emotions_viz
      '#viz-container'
    end

    def has_mood_emotions_viz_visible?
      within(mood_emotions_viz) do
        has_css?('.title', text: 'Mood') &&
          has_css?('.title', text: 'Positive and Negative Emotions') &&
          has_css?('.bar', count: 2)
      end
    end

    def select_mood_from_toc
      user_navigation.scroll_down
      find('.list-group').all('a', text: 'Mood')[1].click
    end

    def has_mood_data?
      find('#mood-container')
        .table_row[1]
        .has_text? "9 #{Date.today.strftime('%b %d %Y')}"
    end

    def select_feel_from_toc
      select_from_toc('Feelings')
    end

    def has_feelings_data?
      find('#feelings-container')
        .table_row[1]
        .has_text? "longing 2 #{Date.today.strftime('%b %d %Y')}"
    end

    def select_logins_from_toc
      select_from_toc('Logins')
    end

    def has_login_data?
      find('#logins-container')
        .table_row[1]
        .has_text? Date.today.strftime('%b %d %Y')
    end

    def select_lessons_from_toc
      select_from_toc('Lessons')
    end

    def has_lessons_data?
      within('#lessons-container') do
        table_row[1]
          .has_text?('Do - Awareness Introduction This is just the ' \
                     "beginning... #{Date.today.strftime('%b %d %Y')}") &&
          table_row[1].has_text?("#{@lesson_duration} minutes")
      end
    end

    def select_audio_access_from_toc
      select_from_toc('Audio Access')
    end

    def has_audio_access_data?
      within('#media-access-container') do
        table_row[1].has_text?("Audio! #{Date.today.strftime('%m/%d/%Y')}" \
                               " #{Date.today.strftime('%b %d %Y')}") &&
          table_row[1].has_text?('2 minutes')
      end
    end

    def select_activity_viz_from_toc
      select_from_toc('Activities visualization')
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
      within('.panel.panel-default', text: 'Parkour') { click_on 'Parkour' }
    end

    def has_activity_ratings_in_viz?
      find('.collapse.in').has_text? 'Predicted'
    end

    def on_three_day_view?
      has_text?((Date.today - 1).strftime('%A, %m/%d'))
    end

    def select_activities_future_from_toc
      select_from_toc('Activities - Future')
    end

    def has_activities_future_data?
      find('#activities-future-container')
        .find('tr', text: 'Going to school')
        .has_text? 'Going to school  2 6 Scheduled for ' \
                   "#{(Date.today + 2).strftime('%b %d %Y')}"
    end

    def select_activities_past_from_toc
      select_from_toc('Activities - Past')
    end

    def has_completed_activities_past_data?
      within('#activities-past-container') do
        within('tr', text: 'Parkour') do
          has_text?('9 4') &&
            has_text?((Date.today - 1).strftime('%b %d %Y'))
        end
      end
    end

    def has_incomplete_activities_past_data?
      within('#activities-past-container') do
        within('tr', text: 'Jogging') do
          click_on 'Noncompliance'
          find('.popover.fade.right.in')
            .has_text? "Why was this not completed?\nI didn't have time"
        end
      end
    end

    def select_thoughts_viz_from_toc
      select_from_toc('Thoughts visualization')
    end

    def has_thoughts_viz_container?
      has_css?('#ThoughtVizContainer')
    end

    def select_thoughts_viz_from_body
      2.times { user_navigation.scroll_down }
      within('h3', text: 'Thoughts visualization') do
        click_on 'Thoughts visualization'
      end
    end

    def has_thought_viz_detail?
      find('.viz-clickable', text: 'Magnification or Catastro...').click
      has_text? 'Testing add a new thought'
    end

    def select_thoughts_from_toc
      user_navigation.scroll_down
      find('.list-group').all('a', text: 'Thoughts')[1].click
    end

    def has_thoughts_data?
      find('#thoughts-container')
        .find('tr', text: 'Testing negative thought')
        .has_text? 'Testing negative thought Magnification or ' \
                   'Catastrophizing Example challenge Example ' \
                   "act-as-if #{Date.today.strftime('%b %d %Y')}"
    end

    def select_messages_from_toc
      select_from_toc('Messages')
    end

    def has_messages_data?
      find('#messages-container')
        .find('tr', text: 'Test')
        .has_text? "Test message #{Date.today.strftime('%b %d %Y')}"
    end

    def select_tasks_from_toc
      select_from_toc('Tasks')
    end

    def has_tasks_data?
      find('#tasks-container')
        .find('tr', text: 'Do - Planning Introduction')
        .has_text? "#{(Date.today + 1).strftime('%m/%d/%Y')} Incomplete"
    end

    def click_all_links_in_tool_use_table
      within('.table.table-hover', text: 'Tool Use') do
        ['Lessons Read', 'Moods', 'Thoughts', 'Activities Planned',
         'Activities Monitored', 'Activities Reviewed and Completed',
         'Activities Reviewed and Incomplete'].each do |link|
          click_on link
        end
      end
    end

    def click_all_links_in_social_activity_table
      2.times { user_navigation.scroll_down }
      within('.table.table-hover', text: 'Social Activity') do
        ['Likes', 'Nudges', 'Comments', 'Goals', '"On My Mind" Statements']
          .each do |link|
          click_on link
        end
      end
    end

    def has_tool_use_data?
      within('.table.table-hover', text: 'Tool Use') do
        content_1 = ['Tool Use  Today Last 7 Days Totals', 'Lessons Read 1 1 1']
        content_2 = ['Moods 1 1 1', 'Thoughts 3 3 3',
                     'Activities Monitored 0 0 0', 'Activities Planned 1 4 4',
                     'Activities Reviewed and Completed 0 1 1',
                     'Activities Reviewed and Incomplete 0 1 1']
        (0..1).zip(content_1).all? do |row, content|
          has_patient_data?(table_row[row], content)
        end && (2..7).zip(content_2).all? do |row, content|
          has_patient_data?("tr:nth-child(#{row})", content)
        end
      end
    end

    def has_social_activity_data?
      within('.table.table-hover', text: 'Social Activity') do
        data = ['Nudges 1 1 1', 'Comments 0 0 1', 'Goals 0 0 1',
                '"On My Mind" Statements 0 0 1']
        has_patient_data?(table_row[0],
                          'Social Activity Today Last 7 Days Totals') &&
          has_patient_data?(table_row[1], 'Likes 0 0 1') &&
          (2..5).zip(data).all? do |i, d|
            has_patient_data?("tr:nth-child(#{i})", d)
          end
      end
    end

    def has_likes_data?
      within('#likes-container', text: 'Item Liked') do
        table_row[1].has_text?('Goal: participant63, Get crazy ' \
                  "#{(Date.today - 24).strftime('%b %d %Y')}") &&
          table_row[1].has_text?('2')
      end
    end

    def has_goals_data?
      within('#goals-container', text: 'Goals') do
        table_row[1].has_text?('do something  Incomplete ' \
                               "#{(Date.today - 30).strftime('%b %d %Y')}") &&
          table_row[1].has_text?((Date.today - 26).strftime('%m/%d/%Y')) &&
          table_row[1].has_text?((Date.today - 34).strftime('%b %d %Y')) &&
          table_row[1].has_text?('1 0 0')
      end
    end

    def has_comments_data?
      within('#comments-container') do
        table_row[1]
          .has_text?('Great activity! Activity: participant62, ' \
                     "Jumping, #{(Date.today - 18).strftime('%b %d %Y')}") &&
          table_row[1].has_text?('3')
      end
    end

    def has_nudges_initiated_data?
      within('.panel.panel-default', text: 'Nudges Initiated') do
        table_row[1].has_text?(Date.today.strftime('%b %d %Y')) &&
          table_row[1].has_text?('participant62')
      end
    end

    def has_nudges_received_data?
      within('.panel.panel-default', text: 'Nudges Received') do
        table_row[1].has_text?(Date.today.strftime('%b %d %Y')) &&
          table_row[1].has_text?('participant65')
      end
    end

    def has_on_the_mind_data?
      within('#on-my-mind-container') do
        table_row[1].has_text?("I'm feeling great! " \
                               "#{(Date.today - 14).strftime('%b %d %Y')}") &&
          table_row[1].has_text?('4 0 0')
      end
    end

    private

    def user_navigation
      @user_navigation ||= Users::Navigation.new
    end

    def select_from_toc(link)
      user_navigation.scroll_down
      find('.list-group').find('a', text: link).click
    end

    def has_patient_data?(item, data)
      within(item) { has_text? data }
    end

    def table_row
      all('tr:nth-child(1)')
    end
  end
end