# frozen_string_literal: true
require './lib/pages/users/navigation'

module Users
  module PatientDashboards
    # page object for table of contents in patient dashboard
    class TableOfContents
      include RSpec::Matchers
      include Capybara::DSL

      def select_all_links
        select_mood_emotions_viz
        select_mood
        select_feel
        select_logins
        select_lessons
        select_audio_access
        select_activities_future
        select_activities_past
        select_thoughts
        select_messages
        select_tasks
      end

      def select_phq
        select_from_toc('PHQ9')
      end

      def select_mood_emotions_viz
        select_from_toc('Mood and Emotions Visualization')
      end

      def select_mood
        # two scrolls needed when running social networking app
        single_scroll_if_social_networking_app
        user_navigation.scroll_down
        find('.list-group').all('a', text: 'Mood')[1].click
      end

      def select_feel
        select_from_toc('Feelings')
      end

      def select_logins
        select_from_toc('Logins')
      end

      def select_lessons
        select_from_toc('Lessons')
      end

      def select_audio_access
        select_from_toc('Audio Access')
      end

      def select_activity_viz
        select_from_toc('Activities visualization')
        text = ENV['sunnyside'] ? 'TODAY' : 'Today'
        expect(page).to have_css('.btn-toolbar', text: text)
      end

      def select_activities_future
        select_from_toc('Activities - Future')
      end

      def select_activities_past
        single_scroll_if_social_networking_app
        select_from_toc('Activities - Past')
      end

      def select_thoughts_viz
        single_scroll_if_social_networking_app
        select_from_toc('Thoughts visualization')
      end

      def select_thoughts
        double_scroll_if_social_networking_app
        user_navigation.scroll_down
        find('.list-group').all('a', text: 'Thoughts')[1].click
      end

      def select_messages
        double_scroll_if_social_networking_app
        select_from_toc('Messages')
      end

      def select_tasks
        double_scroll_if_social_networking_app
        select_from_toc('Tasks')
      end

      private

      def user_navigation
        @user_navigation ||= Users::Navigation.new
      end

      def select_from_toc(link)
        single_scroll_if_social_networking_app
        user_navigation.scroll_down
        find('.list-group').find('a', text: link).click
      end

      def single_scroll_if_social_networking_app
        user_navigation.scroll_down if social_networking_app?
      end

      def double_scroll_if_social_networking_app
        2.times { user_navigation.scroll_down } if social_networking_app?
      end

      def social_networking_app?
        return true if ENV['tfdso'] || ENV['sunnyside'] || ENV['marigold']
      end
    end
  end
end
