require './lib/pages/shared/navigation'
require './lib/pages/users/authorization'

module Users
  # page object for Navigation
  class Navigation
    include Capybara::DSL
    include SharedNavigation
    include Users::Authorization

    def arms_page
      "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
    end

    def groups_page
      "#{ENV['Base_URL']}/think_feel_do_dashboard/groups"
    end

    def dashboard
      "#{ENV['Base_URL']}/think_feel_do_dashboard"
    end

    def return_to_arm
      click_on 'Arm'
    end

    def go_back_to_arms_page
      within('.breadcrumb') { click_on 'Arms' }
      find('h1', text: 'Arms')
    end

    def go_back_to_group_page
      click_on 'Group'
      find('p', text: 'Title: Group 1')
    end

    def go_back_to_groups_page
      within('.breadcrumb') { click_on 'Groups' }
      find('.list-group-item', text: 'Group 3')
    end

    def go_back_to_participants_page
      within('.breadcrumb') { click_on 'Participants' }
      find('.list-group-item', text: 'participant61')
    end

    def go_back_to_users_page
      within('.breadcrumb') { click_on 'Users' }
      find('.list-group-item', text: 'admin1@example.com')
    end

    def go_back_to_home_page
      within('.breadcrumb') { click_on 'Home' }
    end

    def has_home_visible?
      has_text? "Arms\nNavigate to groups and participants through arms."
    end

    def has_invalid_login?
      has_text? 'Invalid email address or password'
    end

    def has_sign_in_needed_alert?
      has_text? 'You need to sign in or sign up before continuing'
    end

    def has_password_reset_alert?
      find('#new_user')
      has_text? 'You will receive an email with ' \
                'instructions on how to reset your password ' \
                'in a few minutes.'
    end

    def has_all_home_navigation_options?
      has_text? "Arms\nNavigate to groups and participants " \
                "through arms.\nGroups\nCreate, update, " \
                'delete, and associate groups with arms ' \
                "along with set moderators.\nParticipants" \
                "\nCreate, update, and delete participants " \
                "along with assigning them to groups.\nUsers" \
                "\nCreate and view super users, clinicians, " \
                "researchers, and content authors.\nCSV " \
                "Reports\nDownload data via csv."
    end
  end
end
