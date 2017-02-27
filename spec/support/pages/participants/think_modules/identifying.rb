# frozen_string_literal: true
module Participants
  module ThinkModules
    # page object for the Identifying module
    class Identifying
      include RSpec::Matchers
      include Capybara::DSL

      def open
        click_on '#1 Identifying'
        find('h1', text: 'You are what you think')
      end

      def move_to_thought_input
        participant_navigation.scroll_down
        participant_navigation.next
        ['Helpful thoughts are...', 'Harmful thoughts are:',
         'Some quick examples...'].each do |heading|
          find('h1', text: heading)
          participant_navigation.scroll_down
          participant_navigation.next
        end
      end

      def complete(responses)
        headings = ['Now, your turn...', 'Now list another harmful thought...',
                    'Just one more']
        headings.zip(responses) do |heading, response|
          expect(page).to have_text heading
          enter_thought(heading, response)
          social_networking.accept_social
          expect(think).to have_success_alert
        end
        find('h1', text: 'Good work')
        participant_navigation.next
      end

      def enter_thought(heading, response)
        find('h2', text: heading)
        fill_in 'thought_content', with: response
      end

      def has_thought_entry_form?
        has_text? 'Now, your turn...'
      end

      def has_final_slide?
        has_text? 'Good work.'
      end

      def find_in_feed(thought)
        social_networking.find_feed_item(thought)
      end

      def has_thought_visible?(thought)
        has_text? thought
      end

      def has_timestamp?(thought:, timestamp:)
        find('.list-group-item.ng-scope', text: thought).has_text? timestamp
      end
    end
  end
end
