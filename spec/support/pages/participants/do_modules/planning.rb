# frozen_string_literal: true
module Participants
  module DoModules
    # page object for the Planning module
    class Planning
      include Capybara::DSL

      def open
        click_on '#2 Planning'
      end

      def has_first_slide_visible?
        has_text? 'The last few times you were here...'
      end

      def has_planning_form_visible?
        has_text? 'We want you to plan one fun thing'
      end

      def plan(activity:, pleasure:, accomplishment:)
        find('#new_activity_radio')
        participant_navigation.scroll_down
        find('#new_activity_radio').click
        fill_in 'activity_activity_type_new_title', with: activity
        participant_navigation.scroll_down
        find('.btn-date_picker').click
        pick_tomorrow
        do_tool.choose_rating('pleasure_0', pleasure)
        do_tool.choose_rating('accomplishment_0', accomplishment)
      end

      def move_to_review
        find('h1', text: 'OK...')
        click_on 'Next'
      end

      def has_review_page_visible?
        find('h2', text: 'Your Planned Activities')
      end

      def has_entries?(entries)
        find('#previous_activities').has_css?('tr', count: entries)
      end

      def finish
        participant_navigation.next
        find('h1', text: 'Do Landing')
      end

      def find_in_feed(activity)
        social_networking.find_feed_item(activity)
      end

      def has_activity_visible?(activity)
        has_text? activity
      end

      def has_timestamp?(activity:, timestamp:)
        find('.list-group-item.ng-scope', text: activity).has_text? timestamp
      end

      private

      def pick_tomorrow
        tomorrow = (today + 1).strftime('%-e')
        within('#ui-datepicker-div') do
          unless has_no_css?('.ui-datepicker-unselectable.ui-state-disabled',
                             text: tomorrow)
            find('.ui-datepicker-next.ui-corner-all').click
          end
          click_on tomorrow
        end
      end
    end
  end
end
