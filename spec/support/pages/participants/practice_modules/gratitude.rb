# frozen_string_literal: true
module Participants
  module PracticeModules
    # page object for the Gratitude Module
    class Gratitude
      include RSpec::Matchers
      include Capybara::DSL

      def initialize(gratitude)
        @response ||= gratitude[:response]
        @response_date ||= gratitude[:response_date]
      end

      def open
        click_on 'New Gratitude Recording'
      end

      def open_review
        click_on 'View Gratitude Recordings'
      end

      def has_question?
        has_text? 'What were you grateful for today? Or, thinking back, what' \
                  ' can you feel grateful for now?'
      end

      def show_examples
        click_on 'see some examples'
      end

      def has_examples?
        actual_items = (0..7).map { |i| all('.well')[1].all('li')[i].text }
        expect(actual_items).to eq(expected_items)
      end

      def enter_response
        fill_in 'gratitude_recording[description]', with: @response
      end

      def saved?
        has_css?('.alert', text: 'Gratitude Recording saved')
      end

      def has_recording?
        has_css?('.list-group-item',
                 text: "#{long_date(@response_date)} #{@response}")
      end

      private

      def expected_items
        @expected_items ||= [
          'A person who\'s done you a favor',
          'Something you enjoy, like a song or TV show (you can be grateful ' \
          'for the show itself, and also to the people who made it.)',
          'Things that make life easier or more pleasant - including really ' \
          'simple things, like a warm blanket.',
          'A pet or friendly animal',
          'A good friend or close family member, just for being there',
          'God or a higher power',
          'Nature in general, or a particular plant, flower, or tree',
          'Anything else that your\'re glad to have or experience'
        ]
      end
    end
  end
end
