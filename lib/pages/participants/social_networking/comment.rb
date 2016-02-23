require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'

class Participants
  class SocialNetworking
    # page object for comments
    class Comment
      include Capybara::DSL

      def initialize(comment_arry)
        @feed_item ||= comment_arry[:feed_item]
        @comment ||= comment_arry[:comment]
        @participant ||= comment_arry[:participant]
      end

      def comment
        social_networking.find_feed_item(@feed_item)
        navigation.scroll_to_bottom
        within first('.list-group-item.ng-scope', text: @feed_item) do
          click_on 'Comment'
          has_text? 'What do you think?'
          fill_in 'comment-text', with: @comment
          navigation.scroll_down
          click_on 'Save'
          has_text? 'Comment (1)'
        end
      end

      def has_comment_detail?
        within first('.list-group-item.ng-scope', text: @feed_item) do
          find('.comments.ng-binding').click
          has_text? "#{@participant}: #{@comment}"
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
