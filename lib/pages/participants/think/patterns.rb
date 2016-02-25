require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'
require './lib/pages/participants/think'

class Participants
  class Think
    # page object for Patterns module
    class Patterns
      include RSpec::Matchers
      include Capybara::DSL

      def initialize(pattern)
        @thought ||= pattern[:thought]
        @pattern ||= pattern[:pattern]
      end

      def open
        click_on '#2 Patterns'
        find('h1', text: 'Like we said, you are what you think...')
      end

      def has_pattern_entry_form?
        has_text? 'Let\'s start by'
      end

      def move_to_pattern_entry_form
        navigation.next
        has_pattern_entry_form?
      end

      def complete_for_five_thoughts
        thought_value = find('.adjusted-list-group-item').text
        select_pattern('Personalization')
        3.times do
          thought_value = compare_thought(thought_value)
          select_pattern('Magnification or Catastrophizing')
        end
        compare_thought(thought_value)
        select_pattern('Personalization')
        navigation.scroll_down
        social_networking.accept_social
        think.has_success_alert?
        expect(think).to be_visible
      end

      def complete_two_thoughts
        thought_value = find('.panel-body.adjusted-list-group-item').text
        select_pattern('Personalization')
        compare_thought(thought_value)
        select_pattern('Magnification or Catastrophizing')
        navigation.scroll_down
        social_networking.accept_social
        think.has_success_alert?
      end

      def has_nothing_to_do?
        has_text? 'You haven\'t listed any negative thoughts'
      end

      def find_in_feed
        find_feed_item("Assigned a pattern to a Thought: #{@thought}")
      end

      def has_feed_detail?
        within first('.list-group-item.ng-scope',
                     text: "Assigned a pattern to a Thought: #{@thought}") do
          2.times { navigation.scroll_down }
          social_networking.open_detail

          has_text? "this thought is: #{@thought}\nthought pattern: #{@pattern}"
        end
      end

      private

      def navigation
        @navigation ||= Participants::Navigation.new
      end

      def social_networking
        @social_networking ||= Participants::SocialNetworking.new
      end

      def think
        @think ||= Participants::Think.new
      end

      def select_pattern(pattern)
        select pattern, from: 'thought_pattern_id'
      end

      def compare_thought(thought)
        navigation.scroll_down
        social_networking.accept_social
        think.has_success_alert?
        within('.adjusted-list-group-item') { has_no_content? thought }
        find('.adjusted-list-group-item').text
      end
    end
  end
end
