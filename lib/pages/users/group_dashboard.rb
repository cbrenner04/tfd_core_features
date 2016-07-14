# frozen_string_literal: true
module Users
  # page object for Group dashboard
  class GroupDashboard
    include Capybara::DSL

    def open
      click_on 'Group Dashboard'
      visible?
    end

    def visible?
      has_css?('.panel', text: 'Group Summary')
    end

    def has_group_summary_data?
      within summary_panel do
        summary_data = ['logins  7 10 4 3 5 0 0 0', 'thoughts  1 0 1 1 1 0 0 0',
                        'activities monitored 0 0 0 0 0 0 0 0',
                        'activities planned  0 0 0 0 0 1 1 0',
                        'activities reviewed and complete  1 0 1 0 0 0 0 0',
                        'activities reviewed and incomplete  0 0 0 0 0 0 0 0',
                        'on the mind statements  0 0 0 1 0 0 0 0',
                        'comments  0 0 2 0 1 0 0 0', 'goals  1 2 0 0 0 0 0 0',
                        'likes  1 2 1 0 1 0 0 0']
        (2..9).zip(summary_data).all? do |row, data|
          update_data = ENV['marigold'] ? data.slice(0..-7) : data
          has_group_data?("tr:nth-child(#{row})", update_data)
        end
      end
    end

    def click_each_link
      within summary_panel do
        ['logins', 'thoughts', 'activities monitored', 'activities planned',
         'on the mind statements', 'comments', 'goals', 'likes',
         'activities reviewed and complete',
         'activities reviewed and incomplete'].each do |link|
          click_on link
        end
      end
    end

    def has_logins_by_week?
      within('.panel', text: 'Logins By Week') do
        summary_data = ['First 4 3 0 2 2', 'Second  2 1 1 1 2',
                        'Third  1 0 1 0 1', 'Fourth  0 6 1 0 0',
                        'Fifth  0 0 1 0 0']
        (2..6).zip(summary_data).all? do |row, data|
          has_group_data?("tr:nth-child(#{row})", data)
        end
      end
    end

    def has_lesson_summary_data?
      2.times { user_navigation.scroll_down }
      within('.panel', text: 'Lesson View Summary') do
        lessons = ['Do - Awareness Introduction', 'Do - Planning Introduction',
                   'Think - Identifying Conclusion']
        number_completed = ['2 of 5 COMPLETE', '1 of 5 COMPLETE',
                            '3 of 5 COMPLETE']
        completed_participants = ['Second Third', 'Second',
                                  'First Second Third']
        incomplete_participants = ['First Fourth Fifth',
                                   'First Third Fourth Fifth', 'Fourth Fifth']
        lessons.zip(
          number_completed, completed_participants, incomplete_participants
        ).all? do |lesson, number, completed, incomplete|
          user_navigation.scroll_down
          within('tr', text: lesson) do
            has_text?(number) &&
              has_participants?('Complete', completed) &&
              has_participants?('Incomplete', incomplete)
          end
        end
      end
    end

    def has_no_moderator_in_incomplete_lessons?
      moderator = if ENV['tfdso']
                    'ThinkFeelDo'
                  elsif ENV['sunnyside']
                    'Sunnyside'
                  elsif ENV['marigold']
                    'Marigold'
                  end
      2.times { user_navigation.scroll_down }
      within('.panel', text: 'Lesson View Summary') do
        within('tr', text: 'Do - Awareness Introduction') do
          click_on 'View Incomplete Participants'
          has_no_text? moderator
        end
      end
    end

    def has_thoughts_data?
      navigate_to_panel('thoughts')
      within('#thoughts-container') do
        find('.sorting', text: 'Week').click
        rows = [all('tr:nth-child(1)')[1], 'tr:nth-child(2)']
        row_content = ['First I am no good  Labeling and Mislabeling  ' \
                       'I did good at work today  I am good  ' \
                       "#{long_date(today - 34)}",
                       'First This is stupid  Fortune Telling  ' \
                       'It could be useful  I should try it out  ' \
                       "#{long_date(today - 20)}"]
        counts = ['1 1 1', '3 0 0']
        rows.zip(row_content, counts).all? do |row, content, count|
          within(row) { has_text?(content) && has_text?(count) }
        end
      end
    end

    def has_activities_past_data?
      navigate_to_panel('activities reviewed and complete')
      within('#activities-past-container') do
        find('.sorting', text: 'Week').click
        row = [all('tr:nth-child(1)')[1], 'tr:nth-child(2)']
        content_1 = ['First Running reviewed and complete ' \
                     "#{long_date(today - 33)}",
                     'Second Jumping reviewed and complete ' \
                     "#{long_date(today - 20)}"]
        content_2 = ["6 5 6 8 #{long_date(today - 34)}",
                     "6 9 9 3 #{long_date(today - 21)}"]
        content_3 = ['1 0 0', '3 1 1']
        row.zip(content_1, content_2, content_3).all? do |r, c1, c2, c3|
          within(r) { has_text?(c1) && has_text?(c2) && has_text?(c3) }
        end
      end
    end

    def has_activities_future_data?
      navigate_to_panel('activities planned')
      within('#activities-planned-container') do
        find('.sorting', text: 'Week').click
        row = [all('tr:nth-child(1)')[1], 'tr:nth-child(2)']
        content_1 = [
          "Third Go to movie #{long_date(today + 4)}",
          "Fourth Yelling #{long_date(today + 7)}"
        ]
        content_2 = ["9 7 #{long_date(today - 1)}",
                     "0 2 #{long_date(today - 1)}"]
        content_3 = ['5 1 1', '5 0 0']
        row.zip(content_1, content_2, content_3).all? do |r, c1, c2, c3|
          within(r) { has_text?(c1) && has_text?(c2) && has_text?(c3) }
        end
      end
    end

    def has_on_the_mind_data?
      navigate_to_panel('on the mind statements')
      within('#on-my-mind-container') do
        find('.sorting', text: 'Week').click
        within all('tr:nth-child(1)')[1] do
          has_text?("First I'm feeling great!  #{long_date(today - 14)}") &&
            has_text?('4 0 0')
        end
      end
    end

    def has_comments_data?
      navigate_to_panel('comments')
      within('#comments-container') do
        find('.sorting', text: 'Created At').click
        row = [all('tr:nth-child(1)')[1], 'tr:nth-child(2)', 'tr:nth-child(3)']
        content = ['Second Nice job on identifying the pattern! Thought: ' \
                   "participant61, I am no good #{long_date(today - 20)}",
                   'First Great activity! Activity: participant62, Jumping, ' \
                   "#{long_date(today - 18)}",
                   'Fifth That sounds like fun! Activity: participant63, ' \
                   "Go to movie, #{long_date(today - 1)}"]
        row.zip(content, [1, 3, 5]).all? do |r, c, n|
          within(r) { has_text?(c) && has_text?(n) }
        end
      end
    end

    def has_goal_data?
      navigate_to_panel('goals')
      within('#goals-container') do
        find('.sorting', text: 'Created Date').click
        rows = [all('tr:nth-child(1)')[1], 'tr:nth-child(2)', 'tr:nth-child(3)']
        content_1 = ["First do something  incomplete #{long_date(today - 30)} ",
                     'Third Get crazy incomplete not deleted ' \
                     "#{short_date(today + 3)} ",
                     "Fifth go to work #{long_date(today - 12)} "]
        content_2 = [short_date(today - 26), '',
                     "not deleted #{short_date(today - 14)}"]
        content_3 = [long_date(today - 34), long_date(today - 26),
                     long_date(today - 24)]
        counts = ['1 0 0', '2 1 0', '2 1 0']
        rows
          .zip(content_1, content_2, content_3, counts)
          .all? do |row, c1, c2, c3, count|
          within(row) do
            has_text?(c1) && has_text?(c2) && has_text?(c3) && has_text?(count)
          end
        end
      end
    end

    def has_like_data?
      user_navigation.scroll_down
      navigate_to_panel('likes')
      within('#likes-container') do
        find('.sorting', text: 'Week').click
        rows = [all('tr:nth-child(1)')[1], 'tr:nth-child(2)', 'tr:nth-child(3)',
                'tr:nth-child(4)', 'tr:nth-child(5)']
        content = ['Second SocialNetworking::SharedItem Thought: I am no ' \
                   "good #{long_date(today - 33)}",
                   'First SocialNetworking::SharedItem  Goal: Get crazy ' \
                   "#{long_date(today - 24)}",
                   'Second SocialNetworking::SharedItem  Goal: go to work ' \
                   "#{long_date(today - 24)}",
                   'Third SocialNetworking::SharedItem  Activity: Jumping ' \
                   "#{long_date(today - 19)}",
                   'Fifth SocialNetworking::SharedItem  Activity: Go to ' \
                   "movie #{long_date(today - 1)}"]
        rows.zip(content, [1, 2, 2, 3, 5]).all? do |row, text, count|
          within(row) { has_text?(text) && has_text?(count) }
        end
      end
    end

    private

    def summary_panel
      find('.panel', text: 'Group Summary')
    end

    def has_group_data?(item, data)
      within(item) { has_text? data }
    end

    def has_participants?(type, participants)
      click_on "View #{type} Participants"
      has_text? participants
    end

    def navigate_to_panel(panel)
      within(summary_panel) { click_on panel }
    end
  end
end
