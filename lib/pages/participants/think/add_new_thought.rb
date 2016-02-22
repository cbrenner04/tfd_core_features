class Participants
  class Think
    # page object for the Add a New Thought module
    class AddNewThought
      include Capybara::DSL

      def iniitialize(add_new_thought_arry)
        @thought ||= add_new_thought_arry[:thought]
        @pattern ||= add_new_thought_arry[:pattern]
        @challenge ||= add_new_thought_arry[:challenge]
        @action ||= add_new_thought_arry[:action]
      end

      def open
        click_on 'Add a New Harmful Thought'
        find('h2', text: 'Add a New Harmful Thought')
      end

      def complete
        fill_in 'thought_content', with: @thought
        select @pattern, from: 'thought_pattern_id'
        fill_in 'thought_challenging_thought', with: @challenge
        fill_in 'thought_act_as_if', with: @action
        navigation.scroll_to_bottom
        social_networking.accept_social
        find('.alert-success', text: 'Thought saved')
        navigation.scroll_to_bottom
        find('.btn.btn-primary.pull-right').click
      end
    end
  end
end
