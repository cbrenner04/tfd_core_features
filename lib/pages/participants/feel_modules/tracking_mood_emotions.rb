require './lib/pages/participants/navigation'

module Participants
  module FeelModules
    # page object for Tracking Mood & Emotions module
    class TrackingMoodEmotions
      include Capybara::DSL

      def initialize(mood_emotions)
        @mood_rating ||= mood_emotions[:mood_rating]
        @emotion ||= mood_emotions[:emotion]
        @emotion_type ||= mood_emotions[:emotion_type]
        @emotion_rating ||= mood_emotions[:emotion_rating]
      end

      def unread?
        has_css?('.list-group-item-unread',
                 text: 'Tracking Your Mood & Emotions')
      end

      def read?
        has_css?('.list-group-item-read',
                 text: 'Tracking Your Mood & Emotions')
      end

      def open
        click_on 'Tracking Your Mood & Emotions'
      end

      def rate_mood
        select @mood_rating, from: 'mood[rating]'
        participant_navigation.next
        find('.alert-info',
             text: "You just rated your mood as a #{@mood_rating} (Good)")
      end

      def rate_emotion
        select @emotion, from: 'emotional_rating_emotion_id'
        select @emotion_type, from: 'emotional_rating_is_positive'
        select @emotion_rating, from: 'emotional_rating[rating]'
      end

      def add_and_rate_emotion
        participant_navigation.scroll_down
        click_on 'Add Emotion'
        within '#subcontainer-1' do
          fill_in 'emotional_rating_name', with: @emotion
          select @emotion_type, from: 'emotional_rating_is_positive'
          select @emotion_rating, from: 'emotional_rating[rating]'
        end
      end

      def submit
        participant_navigation.next
        find('.alert-success', text: 'Emotional Rating saved')
      end

      def finish
        participant_navigation.scroll_to_bottom
        participant_navigation.next
        find('small', text: 'Feeling Tracker Landing')
      end

      private

      def participant_navigation
        @participant_navigation ||= Participants::Navigation.new
      end
    end
  end
end