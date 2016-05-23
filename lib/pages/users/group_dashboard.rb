module Users
  # page object for Group dashboard
  class GroupDashboard
    include Capybara::DSL

    def open
      click_on 'Group Dashboard'
      summary_panel
    end

    def has_group_summary_data?
      within summary_panel do
        summary_data = ['logins  7 10 4 3 5 0 0 0', 'thoughts  1 0 1 1 1 0 0 0',
                        'activities past  1 0 1 0 0 0 0 0',
                        # 'activities future  0 0 0 0 2 0 0 0',
                        'activities future  0 0 0 0 0 1 1 0',
                        'on the mind statements  0 0 0 1 0 0 0 0',
                        'comments  0 0 2 0 1 0 0 0', 'goals  1 2 0 0 0 0 0 0',
                        'likes  1 2 1 0 1 0 0 0']
        (2..9).zip(summary_data).all? do |row, data|
          has_group_data?("tr:nth-child(#{row})", data)
        end
      end
    end

    def click_each_link
      within summary_panel do
        ['logins', 'thoughts', 'activities past', 'activities future',
         'on the mind statements', 'comments', 'goals', 'likes'].each do |link|
          click_on link
        end
      end
    end

    def has_logins_by_week?
      within('.panel', text: 'Logins By Week') do
        summary_data = ['First 4 3 0 2 2 0 0 0', 'Second  2 1 1 1 2 0 0 0',
                        'Third  1 0 1 0 1 0 0 0', 'Fourth  0 6 1 0 0 0 0 0',
                        'Fifth  0 0 1 0 0 0 0 0']
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

    def has_thoughts_data?
      navigate_to_panel('thoughts')
      within('#thoughts-container') do
        find('.sorting', text: 'Week').click
        rows = [all('tr:nth-child(1)')[1], 'tr:nth-child(2)']
        row_content = ['First I am no good  Labeling and Mislabeling  ' \
                       'I did good at work today  I am good  ' \
                       "#{(Date.today - 34).strftime('%b %d %Y')}",
                       'First This is stupid  Fortune Telling  ' \
                       'It could be useful  I should try it out  ' \
                       "#{(Date.today - 20).strftime('%b %d %Y')}"]
        counts = ['1 1 1', '3 0 0']
        rows.zip(row_content, counts).all? do |row, content, count|
          within(row) { has_text?(content) && has_text?(count) }
        end
      end
    end

    def has_activities_past_data?
      navigate_to_panel('activities past')
      within('#activities-past-container') do
        find('.sorting', text: 'Week').click
        row = [all('tr:nth-child(1)')[1], 'tr:nth-child(2)']
        content_1 = ['First Running reviewed and complete ' \
                     "#{(Date.today - 33).strftime('%b %d %Y')}",
                     'Second Jumping reviewed and complete ' \
                     "#{(Date.today - 20).strftime('%b %d %Y')}"]
        content_2 = ["6 5 6 8 #{(Date.today - 34).strftime('%b %d %Y')}",
                     "6 9 9 3 #{(Date.today - 21).strftime('%b %d %Y')}"]
        content_3 = ['1 0 0', '3 1 1']
        row.zip(content_1, content_2, content_3).all? do |r, c1, c2, c3|
          within(r) { has_text?(c1) && has_text?(c2) && has_text?(c3) }
        end
      end
    end

    def has_activities_future_data?
      navigate_to_panel('activities future')
      within('#activities-planned-container') do
        find('.sorting', text: 'Week').click
        row = [all('tr:nth-child(1)')[1], 'tr:nth-child(2)']
        content_1 = [
          "Third Go to movie #{(Date.today + 4).strftime('%b %d %Y')}",
          "Fourth Yelling #{(Date.today + 7).strftime('%b %d %Y')}"
        ]
        content_2 = ["9 7 #{(Date.today - 1).strftime('%b %d %Y')}",
                     "0 2 #{(Date.today - 1).strftime('%b %d %Y')}"]
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
          has_text?("First I'm feeling great!  " \
                    "#{(Date.today - 14).strftime('%b %d %Y')}") &&
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
                   'participant61, I am no good ' \
                   "#{(Date.today - 20).strftime('%b %d %Y')}",
                   'First Great activity! Activity: participant62, Jumping, ' \
                   "#{(Date.today - 18).strftime('%b %d %Y')}",
                   'Fifth That sounds like fun! Activity: participant63, ' \
                   "Go to movie, #{(Date.today - 1).strftime('%b %d %Y')}"]
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
        content_1 = ['First do something  incomplete ' \
                     "#{(Date.today - 30).strftime('%b %d %Y')} ",
                     'Third Get crazy incomplete not deleted ' \
                     "#{(Date.today + 3).strftime('%m/%d/%Y')} ",
                     'Fifth go to work ' \
                     "#{(Date.today - 12).strftime('%b %d %Y')} "]
        content_2 = [(Date.today - 26).strftime('%m/%d/%Y'), '',
                     "not deleted #{(Date.today - 14).strftime('%m/%d/%Y')}"]
        content_3 = [(Date.today - 34).strftime('%b %d %Y'),
                     (Date.today - 26).strftime('%b %d %Y'),
                     (Date.today - 24).strftime('%b %d %Y')]
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
                   "good #{(Date.today - 33).strftime('%b %d %Y')}",
                   'First SocialNetworking::SharedItem  Goal: Get crazy ' \
                   "#{(Date.today - 24).strftime('%b %d %Y')}",
                   'Second SocialNetworking::SharedItem  Goal: go to work ' \
                   "#{(Date.today - 24).strftime('%b %d %Y')}",
                   'Third SocialNetworking::SharedItem  Activity: Jumping ' \
                   "#{(Date.today - 19).strftime('%b %d %Y')}",
                   'Fifth SocialNetworking::SharedItem  Activity: Go to ' \
                   "movie #{(Date.today - 1).strftime('%b %d %Y')}"]
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
