require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'

module Participants
  module SocialNetworkingModules
    # page object for comments
    class Comment
      include RSpec::Matchers
      include Capybara::DSL

      def initialize(comment)
        @feed_item ||= comment[:feed_item]
        @comment ||= comment[:comment]
        @participant ||= comment[:participant]
      end

      def comment
        social_networking.find_feed_item(@feed_item)
        participant_navigation.scroll_to_bottom
        within first('.list-group-item.ng-scope', text: @feed_item) do
          click_on 'Comment'
          find('input[type = text]').set(@comment)
          participant_navigation.scroll_down
          click_on 'Save'
          expect(page).to have_content 'Comment (1)'
        end
      end

      def comment_and_check_for_character_count
        social_networking.find_feed_item(@feed_item)
        participant_navigation.scroll_to_bottom
        within first('.list-group-item.ng-scope', text: @feed_item) do
          click_on 'Comment'
          find('input[type = text]').click
          sleep(0.5)
          expect(social_networking).to have_1000_characters_left
          find('input[type = text]').set(@comment)
          expect(social_networking).to have_updated_character_count(@comment)
          participant_navigation.scroll_down
          click_on 'Save'
          expect(page).to have_content 'Comment (1)'
        end
      end

      def has_comment_detail?
        within first('.list-group-item.ng-scope', text: @feed_item) do
          find('.comments.ng-binding').click
          has_text? "#{@participant}: #{@comment}"
        end
      end

      private

      def participant_navigation
        @participant_navigation ||= Participants::Navigation.new
      end

      def social_networking
        @social_networking ||= Participants::SocialNetworking.new
      end
    end
  end
end
