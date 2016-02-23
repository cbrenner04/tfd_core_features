class Participants
  class SocialNetworking
    # page object for  on the mind statements
    class OnTheMindStatement
      include Capybara::DSL

      def initialize(on_the_mind_arry)
        @statement ||= on_the_mind_arry[:statement]
      end

      def create
        click_on 'What\'s on your mind?'
        fill_in 'new-on-your-mind-description', with: @statement
        click_on 'Save'
      end

      def in_feed?
        find('#feed-btn').click if ENV['sunnyside'] || ENV['marigold']
        has_text? @statment
      end
    end
  end
end
