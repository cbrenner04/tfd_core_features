module Users
  # page object for groups
  class Groups
    include Capybara::DSL

    def initialize(groups)
      @title ||= groups[:title]
      @arm ||= groups[:arm]
      @moderator ||= groups[:moderator]
      @updated_title ||= groups[:updated_title]
      @updated_moderator ||= groups[:updated_moderator]
      @task ||= groups[:task]
      @task_release_day ||= groups[:task_release_day]
    end

    def open
      click_on @title
      find('p', text: "Title: #{@title}")
    end

    def visible_in_listing?
      has_text? @title
    end

    def go_back_to_group_page
      click_on 'Group'
      find('p', text: "Title: #{@title}")
    end

    def create
      click_on 'New'
      fill_in_group_title(@title)
      select @arm, from: 'group_arm_id'
      select_moderator(@moderator) unless ENV['tfd']
      click_on 'Create'
    end

    def fill_in_group_title(title)
      fill_in 'group_title', with: title
    end

    def created_successfully?
      has_text? 'Group was successfully created.'
    end

    def update_title
      click_on 'Edit'
      fill_in_group_title(@updated_title)
      click_on 'Update'
    end

    def updated_successfully?
      has_css?('.alert', text: 'Group was successfully updated.')
    end

    def has_updated_group_title?
      has_text? "Title: #{@updated_title}"
    end

    def select_moderator(moderator)
      select moderator, from: 'group_moderator_id'
    end

    def update_moderator
      click_on 'Edit'
      select_moderator(@updated_moderator)
      click_on 'Update'
    end

    def has_updated_moderator?
      has_text? "Coach/Moderator: #{@updated_moderator}"
    end

    def destroyed_successfully?
      has_css?('.alert', text: 'Group was successfully destroyed.')
    end

    def assign_task
      click_on 'Manage Tasks'
      select @task, from: 'task_bit_core_content_module_id'
      fill_in 'task_release_day', with: @task_release_day
      click_on 'Assign'
    end

    def has_task_assigned_successfully?
      has_text? 'Task assigned.'
    end

    def unassign_task
      click_on 'Manage Tasks'
      find('h1', text: 'Manage Task')
      user_navigation.scroll_to_bottom
      within('tr', text: @task) do
        user_navigation.confirm_with_js
        click_on 'Unassign'
      end
    end

    def has_task?
      sleep(1)
      find('#tasks').has_text? @task
    end
  end
end
