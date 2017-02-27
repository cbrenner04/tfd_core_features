# frozen_string_literal: true
module Participants
  module DoModules
    # page object for Plan a New Activity module
    class PlanNewActivity
      include Capybara::DSL

      def open
        click_on 'Add a New Activity'
      end

      def on_form?
        has_text? 'But you don\'t have to start from scratch,'
      end

      def visible?(activity)
        has_text? activity
      end

      def find_in_feed(activity)
        social_networking.find_feed_item(activity)
      end
    end
  end
end
