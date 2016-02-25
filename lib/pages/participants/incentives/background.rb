class Participants
  class Incentives
    # page object for background features
    class Background
      include RSpec::Matchers
      include Capybara::DSL

      def initialize(background_arry)
        @image ||= background_arry[:image]
      end

      def choose_image
        find('.modal-content').find("##{@image}-image").click
      end

      def visible?
        if ENV['safari'] || ENV['chrome']
          find('.snap-content.footless:nth-child(1)')
            .native.css_value('background-image')
            .should eq("url(http://localhost:3000/assets/#{@image}.jpg)")
        else
          find('.snap-content.footless:nth-child(1)')
            .native.css_value('background-image')
            .should eq("url(\"http://localhost:3000/assets/#{@image}.jpg\")")
        end
      end

      def change
        click_on 'Change Background'
      end
    end
  end
end
