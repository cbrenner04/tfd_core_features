class Participants
  # page object for Social networking functionality
  class SocialNetworking
    include Capybara::DSL

    def accept_social
      driver.execute_script('window.confirm = function() {return true}')
      click_on 'Next'
    end
  end
end
