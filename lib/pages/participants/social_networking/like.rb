require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'

class Participants
  class SocialNetworking
    # page object for likes
    class Like
      include Capybara::DSL

      def initialize(like)
        @feed_item ||= like[:feed_item]
        @participant ||= like[:participant]
      end

      def like
        social_networking.find_feed_item(@feed_item)
        navigation.scroll_to_bottom
        within first('.list-group-item.ng-scope', text: @feed_item) do
          click_on 'Like' unless has_text?('Like (1)')
          has_text? 'Like (1)'
        end
      end

      def has_like_detail?
        within('.list-group-item.ng-scope', text: @feed_item) do
          find('.likes.ng-binding').click
          has_text? @participant
        end
      end

      private

      def navigation
        @navigation ||= Participants::Navigation.new
      end

      def social_networking
        @social_networking ||= Participants::SocialNetworking.new
      end
    end
  end
end
