# frozen_string_literal: true
module Participants
  module CommitmentsModules
    # page object for the Positive Events and Gratitude module in Marigold
    class Reappraisal
      include RSpec::Matchers
      include Capybara::DSL

      def open
        click_on 'Reappraisal'
        expect(page).to have_text 'Slide 1'
      end

      def move_through_initial_slideshow
        participant_navigation.next
        expect(page).to have_text 'Optional Links'
      end

      def select_review_lessons
        click_on 'Review the Reappraisal lesson on the MARIGOLD course'
      end

      def select_look_back_at_journal
        click_on 'Look back at your Reappraisal journal from the course'
      end

      def select_print_bonus_handout
        click_on 'Print out the Reappraisal bonus handout to keep with you'
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
                 text: 'My Commitment to Practicing Reappraisal')
      end

      private

      def commitment_choices
        ['Every day, I will spend at least two minutes reappraisig ' \
          'something that upsets me -- either right when ' \
          'it happens, or later in the day.',
         'Every day I will write down a small problem I\'m dealing with in ' \
          'my life, and look for ways to think about it differently.']
      end
    end
  end
end
