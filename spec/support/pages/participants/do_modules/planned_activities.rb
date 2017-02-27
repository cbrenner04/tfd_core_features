# frozen_string_literal: true
module Participants
  module DoModules
    # page object for the Planned Activities view
    class PlannedActivities
      include Capybara::DSL

      def open
        click_on 'View Planned Activities'
        find('h1', text: 'View Planned Activities')
      end

      def visible?
        has_css?('.text-capitalize', text: 'View Planned Activities')
      end

      def has_activity?(activity)
        has_text? activity
      end
    end
  end
end
