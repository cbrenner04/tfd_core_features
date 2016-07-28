# frozen_string_literal: true
module Participants
  module CommitmentsModules
    # page object for the Positive Events and Gratitude module in Marigold
    class Kindness
      include RSpec::Matchers
      include Capybara::DSL

      def open
        click_on 'Kindness'
        expect(page).to have_text 'Slide 1'
      end

      def move_through_initial_slideshow
        participant_navigation.next
        expect(page).to have_text 'Optional Links'
      end

      def select_review_lessons
        click_on 'Review the Kindness lesson on the MARIGOLD course'
      end

      def select_look_back_at_journal
        click_on 'Look back at your Kindness journal from the course'
      end

      def select_print_bonus_handout
        click_on 'Print out the Kindness bonus handout to keep with you'
      end

      def has_commitment_form_visible?
        has_text?('Ready to Make a Commitment') &&
          has_text?(commitment_choices[0]) &&
          has_text?(commitment_choices[1]) &&
          has_text?(commitment_choices[2])
      end

      def set_commitment
        @commitment ||= commitment_choices.sample
        choose @commitment
      end

      def has_commitment?
        has_text? @commitment
      end

      def has_commitment_summary_visible?
        has_css?('h1',
                 text: 'My Commitment to Practicing Kindness')
      end

      private

      def commitment_choices
        ['I will commit to doing something nice for a friend, ' \
          'loved one, or stranger every day.',
         'I will watch for spontaneous opportunities to help people or ' \
          'be kind, and keep a diary of what I do',
         'I will choose a larger act of kindness, such as getting involved ' \
          'with a volunteer organization or making a gift for someone ' \
          'I know. I will steadily make progress toward my goal.']
      end
    end
  end
end
