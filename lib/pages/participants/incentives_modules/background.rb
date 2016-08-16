# frozen_string_literal: true
module Participants
  module IncentivesModules
    # page object for background features
    class Background
      include RSpec::Matchers
      include Capybara::DSL

      def initialize(background)
        @image ||= background[:image]
      end

      def choose_image
        find('.modal-content').find("##{@image}-image").click
      end

      def visible?
        image_url = find('.snap-content.footless:nth-child(1)')
                    .native.css_value('background-image')

        image_url.should include @image
      end

      def change
        click_on 'Change Background'
      end
    end
  end
end
