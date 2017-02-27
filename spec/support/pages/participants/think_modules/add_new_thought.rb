# frozen_string_literal: true
require './spec/support/pages/participants/navigation'
require './spec/support/pages/participants/social_networking'
require './spec/support/pages/participants/think'

module Participants
  module ThinkModules
    # page object for the Add a New Thought module
    class AddNewThought
      include Capybara::DSL

      def initialize(add_new_thought)
        @thought ||= add_new_thought[:thought]
        @pattern ||= add_new_thought[:pattern]
        @challenge ||= add_new_thought[:challenge]
        @action ||= add_new_thought[:action]
        @timestamp ||= add_new_thought[:timestamp]
      end

      def open
        click_on 'Add a New Harmful Thought'
        find('h2', text: 'Add a New Harmful Thought')
      end

      def complete
        enter_thought
        social_networking.accept_social
        think.has_success_alert?
        participant_navigation.scroll_to_bottom
        find('.btn.btn-primary.pull-right').click
      end

      def enter_thought
        fill_in 'thought_content', with: @thought
        select @pattern, from: 'thought_pattern_id'
        fill_in 'thought_challenging_thought', with: @challenge
        fill_in 'thought_act_as_if', with: @action
        participant_navigation.scroll_to_bottom
      end

      def find_in_feed
        social_networking.find_feed_item("Reshaped a Thought: #{@thought}")
      end

      def visible?
        has_text? "Reshaped a Thought: #{@thought}"
      end

      def has_timestamp?
        find('.list-group-item.ng-scope',
             text: 'Public thought 3').has_text? @timestamp
      end

      private

      def participant_navigation
        @participant_navigation ||= Participants::Navigation.new
      end

      def social_networking
        @social_networking ||= Participants::SocialNetworking.new
      end

      def think
        @think ||= Participants::Think.new
      end
    end
  end
end
