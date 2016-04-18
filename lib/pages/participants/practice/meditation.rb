class Participants
  class Practice
    # page object for the Mediation Module
    class Meditation
      include RSpec::Matchers
      include Capybara::DSL

      def initialize(meditation)
        @type ||= meditation[:type]
        @comment ||= meditation[:comment]
        @activity_time ||= meditation[:activity_time]
      end

      def open
        click_on 'New Meditation Activity'
      end

      def open_review
        click_on 'View Meditation Activities'
      end

      def has_exercises?
        sleep(2)
        actual = (0..4).map { |i| all('.thumbnail')[i].find('h5').text }
        expect(actual).to eq(expected_exercises)
      end

      def has_comments_alert?
        has_css?('.alert', text: 'Comment can\'t be blank')
      end

      def complete
        @type ||= expected_exercises.sample
        select @type, from: 'meditation[description]'
        fill_in 'meditation[comment]', with: @comment
      end

      def has_activity?
        has_css?('tr', text: "#{@type} #{@comment} " \
                             "#{@activity_time.strftime('%b %d %Y %I')}")
      end

      private

      def expected_exercises
        @expected_exercises ||= [
          'Guided-Breathing Meditation',
          'Alternate-Breathing Meditation',
          'Quick Pause for Breathing',
          'Loving-Kindness Meditation',
          'Body-Scan Meditation'
        ]
      end
    end
  end
end
