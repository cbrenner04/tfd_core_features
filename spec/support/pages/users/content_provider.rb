# frozen_string_literal: true
require './spec/support/pages/users/navigation'

module Users
  # page object for content providers
  class ContentProvider
    include Capybara::DSL

    def initialize(content_provider)
      @tool ||= content_provider[:tool]
      @module_title ||= content_provider[:module_title]
      @title ||= content_provider[:title]
      @provider_type ||= content_provider[:provider_type]
      @content_type ||= content_provider[:content_type]
      @provider_content ||= content_provider[:provider_content]
      @position ||= content_provider[:position]
    end

    def create
      click_on 'New Provider'
      find('#content_provider_bit_core_content_module_id',
           text: "#{@tool}: #{@module_title}")
      select @provider_type, from: 'content_provider_type'
      select @content_type, from: 'content_provider_source_content_type'
      select @provider_content, from: 'content_provider_source_content_id'
      fill_in 'content_provider_position', with: @position
      user_navigation.scroll_down
      check 'content_provider_show_next_nav'
      check 'content_provider_is_skippable_after_first_viewing'
      user_navigation.scroll_down
      click_on 'Create'
    end

    def created_successfully?
      has_css?('.alert', text: 'ContentProvider was successfully created.') &&
        has_text?("Tool: #{@tool}" \
                  "\nModule: #{@module_title}" \
                  "\nPosition: #{@position} / #{@position}" \
                  "\nIs skippable after first viewing: true" \
                  "\nSlideshow: #{@provider_content}")
    end

    def update
      find('strong', text: 'Tool:')
      click_on @title
      find('p', text: 'Is skippable after first viewing:')
      click_on 'Edit'
      fill_in 'content_provider_position', with: @position
      user_navigation.scroll_to_bottom
      click_on 'Update'
    end

    def updated_successfully?
      has_css?('.alert', text: 'ContentProvider was successfully updated.') &&
        has_text?("Position: #{@position} / #{@position}")
    end

    def open_provider
      find('strong', text: 'Tool:')
      click_on @title
      find('h1', text: 'Content Provider')
    end

    def destroyed_successfully?
      has_css?('.alert', text: 'Content provider was successfully destroyed.')
    end

    private

    def user_navigation
      @user_navigation ||= Users::Navigation.new
    end
  end
end
