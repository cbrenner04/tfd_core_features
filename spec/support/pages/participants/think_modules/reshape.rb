# frozen_string_literal: true
module Participants
  module ThinkModules
    # page object for Reshape module
    class Reshape
      include RSpec::Matchers
      include Capybara::DSL

      def open
        click_on '#3 Reshape'
        find('h1', text: 'Challenging Harmful Thoughts')
      end

      def move_to_reshape_form
        click_on 'Next'
        find('h2', text: 'You said you had the following unhelpful thoughts:')
        click_on 'Next'
        find('p', text: 'Challenging a thought means')

        begin
          tries ||= 3
          participant_navigation.next
        rescue Selenium::WebDriver::Error::UnknownError
          participant_navigation.scroll_down
          retry unless (tries -= 1).zero?
        end
      end

      def has_reshape_form?
        has_text?('In case you\'ve forgotten') || has_text?('You don\'t have')
      end

      def reshape_multiple_thoughts(thoughts_count:, challenge:, action:)
        thoughts_count.times { reshape(challenge: challenge, action: action) }
      end

      def reshape(challenge:, action:)
        find('h3', text: 'You said that you thought...')
        participant_navigation.next
        fill_in 'thought[challenging_thought]', with: challenge
        participant_navigation.scroll_down
        participant_navigation.next
        expect(think).to have_success_alert
        find('p', text: 'Because what you THINK, FEEL, Do')
        participant_navigation.scroll_to_bottom
        participant_navigation.next
        find('label', text: 'What could you do to ACT AS IF you believe this?')
        fill_in 'thought_act_as_if', with: action
        participant_navigation.next
      end

      def find_in_feed(thought)
        social_networking.find_feed_item("Reshaped a Thought: #{thought}")
      end

      def has_feed_details?(feed_details)
        within('.list-group-item.ng-scope',
               text: "Reshaped a Thought: #{feed_details[:thought]}") do
          2.times { participant_navigation.scroll_down }
          social_networking.open_detail

          has_text? "this thought is: #{feed_details[:thought]}" \
                    "\nthought pattern: #{feed_details[:pattern]}" \
                    "\nchallenging thought: #{feed_details[:challenge]}" \
                    "\nas if action: #{feed_details[:action]}"
        end
      end
    end
  end
end
