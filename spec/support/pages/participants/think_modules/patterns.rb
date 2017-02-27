# frozen_string_literal: true
module Participants
  module ThinkModules
    # page object for Patterns module
    class Patterns
      include RSpec::Matchers
      include Capybara::DSL

      def open
        click_on '#2 Patterns'
        find('h1', text: 'Like we said, you are what you think...')
      end

      def has_pattern_entry_form?
        has_text? 'Let\'s start by'
      end

      def move_to_pattern_entry_form
        participant_navigation.next
        find('p', text: 'Let\'s start by')
      end

      def complete_for_five_thoughts
        thought_value = find('.adjusted-list-group-item').text
        select_pattern('Personalization')
        3.times do
          thought_value = compare_thought(thought_value)
          select_pattern('Magnification or Catastrophizing')
          participant_navigation.scroll_down
        end
        compare_thought(thought_value)
        select_pattern('Personalization')
        participant_navigation.scroll_down
        social_networking.accept_social
        participant_navigation.next if has_css?('h1', text: 'Good work!')
      end

      def complete_two_thoughts
        thought_value = find('.panel-body.adjusted-list-group-item').text
        select_pattern('Personalization')
        compare_thought(thought_value)
        select_pattern('Magnification or Catastrophizing')
        participant_navigation.scroll_down
        social_networking.accept_social
        expect(think).to have_success_alert
      end

      def has_nothing_to_do?
        has_text? 'You haven\'t listed any negative thoughts'
      end

      def find_in_feed(thought)
        find_feed_item("Assigned a pattern to a Thought: #{thought}")
      end

      def has_feed_detail?(thought:, pattern:)
        within first('.list-group-item.ng-scope',
                     text: "Assigned a pattern to a Thought: #{thought}") do
          2.times { participant_navigation.scroll_down }
          social_networking.open_detail
          has_text? "this thought is: #{thought}\nthought pattern: #{pattern}"
        end
      end

      private

      def select_pattern(pattern)
        select pattern, from: 'thought_pattern_id'
      end

      def compare_thought(thought)
        participant_navigation.scroll_down
        social_networking.accept_social

        expect(think).to have_success_alert
        expect(find('.adjusted-list-group-item')).to_not have_text thought

        find('.adjusted-list-group-item').text
        find('.alert').find('.close').click if has_css?('.alert')
      end
    end
  end
end
