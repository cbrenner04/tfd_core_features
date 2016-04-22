class Users
  # page object for slideshows
  class Slideshows
    include Capybara::DSL

    def initialize(slideshows)
      @title ||= slideshows[:title]
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
  end
end
