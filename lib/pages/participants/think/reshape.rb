require './lib/pages/participants/navigation'
require './lib/pages/participants/think'

class Participants
  class Think
    # page object for Reshape module
    class Reshape
      include Capybara::DSL

      def initialize(reshape)
        @challenge ||= reshape[:challenge]
        @action ||= reshape[:action]
        @num_thoughts ||= reshape[:num_thoughts]
        @thought ||= reshape[:thought]
        @pattern ||= reshape[:pattern]
      end

      def open
        click_on '#3 Reshape'
        find('h1', text: 'Challenging Harmful Thoughts')
      end

      def move_to_reshape_form
        click_on 'Next'
        find('h2', text: 'You said you had the following unhelpful thoughts:')
        click_on 'Next'
        find('p', text: 'Challenging a thought means')

        begin
          tries ||= 3
          navigation.next
        rescue Selenium::WebDriver::Error::UnknownError
          navigation.scroll_by
          retry unless (tries -= 1).zero?
        end
      end

      def has_reshape_form?
        has_text? 'In case you\'ve forgotten' unless has_text? 'You don\'t have'
      end

      def reshape_multiple_thoughts
        @num_thoughts.times { reshape }
      end

      def reshape
        find('h3', text: 'You said that you thought...')
        navigation.next
        fill_in 'thought[challenging_thought]', with: @challenge
        navigation.scroll_down
        navigation.next
        think.has_success_alert?
        find('p', text: 'Because what you THINK, FEEL, Do')
        navigation.scroll_to_bottom
        navigation.next
        find('label', text: 'What could you do to ACT AS IF you believe this?')
        fill_in 'thought_act_as_if', with: @action
        navigation.next
        think.has_success_alert?
      end

      def find_in_feed
        social_networking.find_feed_item("Reshaped a Thought: #{@thought}")
      end

      def has_feed_details?
        within('.list-group-item.ng-scope',
               text: "Reshaped a Thought: #{@thought}") do
          2.times { navigation.scroll_down }
          social_networking.open_detail

          has_text? "this thought is: #{@thought}" \
                    "\nthought pattern: #{@pattern}" \
                    "\nchallenging thought: #{@challenge}" \
                    "\nas if action: #{@action}"
        end
      end

      private

      def navigation
        @navigation ||= Participants::Navigation.new
      end

      def think
        @think ||= Participants::Think.new
      end
    end
  end
end
