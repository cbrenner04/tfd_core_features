# frozen_string_literal: true
require './lib/pages/shared/activities_viz'

module Participants
  module DoModules
    # page object for the Activity Viz
    class ActivityVisualization
      include Capybara::DSL
      include SharedActivitiesViz

      def initialize(activity_viz)
        @start_time ||= activity_viz[:start_time]
        @end_time ||= activity_viz[:end_time]
        @activity ||= activity_viz[:activity]
        @importance ||= activity_viz[:importance]
        @fun ||= activity_viz[:fun]
        @accomplishment ||= activity_viz[:accomplishment]
        @pleasure ||= activity_viz[:pleasure]
      end

      def open
        click_on 'Your Activities'
        find('h3', text: 'Daily Averages')
      end

      def view_activity_rating
        click_on activity_header
      end

      def has_activity_rating?
        find('.panel', text: activity_header)
          .has_text?  "Predicted  Average Importance: #{@importance} " \
                      "Really fun: #{@fun}"
      end

      def edit_ratings
        within('.panel', text: activity_header) do
          within('.collapse') do
            click_on 'Edit'
            select @pleasure, from: 'activity[actual_pleasure_intensity]'
            select @accomplishment,
                   from: 'activity[actual_accomplishment_intensity]'
            click_on 'Update'
          end
        end
      end

      def has_new_ratings?
        sleep(1)
        has_text? "Accomplishment: #{@accomplishment} · Pleasure: #{@pleasure}"
      end

      private

      def activity_header
        "#{@start_time.strftime('%-l %P')} - " \
        "#{@end_time.strftime('%-l %P')}: #{@activity}"
      end
    end
  end
end
