# frozen_string_literal: true
require './lib/pages/participants/navigation'

module Participants
  module FeelModules
    # page object for Emotions Tracking specific to Marigold
    class EmotionsTracking
      include RSpec::Matchers
      include Capybara::DSL

      def open
        click_on 'Emotions'
      end

      def has_emotions?
        find('tr', match: :first)
        actual = (1..26).map { |i| all('tr')[i].find('th').text }
        expect(actual).to eq emotions
      end

      def rate
        emotions_to_rate = emotions.sample(5)
        emotions_to_rate.each { |emotion| rate_each(emotion) }
        participant_navigation.scroll_to_bottom
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

      def previously_completed_today?
        has_css?('.alert', text: 'Well done! You have already successfully ' \
                                 'recorded your emotions and daily stressors')
      end

      def complete_dice
        sleep(2)
        (1..7).each do |question_index|
          question = all('.form-group')[question_index - 1]
          answer = ["0 - Didn't happen", '1 - Not at all stressful', '2', '3',
                    '4 - Very stressful'].sample
          within(question) { choose answer }
        end
        participant_navigation.scroll_to_bottom
        participant_navigation.confirm_with_js if ENV['chrome'] || ENV['safari']
        participant_navigation.next
      end

      def has_dice_saved?
        has_css?('.alert', text: 'Stress Assessment saved')
      end

      private

      def participant_navigation
        @participant_navigation ||= Participants::Navigation.new
      end

      def emotions
        @emotions ||= [
          'Amused or fun-loving', 'Angry, irritated, or frustrated',
          'Ashamed or humiliated', 'Anxious or scared',
          'Awe, wonder, or inspiration', 'Bored',
          'Contempt, scorn, or disdain', 'Content', 'Disgusted',
          'Embarrassed', 'Excited, eager, or enthusiastic', 'Grateful',
          'Guilty', 'Happy', 'Hatred, distrust, or suspicion',
          'Hopeful or optimistic', 'Inspired or uplifted', 'Interested',
          'Lonely or rejected', 'Love, closeness, or trust',
          'Proud or confident', 'Sad', 'Stressed or overwhelmed',
          'Surprised or amazed', 'Sympathy or compassion', 'Relieved'
        ].sort
      end

      def rate_each(emotion)
        execute_script('window.scrollTo(0,-5000)') # start at the top
        begin
          tries ||= 2
          find('tr', text: emotion)
            .find("input[value = '#{(1..9).to_a.sample}']").click
        rescue Selenium::WebDriver::Error::UnknownError
          participant_navigation.scroll_down
          retry unless (tries -= 1).zero?
        end
      end
    end
  end
end
