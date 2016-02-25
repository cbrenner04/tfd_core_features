class Participants
  class DoTool
    # page object for the Planned Activities view
    class PlannedActivities
      include Capybara::DSL

      def initialize(planned_activities)
        @activity ||= planned_activities[:activity]
      end

      def open
        click_on 'View Planned Activities'
        find('h1', text: 'View Planned Activities')
      end

      def visible?
        has_css?('.text-capitalize', text: 'View Planned Activities')
      end

      def has_activity?
        has_text? @activity
      end
    end
  end
end
