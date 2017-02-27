# frozen_string_literal: true
require './spec/support/pages/users/navigation'

module Users
  # page object for Lessons
  class Lessons
    include Capybara::DSL

    def initialize(lessons)
      @lesson ||= lessons[:lesson]
      @slide_title ||= lessons[:slide_title]
      @new_title ||= lessons[:new_title]
    end

    def navigate_to_lessons
      click_on 'Arm 1'
      click_on 'Manage Content'
      click_on_lessons_modules
      visible?
    end

    def visible?
      has_css?('h1', text: 'Listing Lesson Modules')
    end

    def manage_lessons_with_no_tools
      click_on 'Manage Content'
      if page.driver == :firefox
        click_on_lessons_modules
        accept_alert 'A learn tool has to be created in order to ' \
                     'access this page'
      else
        user_navigation.confirm_with_js
        click_on_lessons_modules
      end
    end

    def create
      click_on 'New'
      fill_in 'lesson_title', with: @lesson
      click_on 'Create'
    end

    def created_successfully?
      has_css?('.alert', text: 'Successfully created lesson') &&
        has_css?('small', text: @lesson)
    end

    def open
      click_on @lesson
      find('small', text: @lesson)
    end

    def update
      open
      find('a', text: @slide_title)
      all('.btn-default')[1].click
      fill_in 'lesson_title', with: @new_title
      click_on 'Update'
    end

    def updated_successfully?
      has_css?('.alert', text: 'Successfully updated lesson') &&
        has_text?(@new_title)
    end

    def destory
      within('tr', text: 'Lesson for tests') do
        user_navigation.confirm_with_js
        find('.btn-danger').click
      end
    end

    def destroyed_successfully?
      has_css?('.alert-success', text: 'Lesson deleted.') &&
        has_no_text?('Lessons for tests')
    end

    private

    def user_navigation
      @user_navigation ||= Users::Navigation.new
    end

    def click_on_lessons_modules
      click_on 'Lesson Modules'
    end
  end
end
