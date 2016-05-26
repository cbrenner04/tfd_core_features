require './lib/pages/participants/social_networking'

module Participants
  module SocialNetworkingModules
    # page object for  on the mind statements
    class OnTheMindStatement
      include RSpec::Matchers
      include Capybara::DSL

      def initialize(on_the_mind_statement)
        @statement ||= on_the_mind_statement[:statement]
      end

      def create # this include checking for character count
        click_on 'What\'s on your mind?'
        if ENV['tfdso']
          find('#new-on-your-mind-description').click
          expect(social_networking).to have_1000_characters_left
        end
        fill_in 'new-on-your-mind-description', with: @statement
        if ENV['tfdso']
          expect(social_networking).to have_updated_character_count(@statement)
        end
        click_on 'Save'
      end

      def in_feed?
        find('#feed-btn').click if ENV['sunnyside'] || ENV['marigold']
        has_text? @statement
      end

      private

      def social_networking
        @social_networking ||= Participants::SocialNetworking.new
      end
    end
  end
end
