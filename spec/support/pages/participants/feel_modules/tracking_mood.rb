# frozen_string_literal: true
module Participants
  module FeelModules
    # page object for the Tracking mood module
    class TrackingMood
      include Capybara::DSL

      def open
        click_on 'Tracking Your Mood'
      end

      def rate_mood(rating)
        select rating, from: 'mood[rating]'
        participant_navigation.next
        find('.alert-success', text: 'Mood saved')
      end

      def finish
        participant_navigation.scroll_to_bottom
        participant_navigation.next
        has_text? 'Feeling Tracker Landing'
      end
    end
  end
end
