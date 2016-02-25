class Participants
  class DoTool
    # page object for the Activity Viz
    class ActivityVisualization
      include Capybara::DSL

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

      def visible?
        has_text? "Daily Averages for #{Date.today.strftime('%b %d %Y')}"
      end

      def has_daily_summary_visible?
        has_text? 'Average Accomplishment Discrepancy'
      end

      def toggle_daily_summary
        click_on 'Daily Summaries'
        sleep(1)
      end

      def go_to_previous_day
        click_on 'Previous Day'
      end

      def has_previous_day_visible?
        has_text? 'Daily Averages for ' \
                  "#{Date.today.prev_day.strftime('%b %d %Y')}"
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

      def open_visualize
        click_on 'Visualize'
      end

      def go_to_three_day_view
        click_on 'Last 3 Days'
      end

      def has_three_day_view_visible?
        has_text?((Date.today - 2).strftime('%A, %m/%d'))
      end

      def open_date_picker
        click_on 'Day'
      end

      def has_date_picker?
        has_css? '#datepicker'
      end

      private

      def activity_header
        "#{@start_time.strftime('%-l %P')} - " \
        "#{@end_time.strftime('%-l %P')}: #{@activity}"
      end
    end
  end
end
