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
          has_text?(COMMITMENT_CHOICES[0]) &&
          has_text?(COMMITMENT_CHOICES[1])
      end

      def set_commitment
        @commitment ||= COMMITMENT_CHOICES.sample
        choose @commitment
        if @commitment == 'I will...'
          fill_in 'option', with: 'Example reappraisal commitment'
        end
      end

      def has_commitment?
        text = if @commitment == 'I will...'
                 'Example reappaisal commitment'
               else
                 @commitment
               end

        has_text? text
      end

      def has_commitment_summary_visible?
        has_css?('h1',
                 text: 'My Commitment to Practicing Reappraisal')
      end

      COMMITMENT_CHOICES =
        ['Every day, I will spend at least two minutes reappraising ' \
          'something that upsets me -- either right when ' \
          'it happens, or later in the day.',
         'Every day I will write down a small problem I\'m dealing with in ' \
          'my life, and look for ways to think about it differently.',
         'I will...'].freeze
    end
  end
end
