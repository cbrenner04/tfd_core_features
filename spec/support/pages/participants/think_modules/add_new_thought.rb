# frozen_string_literal: true
module Participants
  module ThinkModules
    # page object for the Add a New Thought module
    class AddNewThought
      include Capybara::DSL

      def open
        click_on 'Add a New Harmful Thought'
        find('h2', text: 'Add a New Harmful Thought')
      end

      def complete(thought_input)
        enter_thought(thought_input)
        social_networking.accept_social
        think.has_success_alert?
        participant_navigation.scroll_to_bottom
        find('.btn.btn-primary.pull-right').click
      end

      def enter_thought(thought_input)
        fill_in 'thought_content', with: thought_input[:thought]
        select thought_input[:pattern], from: 'thought_pattern_id'
        fill_in 'thought_challenging_thought', with: thought_input[:challenge]
        fill_in 'thought_act_as_if', with: thought_input[:action]
        participant_navigation.scroll_to_bottom
      end

      def find_in_feed(thought)
        social_networking.find_feed_item("Reshaped a Thought: #{thought}")
      end

      def has_thought_visible?(thought)
        has_text? "Reshaped a Thought: #{thought}"
      end

      def has_timestamp?(timestamp)
        find('.list-group-item.ng-scope', text: 'Public thought 3')
          .has_text? timestamp
      end
    end
  end
end
