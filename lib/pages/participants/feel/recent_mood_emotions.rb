class Participants
  class Feel
    # page object for Your Recent Moods & Emotions module
    class RecentMoodsEmotions
      include Capybara::DSL

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

      def has_week_view_visible?
        has_css?('#date-range',
                 text: "#{(Date.today - 6).strftime('%b %d %Y')} - " \
                       "#{Date.today.strftime('%b %d %Y')}")
      end

      def switch_to_28_day_view
        find('.btn.btn-default', text: '28').click
      end

      def has_28_day_view_visible?
        has_text? "#{(Date.today - 27).strftime('%b %d %Y')} - " \
                  "#{Date.today.strftime('%b %d %Y')}"
      end

      def switch_to_7_day_view
        find('.btn.btn-default', text: '7').click
      end

      def switch_to_previous_period
        click_on 'Previous Period'
      end

      def has_previous_period_visible?
        has_text? "#{(Date.today - 13).strftime('%b %d %Y')} - " \
                  "#{(Date.today - 7).strftime('%b %d %Y')}"
      end
    end
  end
end
