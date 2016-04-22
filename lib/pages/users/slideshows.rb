class Users
  # page object for slideshows
  class Slideshows
    include Capybara::DSL

    def initialize(slideshows)
      @title ||= slideshows[:title]
      @new_title ||= slideshows[:new_title]
    end

    def navigate_to_slideshows
      click_on 'Arm 1'
      click_on 'Manage Content'
      click_on 'Slideshows'
      find('h1', text: 'Listing Slideshows')
    end

    def open
      click_on @title
      find('small', text: @title)
    end

    def visible?
      has_css?('small', text: @title)
    end

    def add_table_of_contents
      click_on 'Add Table of Contents'
    end

    def has_table_of_contents?
      sleep(1)
      find('.ui-sortable').has_text? 'Table of Contents'
    end

    def destroy_table_of_contents
      click_on 'Destroy Table of Contents'
    end

    def create
      click_on 'New'
      fill_in 'slideshow_title', with: @title
      click_on 'Create'
    end

    def created_successfully?
      has_css?('.alert', text: 'Successfully created slideshow') &&
        has_text?(@title)
    end

    def update
      user_navigation.scroll_to_bottom
      click_on @title
      all('.btn-default')[5].click
      fill_in 'slideshow_title', with: @new_title
      click_on 'Update'
    end

    def updated_successfully?
      has_css?('.alert', text: 'Successfully updated slideshow') &&
        has_css?('a', text: @new_title)
    end

    def destroy
      user_navigation.scroll_to_bottom
      click_on @title
      user_navigation.confirm_with_js
      click_on 'Delete'
    end

    def destroyed_successfully?
      has_css?('.alert', text: 'Slideshow deleted') &&
        has_no_text?(@title)
    end

    private

    def user_navigation
      @user_navigation ||= Users::Navigation.new
    end
  end
end
