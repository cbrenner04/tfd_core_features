class Participants
  class Feel
    # page object for Emotions Tracking specific to Marigold
    class EmotionsTracking
      include RSpec::Matchers
      include Capybara::DSL

      def open
        click_on 'Emotions'
      end

      def has_emotions?
        find('tr', match: :first)
        actual = (1..23).map { |i| all('tr')[i].find('th').text }
        expect(actual).to eq(emotions)
      end

      def rate_emotions
        emotions_to_rate = emotions.sample(5)
        emotions_to_rate.each do |emotion|
          find('tr', text: emotion)
            .find("input[value = '#{(0..4).to_a.sample}']").click
        end
      end

      def saved?
        has_css?('.alert', text: 'Emotional Rating saved')
      end

      private

      def emotions
        @emotions ||= [
          'amused, fun-loving',
          'angry, irritated, frustrated',
          'anxious, scared',
          'awe, wonder, inspiration',
          'bored',
          'contempt, score, disdain',
          'content',
          'disgusted',
          'embarrassed',
          'excited, eager, enthusiastic',
          'grateful',
          'guilty',
          'happy',
          'hatred, disgust, suspicion',
          'hopeful, optimistic',
          'interested',
          'lonely, rejected',
          'love, closeness, trust',
          'proud, confident',
          'sad',
          'stressed, overwhelmed',
          'sympathy, compassion',
          'relieved'
        ]
      end
    end
  end
end
