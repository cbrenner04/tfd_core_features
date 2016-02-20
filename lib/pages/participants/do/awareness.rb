require './lib/participants/navigation'

class Participants
  class DoTool
    # page object for the awareness module
    class Awareness
      include Capybara::DSL

      def initialize(awareness_arry)
        @start_time ||= awareness_arry[:start_time]
        @end_time ||= awareness_arry[:end_time]
        @num_fields ||= awareness_arry[:num_fields]
        @activity ||= awareness_arry[:activity]
        @pleasure ||= awareness_arry[:pleasure]
        @accomplishment ||= awareness_arry[:accomplishment]
        @count ||= awareness_arry[:count]
      end

      def open
        click_on '#1 Awareness'
      end

      def move_to_time_period_selection
        navigation.next
        find('h1', text: 'Just a slide')
        navigation.next
      end

      def create_time_period
        select "#{Date.today.prev_day.strftime('%a')} #{@start_time}",
               from: 'awake_period_start_time'
        select "#{Date.today.prev_day.strftime('%a')} #{@end_time}",
               from: 'awake_period_end_time'
        click_on 'Create'
        find('.alert-success', text: 'Awake Period saved')
      end

      def has_start_time?(start_time)
        has_css?('#awake_period_start_time',
                 text: "#{Date.today.prev_day.strftime('%a')} #{start_time}")
      end

      def has_end_time?(end_time)
        has_css?('#awake_period_end_time',
                 text: "#{Date.today.prev_day.strftime('%a')} #{end_time}")
      end

      def complete_multiple_hour_review
        @num_fields.zip(@activity, @pleasure, @accomplishment) do |a, b, c, d|
          complete_on_hour_review(a, b, c, d)
        end

        navigation.next
      end

      def complete_one_hour_review(a, b, c, d)
        fill_in "activity_type_#{a}", with: b
        choose_rating("pleasure_#{a}", c)
        choose_rating("accomplishment_#{a}", d)
        navigation.scroll_down
      end

      def copy(previous_entry)
        click_on "copy_#{previous_entry + 1}"
      end

      def has_entries?
        %w(recent fun accomplished).zip(@count) do |x, y|
          find("##{x}_activities").has_css?('tr', count: y)
        end
      end

      def finish
        naviation.scroll_to_bottom
        navigation.next
        find('h1', text: 'Do Landing')
      end

      private

      def navigation
        @navigation ||= Participants::Navigations.new
      end

      def choose_rating(element_id, value)
        find("##{element_id} select")
          .find(:xpath, "option[#{(value + 1)}]").select_option
      end
    end
  end
end
