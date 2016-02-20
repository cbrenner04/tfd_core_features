class Participants
  # page object for the Think tool
  class Think
    include Capybara::DSL

    def compare_thought(thought)
      page.execute_script('window.scrollBy(0,500)')
      accept_social
      find('.alert-success', text: 'Thought saved')
      within('.panel-body.adjusted-list-group-item') do
        expect(page).to_not have_content thought
      end
      find('.panel-body.adjusted-list-group-item').text
    end

    def reshape(challenge, action)
      find('h3', text: 'You said that you thought...')
      click_on 'Next'
      fill_in 'thought[challenging_thought]', with: challenge
      page.execute_script('window.scrollBy(0,500)')
      click_on 'Next'
      find('.alert-success', text: 'Thought saved')
      find('p', text: 'Because what you THINK, FEEL, Do')
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Next'
      find('label', text: 'What could you do to ACT AS IF you believe this?')
      fill_in 'thought_act_as_if', with: action
      click_on 'Next'
      find('.alert-success', text: 'Thought saved')
    end
  end
end
