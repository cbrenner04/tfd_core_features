require './lib/pages/shared/mood_emotions_viz'

class Participants
  class Feel
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

      def has_moods?
        find('#mood').find('.title', text: 'Mood*')
        has_css?(".#{@mood_type}", count: @mood_count)
      end

      def has_emotions?
        find('#emotions')
          .find('.title', text: 'Positive and Negative Emotions*')
        has_css?(".#{@emotion_type}", count: @emotions_count)
      end
    end
  end
end
