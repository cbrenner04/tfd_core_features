# frozen_string_literal: true
module Participants
  module CommitmentsModules
    # page object for the Positive Events and Gratitude module in Marigold
    class PositiveEventsAndGratitude
      include RSpec::Matchers
      include Capybara::DSL

      def open
        click_on 'Positive Events and Gratitude'
        expect(page).to have_text 'Top 4 facts'
      end

      def move_through_initial_slideshow
        participant_navigation.next
        expect(page).to have_text 'Why pay attention'
        participant_navigation.next
        expect(page).to have_text 'Examples of positive events'
        participant_navigation.next
        expect(page).to have_text 'Optional Links'
      end

      def select_review_lessons
        click_on 'Review the Positive Events lesson on the MARIGOLD course'
      end

      def select_look_back_at_journal
        click_on 'Look back at your Positive Events journal from the course'
      end

      def select_print_bonus_handout
        click_on 'Print out the Positive Events bonus handout to keep with you'
      end

      def has_commitment_form_visible?
        has_text?('Ready to Make a Commitment') &&
          has_text?(commitment_choices[0]) &&
          has_text?(commitment_choices[1])
      end

      def set_commitment
        @commitment ||= commitment_choices.sample
        choose @commitment
        if @commitment == 'I will...'
          fill_in '.option', with: 'Example positive events commitment'
        end
      end

      def has_commitment?
        if @commitment == 'I will...'
          has_text? 'Example positive events commitment'
        else
          has_text? @commitment
        end
      end

      def has_commitment_summary_visible?
        has_css?('h1',
                 text: 'My Commitment to Practicing Noticing Positive Events')
      end

      private

      def commitment_choices
        ['I will keep an eye out for positive events. At the end ' \
         'of each day, I\'ll write down two good things that I ' \
         'noticed.',
         'I will practice amplifying positive events. Each day ' \
         'I\'ll do one thing, like telling someone else about an ' \
         'event or looking back and savoring it afterward.',
         'I will...'].freeze
      end
    end
  end
end
