class Participants
  class DoTool
    # page object for Plan a New Activity module
    class PlanNewActivity
      include Capybara::DSL

      def initialize(new_activity_arry)
        @activity ||= new_activity_arry[:activity]
        @pleasure ||= new_activity_arry[:pleasure]
        @accomplishment ||= new_activity_arry[:accomplishment]
      end

      def open
        click_on 'Add a New Activity'
      end

      def plan_activity
        planning.plan_first_activity
      end

      def has_activity?
        has_text? @activity
      end

      private

      def planning
        @planning ||= Participants::DoTool::Planning.new(
          activity: @activity,
          pleasure: @pleasure,
          accomplishment: @accomplishment
        )
      end
    end
  end
end
