require './lib/pages/participants/do_tool'
require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'

class Participants
  class DoTool
    # page object for the Reviewing module
    class Reviewing
      include Capybara::DSL

      def initialize(reviewing_arry)
        @activity ||= reviewing_arry[:activity]
        @pleasure ||= reviewing_arry[:pleasure]
        @accomplishment ||= reviewing_arry[:accomplishment]
        @non_compliance_reason ||= reviewing_arry[:non_compliance_reason]
        @predictied_pleasure ||= reviewing_arry[:predictied_pleasure]
        @predicted_accomplishment ||= reviewing_arry[:predicted_accomplishment]
      end

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
        navigation.next
        find('h1', text: 'Let\'s do this...')
        navigation.next
      end

      def review_completed_activity
        find('.btn.btn-success').click
        select @pleasure.to_s, from: 'activity[actual_pleasure_intensity]'
        select @accomplishment.to_s,
               from: 'activity[actual_accomplishment_intensity]'
        navigation.scroll_down
      end

      def has_another_activity_to_review?
        has_text? 'You said you were going to'
      end

      def review_incomplete_activity
        find('.btn.btn-danger').click
        fill_in 'activity[noncompliance_reason]', with: @non_compliance_reason
      end

      def find_in_feed
        social_networking
          .find_feed_item("Reviewed & Completed an Activity: #{@activity}")
      end

      def visible?
        has_text? "Reviewed & Completed an Activity: #{@activity}"
      end

      def has_feed_item_detail?
        within('.list-group-item.ng-scope',
               text: "Reviewed & Completed an Activity: #{@activity}") do
          2.times { navigation.scroll_down }
          social_networking.open_detail
          has_text? "start: #{@start_time.strftime('%b. %-d, %Y at %-l')}"
          has_text? "end: #{@end_time.strftime('%b. %-d, %Y at %-l')}"
          has_text? "predicted accomplishment: #{@predicted_accomplishment}\n" \
                    "predicted pleasure: #{@predictied_pleasure}\n" \
                    "actual accomplishment: #{@accomplishment}\n" \
                    "actual pleasure: #{@pleasure}"
        end
      end

      private

      def do_tool
        @do_tool ||= Participants::DoTool.new
      end

      def navigation
        @navigation ||= Participants::Navigation.new
      end

      def social_networking
        @social_networking ||= Participants::SocialNetworking.new
      end
    end
  end
end
