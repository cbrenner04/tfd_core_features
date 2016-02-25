require './lib/pages/participants/navigation'

class Participants
  class Feel
    # page object for the Tracking mood module
    class TrackingMood
      include Capybara::DSL

      def initialize(mood)
        @rating ||= mood[:rating]
      end

      def open
        click_on 'Tracking Your Mood'
      end

      def rate_mood
        select @rating, from: 'mood[rating]'
        navigation.next
        find('.alert-success', text: 'Mood saved')
      end

      def finish
        navigation.scroll_to_bottom
        navigation.next
        has_text? 'Feeling Tracker Landing'
      end

      private

      def navigation
        @navigation ||= Participants::Navigation.new
      end
    end
  end
end
