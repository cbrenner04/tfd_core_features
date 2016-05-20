module Participants
  module PracticeModules
    # page object for the Positive Events Module
    class PositiveEvents
      include RSpec::Matchers
      include Capybara::DSL

      def initialize(positive_events)
        @description ||= positive_events[:description]
        @emotions ||= positive_events[:emotions]
        @thoughts ||= positive_events[:thoughts]
        @body_feelings ||= positive_events[:body_feelings]
        @challenging_amplification ||=
          positive_events[:challenging_amplification]
      end

      def open
        click_on 'New Positive Events'
      end

      def open_review
        click_on 'View Positive Events'
      end

      def has_questions?
        find('.control-label', match: :first)
        actual = (0..4).map { |i| all('.control-label')[i].text }
        expect(actual).to eq(expected_questions)
      end

      def show_examples
        first('a', text: 'see some examples').click
      end

      def has_examples?
        examples_list = find('#collapse-experience-examples')
        actual = (0..7).map { |i| examples_list.all('li')[i].text }
        expect(actual).to eq(expected_examples)
      end

      def show_amplifying_examples
        click_on 'see some examples for amplifying positive events'
      end

      def has_amplifying_examples?
        amplifying_examples = find('#collapse-amplify-examples')
        actual = (0..4).map { |i| amplifying_examples.all('li')[i].text }
        expect(actual).to eq(expected_amplifying_examples)
      end

      def has_description_alert?
        has_css?('.alert', text: 'Description can\'t be blank')
      end

      def complete
        fill_in 'experience[description]', with: @description
        fill_in 'experience[emotions]', with: @emotions
        fill_in 'experience[thoughts]', with: @thoughts
        fill_in 'experience[body_feelings]', with: @body_feelings
        fill_in 'experience[challenging_amplification]',
                with: @challenging_amplification
      end

      def saved?
        has_css?('.alert', text: 'Experience saved')
      end

      def has_events?
        has_css?('.list-group-item',
                 text: "#{@description} Your emotions during the experience:" \
                       " #{@emotions} Your thoughts during the experience: " \
                       "#{@thoughts} How your body felt: #{@body_feelings} " \
                       'How you amplifed/savored this experience: ' \
                       "#{@challenging_amplification}")
      end

      private

      def expected_questions
        @expected_questions ||= [
          'Describe something good that happened in the past day.',
          'What feelings did you have while it was happening?',
          'What thoughts did you have while it was happening?',
          'How did your body feel?',
          'Did you do anything to amplify or savor it? You can also think of' \
          ' an opportunity to do something right now!'
        ]
      end

      def expected_examples
        @expected_examples ||= [
          'Eating your favorite food',
          'Hearing a song you like',
          'Drinking coffee in the morning',
          'Getting exercise or a good night\'s sleep',
          'Playing video games or seeing something funny online',
          'A friend or family member doing something nice for you (giving you' \
          ' a hug, doing a chore, bringing you a small gift)',
          'Nice weather or scenery',
          '... anything at all that went well (or better than you might have ' \
          'expected)'
        ]
      end

      def expected_amplifying_examples
        @expected_amplifying_examples ||= [
          'Telling a friend or loved one',
          'Writing about it in a journal or online',
          'Celebrating (cheering, pumping your fist, smiling)',
          'Taking a minute to savor it',
          'Stopping to appreciate it and make sure you don\'t get distracted'
        ]
      end
    end
  end
end
