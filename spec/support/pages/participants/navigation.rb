# frozen_string_literal: true
require './spec/support/pages/shared/navigation'

module Participants
  # page object for navigation for Participants
  class Navigation
    include Capybara::DSL
    include SharedNavigation

    def alt_next
      scroll_to_bottom
      if has_css?('a', text: 'Next', count: 2)
        all('a', text: 'Next')[1].click
      else
        find('a', text: 'Next').click
      end
    end

    def skip
      click_on 'Skip'
    end

    def cancel
      click_on 'Cancel'
    end

    def save
      click_on 'Save'
    end

    def create_new
      click_on 'New'
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

    def has_home_page_visible?
      has_text? 'HOME'
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

    def has_profile_link_in_dropdown?
      find('.navbar-collapse').find('.fa.fa-user.fa-lg').has_text? 'My Profile'
    end

    def has_modal?
      sleep(1)
      has_css?('.modal-content')
    end

    def reload
      execute_script('window.location.reload()')
    end
  end
end
