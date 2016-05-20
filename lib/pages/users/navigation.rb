require './lib/pages/shared/navigation'

class Users
  # page object for Navigation
  class Navigation
    include Capybara::DSL
    include SharedNavigation

    def arms_page
      "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
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
  end
end
