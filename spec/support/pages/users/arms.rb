# frozen_string_literal: true
require './spec/support/pages/users/navigation'

module Users
  # page object for Arms
  class Arms
    include Capybara::DSL

    def initialize(arms)
      @title ||= arms[:title]
      @updated_title ||= arms[:updated_title]
    end

    def open
      click_on @title
    end

    def visible?
      has_text? "Title: #{@title}"
    end

    def create
      click_on 'New'
      fill_in_title(@title)
      user_navigation.scroll_down
      click_on 'Create'
    end

    def created_successfully?
      has_text? 'Arm was successfully created.'
    end

    def update
      click_on 'Edit'
      fill_in_title(@updated_title)
      user_navigation.scroll_down
      click_on 'Update'
    end

    def updated_successfully?
      has_css?('.alert', text: 'Arm was successfully updated.') &&
        has_text?('Title: Updated Testing Arm')
    end

    def has_incorrect_privileges_alert?
      has_text? 'You do not have privileges to delete an ' \
                'arm. Please contact the site administrator ' \
                'to remove this arm.'
    end

    private

    def user_navigation
      @user_navigation ||= Users::Navigation.new
    end

    def fill_in_title(title)
      fill_in 'arm_title', with: title
    end
  end
end
