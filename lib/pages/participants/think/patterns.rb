require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'
require './lib/pages/participants/think'

class Participants
  class Think
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
        navigation.next
        has_pattern_entry_form?
      end

      def complete
        thought_value = find('.adjusted-list-group-item').text
        select 'Personalization', from: 'thought_pattern_id'
        3.times do
          thought_value = compare_thought(thought_value)
          select 'Magnification or Catastrophizing', from: 'thought_pattern_id'
        end

        compare_thought(thought_value)
        select 'Personalization', from: 'thought_pattern_id'
        navigation.scroll_down
        social_networking.accept_social
        find('.alert-success', text: 'Thought saved')
        expect(think).to be_visible
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

      def compare_thought(thought)
        navigation.scroll_down
        social_networking.accept_social
        find('.alert-success', text: 'Thought saved')
        within('.adjusted-list-group-item') { has_no_content? thought }
        find('.adjusted-list-group-item').text
      end
    end
  end
end
