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

    def done
      click_on 'Done'
    end

    def save
      click_on 'Save'
    end

    def has_new_assignment_in_feel?
      find('.dropdown-toggle', text: 'FEEL').has_text?('New!')
    end

    def has_successful_login_alert?
      has_text? 'Signed in successfully.'
    end

    def has_unsuccessful_login_alert?
      find('#new_participant')
      has_text? 'Invalid email address or password'
    end

    def has_sign_up_alert?
      find('#new_participant')
      has_text? 'You need to sign in or sign up before continuing.'
    end

    def has_no_active_membership_alert?
      has_text? 'We\'re sorry, but you can\'t sign in yet ' \
                'because you are not assigned to an active ' \
                'group'
    end

    def click_brand
      find(:css, '.navbar-brand').click
    end

    def has_home_page_visible?
      has_text? 'HOME'
    end

    def click_on_login_page_slideshow
      click_on "Introduction to #{host_app}"
    end

    def has_password_reset_alert?
      find('#new_participant')
      has_text? 'You will receive an email with ' \
                'instructions on how to reset your password ' \
                'in a few minutes.'
    end

    def open_mobile_menu
      find('#hamburger_button').click
    end

    def navigate_home
      find('a', text: 'Home').click
    end

    private

    def host_app
      if ENV['tfd'] || ENV['tfdso']
        'ThinkFeelDo'
      elsif ENV['sunnyside']
        'Sunnyside'
      elsif ENV['marigold']
        'Marigold'
      end
    end
  end
end
