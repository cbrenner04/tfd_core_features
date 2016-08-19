# frozen_string_literal: true
require './lib/pages/participants/navigation'

module Participants
  module FeelModules
    # page object for Tracking Mood & Emotions module
    class TrackingMoodEmotions
      include RSpec::Matchers
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

      def create_emotion_with_more_than_255_characters
        fill_in 'Emotion', with: more_than_255_characters
        select 'positive', from: 'emotional_rating_is_positive'
        select '3', from: 'emotional_rating[rating]'
        submit
      end

      def has_emotion_with_255_characters?
        participant_navigation.scroll_down
        positive_bar = all('.bar.positive').last
        if ENV['driver'] == 'poltergeist'
          positive_bar.trigger('click')
        else
          positive_bar.click
        end
        actual_text = find('.modal-content').text
        expect(actual_text)
          .to include(more_than_255_characters[0..254].downcase)
      end

      def submit
        # this may end up being true for all apps
        if (ENV['tfdso'] || ENV['tfd']) && ENV['driver'] == 'poltergeist'
          find('input[type = "submit"]').trigger('click')
        else
          participant_navigation.next
        end
        sleep(1) # wait for page since the alert below can be on current page
        find('.alert-success', text: 'Emotional Rating saved')
      end

      def finish
        find('text', text: 'Mood*')
        participant_navigation.scroll_to_bottom
        participant_navigation.next
        find('small', text: 'Feeling Tracker Landing')
      end

      private

      def participant_navigation
        @participant_navigation ||= Participants::Navigation.new
      end

      def more_than_255_characters
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus ' \
        'eleifend interdum lorem et fringilla. Duis eros magna, scelerisque ' \
        'in dictum quis, viverra quis mi. Donec et magna et arcu vulputate ' \
        'vehicula eu in tellus. Morbi luctus urna eget ipsum amet. Over the ' \
        'line!'
      end
    end
  end
end
