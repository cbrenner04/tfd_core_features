require './lib/pages/participants/navigation'

class Participants
  class Think
    # page object for Reshape module
    class Reshape
      include Capybara::DSL

      def initialize(reshape_arry)
        @challenge ||= reshape_arry[:challenge]
        @action ||= reshape_arry[:action]
        @num_thoughts ||= reshape_arry[:num_thoughts]
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

      private

      def navigation
        @navigation ||= Participants::Navigation.new
      end

      def reshape
        find('h3', text: 'You said that you thought...')
        navigation.next
        fill_in 'thought[challenging_thought]', with: @challenge
        navigation.scroll_by
        navigation.next
        find('.alert-success', text: 'Thought saved')
        find('p', text: 'Because what you THINK, FEEL, Do')
        navigation.scroll_to_bottom
        navigation.next
        find('label', text: 'What could you do to ACT AS IF you believe this?')
        fill_in 'thought_act_as_if', with: @action
        navigation.next
        find('.alert-success', text: 'Thought saved')
      end
    end
  end
end
