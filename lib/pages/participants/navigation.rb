class Participants
  # page object for navigation for Participants
  class Navigation
    include Capybara::DSL

    def next
      click_on 'Next'
    end

    def scroll_to_bottom
      execute_script('window.scrollTo(0,5000)')
    end

    def scroll_down
      execute_script('window.scrollBy(0,500)')
    end

    def skip
      click_on 'Skip'
    end

    def cancel
      click_on 'Cancel'
    end
  end
end
