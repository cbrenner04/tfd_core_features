# frozen_string_literal: true
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
        counter = 0
        while has_no_css?('.status') && counter < 2
          find('#new-on-your-mind-description').click
          counter += 1
        end
        expect(social_networking).to have_1000_characters_left
        fill_in 'new-on-your-mind-description', with: @statement
        expect(social_networking).to have_updated_character_count(@statement)
        click_on 'Save'
      end

      def in_feed?
        find('#feed-btn').click if ENV['sunnyside'] || ENV['marigold']
        sleep(1)
        has_text? @statement
      end

      private

      def social_networking
        @social_networking ||= Participants::SocialNetworking.new
      end
    end
  end
end
