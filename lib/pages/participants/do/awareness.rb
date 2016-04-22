
require './lib/pages/participants/do'
require './lib/pages/participants/navigation'

class Participants
  class DoTool
    # page object for the awareness module
    class Awareness
      include Capybara::DSL

      def initialize(awareness)
        @start_time ||= awareness[:start_time]
        @end_time ||= awareness[:end_time]
        @num_fields ||= awareness[:num_fields]
        @activity ||= awareness[:activity]
        @pleasure ||= awareness[:pleasure]
        @accomplishment ||= awareness[:accomplishment]
        @count ||= awareness[:count]
      end

      def open
        click_on '#1 Awareness'
        find('h1', text: '#1 Awareness')
      end

      def has_first_slide_visible?
        has_text? 'This is just the beginning...'
      end

      def move_to_time_period_selection
        participant_navigation.next
        find('h1', text: 'Just a slide')
        participant_navigation.next
      end

      def has_time_period_selection_form_visible?
        has_text? 'OK, let\'s talk about yesterday'
      end

      def create_time_period
        select @start_time, from: 'awake_period_start_time'
        select @end_time, from: 'awake_period_end_time'
        click_on 'Create'
        find('.alert-success', text: 'Activity saved')
      end

      def choose_to_complete_time_period
        click_on 'Complete'
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
          complete_one_hour_review(a, b, c, d)
        end
        participant_navigation.next
      end

      def complete_one_hour_review(a, b, c, d)
        fill_in "activity_type_#{a}", with: b
        do_tool.choose_rating("pleasure_#{a}", c)
        do_tool.choose_rating("accomplishment_#{a}", d)
        participant_navigation.scroll_down
      end

      def copy(previous_entry)
        click_on "copy_#{previous_entry + 1}"
      end

      def has_entries?
        %w(recent fun accomplished).zip(@count) do |x, y|
          find("##{x}_activities").has_css?('tr', count: y)
          participant_navigation.scroll_to_bottom
          participant_navigation.next
        end
        has_css?('h1', text: 'Do Landing')
      end

      def has_review_tables?
        %w(recent fun accomplished).each do |x|
          find("##{x}_activities")
          click_on 'Next'
        end
      end

      private

      def do_tool
        @do_tool ||= Participants::DoTool.new
      end

      def participant_navigation
        @participant_navigation ||= Participants::Navigation.new
      end
    end
  end
end
