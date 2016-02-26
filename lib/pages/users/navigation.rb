require './lib/pages/shared/navigation'

class Users
  # page object for Navigation
  class Navigation
    include Capybara::DSL
    include SharedNavigation

    def arms_page
      "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
    end

    def go_back_to_group_page
      click_on 'Group'
    end

    def go_back_to_home_page
      within('.breadcrumb') { click_on 'Home' }
    end

    def has_home_visible?
      has_text? 'Arms'
    end
  end
end
