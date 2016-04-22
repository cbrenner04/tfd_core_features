require './lib/pages/users/navigation'

class Users
  # page object for Content Modules
  class ContentModules
    include Capybara::DSL

    def initialize(content_modules)
      @title ||= content_modules[:title]
      @tool ||= content_modules[:tool]
      @position ||= content_modules[:position]
      @new_tool ||= content_modules[:new_tool]
    end

    def navigate_to_content_modules
      click_on 'Arm 1'
      click_on 'Manage Content'
      click_on 'Content Modules'
      find('h1', text: 'Listing Content Modules')
    end

    def create
      click_on 'New'
      complete_content_module_form(@tool)
      click_on 'Create'
    end

    def created_successfully?
      has_css?('.alert', text: 'Content module was successfully created.')
    end

    def open_module
      tries ||= 4
      click_on @title
    rescue Capybara::ElementNotFound
      user_navigation.scroll_to_bottom
      within('.pagination') { user_navigation.next }
      retry unless (tries -= 1).zero?
    end

    def update
      open_module
      find('p', text: @tool)
      click_on 'Edit'
      complete_content_module_form(@new_tool)
      click_on 'Update'
    end

    def updated_successfully?
      has_css?('.alert-success',
               text: 'Content module was successfully updated.') &&
        has_text?("Tool: #{@new_tool}")
    end

    def destroy
      open_module
      user_navigation.confirm_with_js
      click_on 'Destroy'
    end

    def destroyed_successfully?
      has_css?('.alert',
               text: 'Content module along with any associated tasks were ' \
                     'successfully destroyed.') &&
        has_no_text?(@title)
    end

    private

    def user_navigation
      @user_navigation ||= Users::Navigation.new
    end

    def complete_content_module_form(tool)
      fill_in 'content_module_title', with: @title
      select tool, from: 'content_module_bit_core_tool_id'
      fill_in 'content_module_position', with: @position
    end
  end
end
