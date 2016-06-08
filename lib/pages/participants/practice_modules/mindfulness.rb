module Participants
  module PracticeModules
    # page object for the Mindfulness Module
    class Mindfulness
      include RSpec::Matchers
      include Capybara::DSL

      def initialize(mindfulness)
        @activity ||= mindfulness[:activity]
        @planned_for ||= mindfulness[:planned_for]
        @reviewed ||= mindfulness[:reviewed]
        @encouragement ||= mindfulness[:encouragement]
        @emotions ||= mindfulness[:emotions]
        @notes ||= mindfulness[:notes]
        @reminder ||= mindfulness[:reminder]
        @challenges ||= mindfulness[:challenges]
        @noncompliance_reason ||= mindfulness[:noncompliance_reason]
      end

      def open
        click_on 'New Mindfulness Activity'
      end

      def open_review
        click_on 'Review Scheduled Mindfulness Activities'
      end

      def open_view
        click_on 'View Mindfulness Activities'
      end

      def review_completed_activity
        sleep(0.25)
        find('.btn-success').click
        fill_in 'mindful_activity[emotions]', with: @emotions
        fill_in 'mindful_activity[notes]', with: @notes
      end

      def review_incomplete_activity
        find('.btn-danger').click
        fill_in 'mindful_activity[noncompliance_reason]',
                with: @noncompliance_reason
      end

      def view_simple_examples
        click_on 'simple examples'
      end

      def has_simple_examples?
        simple_examples = find('#collapse-simple-examples')
        actual = (0..3).map { |i| simple_examples.all('li')[i].text }
        expect(actual).to eq(EXPECTED_SIMPLE_EXAMPLES)
      end

      def view_elaborate_examples
        click_on 'elaborate examples'
      end

      def has_elaborate_examples?
        elaborate_examples = find('#collapse-elaborate-examples')
        actual = (0..10).map { |i| elaborate_examples.all('li')[i].text }
        expect(actual).to eq(EXPECTED_ELABORATE_EXAMPLES)
      end

      def has_activity_alert?
        has_css?('.alert', text: 'Activity type can\'t be blank')
      end

      def complete
        fill_in 'mindful_activity[activity_type_new_title]',
                with: @activity
        fill_in 'mindful_activity[reminder]', with: @reminder
        fill_in 'mindful_activity[encouragement]', with: @encouragement
        fill_in 'mindful_activity[challenges]', with: @challenges
      end

      def has_planned_activity?
        has_css?('tr', text: "#{@activity} " \
                             "#{long_date_with_hour(@planned_for)}") &&
          has_css?('tr', text: "#{@reviewed} #{@encouragement} #{@reminder} " \
                               "#{@challenges}")
      end

      def has_completed_activity?
        has_css?('tr', text: "#{@activity} " \
                             "#{long_date_with_hour(@planned_for)}") &&
          has_css?('tr', text: "#{@reviewed} #{@encouragement} #{@emotions} " \
                               "#{@notes} #{@reminder} #{@challenges}")
      end

      def has_incomplete_activity?
        has_css?('tr', text: "#{@activity} " \
                             "#{long_date_with_hour(@planned_for)}") &&
          has_css?('tr', text: "#{@reviewed} #{@encouragement} #{@reminder} " \
                               "#{@challenges} #{@noncompliance_reason}")
      end

      EXPECTED_SIMPLE_EXAMPLES = [
        'While you\'re eating, slow down and notice everything you can ' \
        'about your food.',
        'While you\'re talking to someone, really focus on listening to ' \
        'them. Can you tell how they feel? What\'s important to them about' \
        ' what they\'re saying?',
        'While you\'re doing a chore, pay attention to all of the sights, ' \
        'sounds, and sensations. Do you often rush through this without ' \
        'paying attention? Is there anything even a little bit enjoyable ' \
        'or relaxing about it?',
        'Anywhere, anytime, stop for a minute. Breathe slowly and deeply, ' \
        'and notice what\'s going on. What thoughts and feelings were ' \
        'going through your head? Were you stressed? Worried? Energized? ' \
        'Content? What\'s going on around you? What can you see, hear, ' \
        'feel, taste, smell?'
      ].freeze

      EXPECTED_ELABORATE_EXAMPLES = [
        'Washing dishes: Notice your posture and how your body moves. ' \
        'Notice the look and feel of the dishes and the water. Are you ' \
        'doing them slowly or rushing to get done? Be aware of your mood. ' \
        'Breathe.',
        'Driving: Turn the radio off and be with driving. Be aware of your' \
        ' posture, the pressure of your hands on the steering wheel, your ' \
        'body on the seat and your foot on the gas pedal or brake. Notice ' \
        'what parts of your body are tense or relaxed. What is your ' \
        'breathing like? Be with sights and sounds as they come and go. ' \
        'Use mindful attention to see your old route with fresh eyes, or ' \
        'try a new route.',
        'Shopping: Be aware of your intentions. What do you plan to buy? ' \
        'Notice how your attention is pulled by different objects, notice ' \
        'the desire to have or own something. See if you can pause and ' \
        'notice the feeling of wanting something. If you\'re shopping for ' \
        'food, notice what foods are calling to you. See if you can tell ' \
        'whether your body is hungry for them, or your mind.',
        'Washing your hands: Consider where the water comes from, and how ' \
        'valuable it is. Be aware of the posture of your body, the feeling' \
        ' of the water, the soap, the movement of your hands.',
        'Brushing your teeth: Notice how your hands hold the toothbrush, ' \
        'the movement of your arm, the sound of the brush on your teeth. ' \
        'Notice the taste of the toothpaste.',
        'Taking a shower: Be aware of the water: its temperature, where it' \
        ' hits your body. Be aware of your posture, your movements, and ' \
        'your mood.',
        'Walking: Use moments of walking (in the office, at home, to and ' \
        'from your car, shopping, etc.) as a meditation. Be with your ' \
        'posture, the feel of your body moving, how your legs and arms ' \
        'move. Notice the feel of your feet contacting the ground, your ' \
        'breathing, the sights and sounds around you.',
        'Working out/lifting weights: Be aware of how your body feels as ' \
        'you do each exercise. Which muscle is working? Watch your mind ' \
        'wander to other things, and keep bringing it back to what you’re ' \
        'doing and how your body feels with each movement you do.',
        'When you\'re stopped at a red light: Use the moment to pause, ' \
        'breathe, and look at people and at the sky. Become aware of your ' \
        'posture and notice the sensation of your hands on the wheel. How ' \
        'tightly are you holding the wheel? Be aware of your shoulders, ' \
        'back. Notice the pressure of your body on the seat, your thighs, ' \
        'the contact your feet make with the floor, the brake. What sort ' \
        'of thoughts and feelings arise? What is your mood?',
        'When you look at a clock or your watch: Remember to pause and ' \
        'breathe.Try putting your watch on the other arm as a way to ' \
        'remind yourself. Notice how it feels when things are slightly ' \
        'different.',
        'When you open a door: Be aware of reaching for the door, touching' \
        ' it, the movements you use to open it and move through it. ' \
        'Breathe. Be aware of this as a transition.'
      ].freeze
    end
  end
end
