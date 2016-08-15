# frozen_string_literal: true
module Participants
  module CommitmentsModules
    # page object for the Positive Events and Gratitude module in Marigold
    class Mindfulness
      include RSpec::Matchers
      include Capybara::DSL

      def open
        click_on 'Mindfulness'
        expect(page).to have_text 'Slide 1'
      end

      def move_through_initial_slideshow
        participant_navigation.next
        expect(page).to have_text 'Optional Links'
      end

      def select_review_lessons
        click_on 'Review the Mindfulness lesson on the MARIGOLD course'
      end

      def select_look_back_at_journal
        click_on 'Look back at your Mindfulness journal from the course'
      end

      def select_print_bonus_handout
        click_on 'Print out the Mindfulness bonus handout to keep with you'
      end

      def has_commitment_form_visible?
        has_text?('Ready to Make a Commitment') &&
          has_text?(COMMITMENT_CHOICES[0]) &&
          has_text?(COMMITMENT_CHOICES[1]) &&
          has_text?(COMMITMENT_CHOICES[2]) &&
          has_text?(COMMITMENT_CHOICES[3])
      end

      def set_commitment
        @commitment ||= COMMITMENT_CHOICES.sample
        choose @commitment
        if @commitment == 'I will...'
          fill_in 'option', with: 'Example mindfulness commitment'
        end
      end

      def has_commitment?
        text = if @commitment == 'I will...'
                 'Example mindfulness commitment'
               else
                 @commitment
               end

        has_text? text
      end

      def has_commitment_summary_visible?
        has_css?('h1',
                 text: 'My Commitment to Practicing Mindfulness')
      end

      COMMITMENT_CHOICES =
        ['I will spend five minutes (or more) meditating, ' \
          'either on my own or using a guided meditation',
         'I will eat one meal or snack each day mindfully. ' \
          'For at least a few minutes I won\'t talk, read, or ' \
          'look at a screen. I\'ll just pay attention ' \
          'to the experience of eating.',
         'I will spend a few minutes being accepting toward something ' \
          'difficult or painful in my life. That doesn\'t mean liking it ' \
          'or giving up trying to make it better -- just acknowledging ' \
          'that it\'s currently real.',
         'I will pick an ordinary daily activity, such as brushing my teeth ' \
          'or commuting, and pay full attention to it. When I get ' \
          'distracted, I will return my attention to ' \
          'the present moment.',
         'I will...'].freeze
    end
  end
end
