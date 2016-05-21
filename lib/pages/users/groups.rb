module Users
  # page object for groups
  class Groups
    include Capybara::DSL

    def initialize(groups)
      @title ||= groups[:title]
    end

    def open
      click_on @title
      find('p', text: "Title: #{@title}")
    end

    def visible_in_listing?
      has_text? @title
    end
  end
end
