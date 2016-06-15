# frozen_string_literal: true
require './lib/pages/participants/do'
require './lib/pages/participants/navigation'

module Participants
  module DoModules
    # page object for the awareness module
    class Awareness
      include RSpec::Matchers
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
        find('.alert', text: 'Awake Period saved')
      end

      def choose_to_complete_time_period
        click_on 'Complete'
      end

      def has_start_time?(start_time)
        has_css?('#awake_period_start_time',
                 text: "#{week_day(today.prev_day)} #{start_time}")
      end

      def has_end_time?(end_time)
        has_css?('#awake_period_end_time',
                 text: "#{week_day(today.prev_day)} #{end_time}")
      end

      def complete_one_hour_review_with_more_than_255_characters
        complete_one_hour_review(0, more_than_255_characters, 4, 5)
      end

      def has_less_than_255_characters_in_entries?
        actual_text = find('td', text: 'Lorem').text
        actual_text.should eq more_than_255_characters[0..254]
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

      def more_than_255_characters
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus ' \
        'eleifend interdum lorem et fringilla. Duis eros magna, scelerisque' \
        ' in dictum quis, viverra quis mi. Donec et magna et arcu vulputate' \
        ' vehicula eu in tellus. Morbi luctus urna eget ipsum amet. Over the' \
        ' line!'
      end
    end
  end
end
