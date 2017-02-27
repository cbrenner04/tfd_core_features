# frozen_string_literal: true
require_relative '../../shared/mood_emotions_viz'

module Participants
  module FeelModules
    # page object for Your Recent Moods & Emotions module
    class RecentMoodsEmotions
      include Capybara::DSL
      include SharedMoodEmotionsViz

      def open
        click_on 'Your Recent Moods & Emotions'
        find('h1', text: 'Your Recent Moods & Emotions')
      end

      def has_moods_in_graph?(mood_count:, mood_type:)
        find('#mood').has_css?('.title', text: 'Mood*') &&
          has_css?(".#{mood_type}", count: mood_count)
      end

      def has_emotions_in_graph?(emotions_count:, emotion_type:)
        find('#emotions')
          .has_css?('.title', text: 'Positive and Negative Emotions*') &&
          has_css?(".#{emotion_type}", count: emotions_count)
      end

      def open_mood_modal
        find('.bar.positive').click
      end

      def has_moods_in_modal?
        find('.modal-content').has_css?('p', text: '7', count: 2)
      end

      def open_emotion_modal
        participant_navigation.scroll_down
        negative_bar = find('.bar.negative')
        if ENV['driver'] == 'poltergeist'
          negative_bar.trigger('click')
        else
          negative_bar.click
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
