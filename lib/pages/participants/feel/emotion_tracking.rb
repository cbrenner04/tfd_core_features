require './lib/pages/participants/navigation'

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
        actual.should =~ emotions
      end

      def rate
        emotions_to_rate = emotions.sample(5)
        emotions_to_rate.each do |emotion|
          find('tr', text: emotion)
            .find("input[value = '#{(0..4).to_a.sample}']").click
        end
        participant_navigation.confirm_with_js if ENV['chrome'] || ENV['safari']
        participant_navigation.next
        unless ENV['chrome'] || ENV['safari']
          accept_alert 'Looks like you have not answered all the questions. ' \
                       'Please choose \'Cancel\' if you\'d like to go back ' \
                       'and respond. If you\'d like to proceed without ' \
                       'answering the questions please choose \'OK\'.'
        end
      end

      def saved?
        has_css?('.alert', text: 'Emotional Rating saved')
      end

      private

      def participant_navigation
        @participant_navigation ||= Participants::Navigation.new
      end

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
