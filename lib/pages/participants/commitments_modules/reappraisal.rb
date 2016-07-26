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
        ['I will pick a small way to work on something I care about, and keep' \
         ' track of what I picked',
         'I will schedule activities for myself, including specific times and' \
         ' reminders to help make sure I do them.',
         'I will make or find a list of enjoyable things to do, and pick one ' \
         'of them to do for at least 5 minutes']
      end
    end
  end
end
