# frozen_string_literal: true
require './spec/support/pages/users/navigation'

module Users
  module PatientDashboards
    # module for social networking portion of Patient Dashboard
    module SocialNetworking
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
          ['Likes', 'Nudges', 'Comments', 'Goals',
           '"On My Mind" Statements'].each { |link| click_on link }
        end
      end

      def has_tool_use_data?
        within('.table.table-hover', text: 'Tool Use') do
          content_1 = ['Tool Use  Today Last 7 Days Totals',
                       'Lessons Read 1 1 1']
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
                    "#{long_date(today - 24)}") &&
            table_row[1].has_text?('2')
        end
      end

      def has_goals_data?
        within('#goals-container', text: 'Goals') do
          table_row[1].has_text?('do something Incomplete ' \
                                 "#{long_date(today - 30)}") &&
            table_row[1].has_text?(short_date(today - 26)) &&
            table_row[1].has_text?(long_date(today - 34)) &&
            table_row[1].has_text?('1 0 0')
        end
      end

      def has_comments_data?
        within('#comments-container') do
          table_row[1]
            .has_text?('Great activity! Activity: participant62, ' \
                       "Jumping, #{long_date(today - 18)}") &&
            table_row[1].has_text?('3')
        end
      end

      def has_nudges_initiated_data?
        within('.panel.panel-default', text: 'Nudges Initiated') do
          table_row[1].has_text?(long_date(today)) &&
            table_row[1].has_text?('participant62')
        end
      end

      def has_nudges_received_data?
        within('.panel.panel-default', text: 'Nudges Received') do
          table_row[1].has_text?(long_date(today)) &&
            table_row[1].has_text?('participant65')
        end
      end

      def has_on_the_mind_data?
        within('#on-my-mind-container') do
          table_row[1].has_text?("I'm feeling great! " \
                                 "#{long_date(today - 14)}") &&
            table_row[1].has_text?('4 0 0')
        end
      end
    end
  end
end
