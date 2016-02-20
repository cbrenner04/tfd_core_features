class Participants
  class DoTool
    # page object for the Planned Activities view
    class PlannedActivities
      include Capybara::DSL

      def initialize(planned_activities_arry)
        @activity ||= planned_activities_arry[:activity]
      end

      def open
        click_on 'View Planned Activities'
      end

      def visible?
        has_css('.text-capitalize', text: 'View Planned Activites')
      end

      def has_activity?
        has_text? @activity
      end
    end
  end
end
