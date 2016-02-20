require './lib/pages/participants/navigation'

class Participants
  class DoTool
    # page object for the Reviewing module
    class Reviewing
      include Capybara::DSL

      def initialize(reviewing_arry)
        @pleasure ||= reviewing_arry[:pleasure]
        @accomplishment ||= reviewing_arry[:accomplishment]
        @non_compliance_reason ||= reviewing_arry[:non_compliance_reason]
      end

      def open
        click_on '#3 Doing'
      end

      def move_to_review
        navigation.next
        find('h1', text: 'Let\'s do this...')
        navigation.next
      end

      def review_completed_activity
        find('.btn.btn-success').click
        select "#{@pleasure}", from: 'activity[actual_pleasure_intensity]'
        select "#{@accomplishment}",
               from: 'activity[actual_accomplishment_intensity]'
        navigation.scroll_down
        social_networking.accept_social
        has_text? 'Activity saved'
      end

      def has_another_activity_to_review?
        has_text? 'You said you were going to'
      end

      def review_incomplete_activity
        find('.btn.btn-danger').click
        fill_in 'activity[noncompliance_reason]', with: @non_compliance_reason
        social_networking.accept_social
        expect(page).to have_content 'Activity saved'
      end

      private

      def navigation
        @navigation ||= Participants::Navigation.new
      end

      def social_networking
        @social_networking ||= Participants::SocialNetworking.new
      end
    end
  end
end
