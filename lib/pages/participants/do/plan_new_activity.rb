require './lib/pages/participants/social_networking'

class Participants
  class DoTool
    # page object for Plan a New Activity module
    class PlanNewActivity
      include Capybara::DSL

      def initialize(new_activity_arry)
        @activity ||= new_activity_arry[:activity]
        @pleasure ||= new_activity_arry[:pleasure]
        @accomplishment ||= new_activity_arry[:accomplishment]
        @timestamp ||= new_activity_arry[:timestamp]
      end

      def open
        click_on 'Add a New Activity'
      end

      def plan_activity
        planning.plan
      end

      def on_form?
        has_text? 'But you don\'t have to start from scratch,'
      end

      def visible?
        has_text? @activity
      end

      def has_activity?
        has_text? @activity
      end

      def find_in_feed
        social_networking.find_feed_item(@activtity)
      end

      def has_timestamp?
        find('.list-group-item.ng-scope', text: @activity).has_text? @timestamp
      end

      private

      def planning
        @planning ||= Participants::DoTool::Planning.new(
          activity: @activity,
          pleasure: @pleasure,
          accomplishment: @accomplishment
        )
      end

      def social_networking
        @social_networking ||= Participants::SocialNetworking.new
      end
    end
  end
end
