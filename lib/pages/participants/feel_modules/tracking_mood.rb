require './lib/pages/participants/navigation'

module Participants
  module FeelModules
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
        participant_navigation.next
        find('.alert-success', text: 'Mood saved')
      end

      def finish
        participant_navigation.scroll_to_bottom
        participant_navigation.next
        has_text? 'Feeling Tracker Landing'
      end

      private

      def participant_navigation
        @participant_navigation ||= Participants::Navigation.new
      end
    end
  end
end
