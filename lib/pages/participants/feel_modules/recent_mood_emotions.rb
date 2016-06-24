# frozen_string_literal: true
require './lib/pages/shared/mood_emotions_viz'

module Participants
  module FeelModules
    # page object for Your Recent Moods & Emotions module
    class RecentMoodsEmotions
      include Capybara::DSL
      include SharedMoodEmotionsViz

      def initialize(recent_mood_emotions)
        @mood_count ||= recent_mood_emotions[:mood_count]
        @emotions_count ||= recent_mood_emotions[:emotions_count]
        @mood_type ||= recent_mood_emotions[:mood_type]
        @emotion_type ||= recent_mood_emotions[:emotion_type]
      end

      def open
        click_on 'Your Recent Moods & Emotions'
        find('h1', text: 'Your Recent Moods & Emotions')
      end

      def has_moods_in_graph?
        find('#mood').has_css?('.title', text: 'Mood*') &&
          has_css?(".#{@mood_type}", count: @mood_count)
      end

      def has_emotions_in_graph?
        find('#emotions')
          .has_css?('.title', text: 'Positive and Negative Emotions*') &&
          has_css?(".#{@emotion_type}", count: @emotions_count)
      end

      def open_mood_modal
        find('.bar.positive').click
      end

      def has_moods_in_modal?
        find('.modal-content').has_css?('p', text: '7', count: 2)
      end

      def open_emotion_modal
        if ENV['driver'] == 'poltergeist'
          find('.bar.negative').trigger('click')
        else
          find('.bar.negative').click
        end
      end

      def has_emotions_in_modal?
        ['2 longing', '4 angry', '1 fatigued', '8 anxious'].all? do |emotion|
          find('.modal-content').has_text? emotion
        end
      end
    end
  end
end
