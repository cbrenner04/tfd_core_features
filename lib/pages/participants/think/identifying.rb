require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'
require './lib/pages/participants/think'

class Participants
  class Think
    # page object for the Identifying module
    class Identifying
      include RSpec::Matchers
      include Capybara::DSL

      def initialize(think_arry)
        @first_thought ||= think_arry[:first_thought]
        @second_thought ||= think_arry[:second_thought]
        @third_thought ||= think_arry[:third_thought]
      end

      def open
        click_on '#1 Identifying'
        find('h1', text: 'You are what you think')
      end

      def move_to_thought_input
        navigation.next
        ['Helpful thoughts are...', 'Harmful thoughts are:',
         'Some quick examples...'].each do |s|
          find('h1', text: s)
          navigation.scroll_down
          navigation.next
        end
      end

      def complete
        heading = ['Now, your turn...', 'Now list another harmful thought...',
                   'Just one more']
        response = [@first_thought, @second_thought, @third_thought]
        heading.zip(response) do |h, r|
          find('h2', text: h)
          fill_in 'thought_content', with: r
          social_networking.accept_social
          find('.alert-success', text: 'Thought saved')
        end
        find('h1', text: 'Good work')
        navigation.next
        expect(think).to be_visible
      end

      def has_thought_entry_form?
        has_text? 'Now, your turn...'
      end

      private

      def navigation
        @navigation ||= Participants::Navigation.new
      end

      def social_networking
        @social_networking ||= Participants::SocialNetworking.new
      end

      def think
        @think ||= Participants::Think.new
      end
    end
  end
end
