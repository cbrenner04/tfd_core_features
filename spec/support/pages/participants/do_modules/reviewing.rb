# frozen_string_literal: true
module Participants
  module DoModules
    # page object for the Reviewing module
    class Reviewing
      include Capybara::DSL

      def open
        click_on '#3 Doing'
      end

      def has_first_slide_visible?
        has_text? 'Welcome back!'
      end

      def has_nothing_to_do_message?
        has_text? 'It doesn\'t look like there are any ' \
                  'activities for you to review at this time'
      end

      def move_to_review
        participant_navigation.next
        find('h1', text: 'Let\'s do this...')
        participant_navigation.next
      end

      def review_completed_activity(pleasure:, accomplishment:)
        find('.btn.btn-success').click
        select pleasure, from: 'activity[actual_pleasure_intensity]'
        select accomplishment,
               from: 'activity[actual_accomplishment_intensity]'
        participant_navigation.scroll_down
      end

      def has_another_activity_to_review?
        has_text? 'You said you were going to'
      end

      def review_incomplete_activity(non_compliance_reason)
        find('.btn.btn-danger').click
        fill_in 'activity[noncompliance_reason]', with: non_compliance_reason
      end

      def find_in_feed(activity)
        social_networking
          .find_feed_item("Reviewed & Completed an Activity: #{activity}")
      end

      def visible?(activity)
        has_text? "Reviewed & Completed an Activity: #{activity}"
      end

      def has_feed_item_detail?(feed_item_details)
        within('.list-group-item.ng-scope',
               text: 'Reviewed & Completed an Activity: ' \
                     "#{feed_item_details[:activity]}") do
          2.times { participant_navigation.scroll_down }
          social_networking.open_detail
          time_format = '%b. %-d, %Y at %-l'
          has_text?(
            "start: #{feed_item_details[:start_time].strftime(time_format)}"
          ) &&
            has_text?(
              "end: #{feed_item_details[:end_time].strftime(time_format)}"
            ) &&
            has_text?(
              'predicted accomplishment: ' \
              "#{feed_item_details[:predicted_accomplishment]}\n" \
              "predicted pleasure: #{feed_item_details[:predicted_pleasure]}" \
              "\nactual accomplishment: #{feed_item_details[:accomplishment]}" \
              "\nactual pleasure: #{feed_item_details[:pleasure]}"
            )
        end
      end

      def has_nonsocial_incomplete_item?
        social_networking
          .find_feed_item('Reviewed and did not complete an Activity')
        find('.list-group-item',
             text: 'Reviewed and did not complete an Activity')
          .has_no_css?('a', text: 'More')
      end
    end
  end
end
