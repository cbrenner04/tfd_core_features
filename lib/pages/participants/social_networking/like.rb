class Participants
  class SocialNetworking
    # page object for likes
    class Like
      include Capybara::DSL

      def initialize(like_arry)
        @feed_item ||= like_arry[:feed_item]
        @participant ||= like_arry[:participant]
      end

      def like
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
    end
  end
end
