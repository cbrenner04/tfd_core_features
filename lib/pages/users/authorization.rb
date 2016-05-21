module Users
  # module for checking authorization
  module Authorization
    include Capybara::DSL

    def has_clinician_dashboard_buttons?
      all('.btn', count: clinician_buttons.count)
      button_names.should =~ clinician_buttons
    end

    def has_researcher_dashboard_buttons?
      all('.btn', count: researcher_buttons.count)
      button_names.should =~ researcher_buttons
    end

    def has_super_user_arms_buttons?
      all('.btn', count: super_user_arms_buttons.count)
      button_names.should =~ super_user_arms_buttons
    end

    def has_super_user_groups_buttons?
      all('.btn', count: super_user_groups_buttons.count)
      button_names.should =~ super_user_groups_buttons
    end

    private

    def button_names
      # find('.btn', match: :first)
      all('.btn').map(&:text)
    end

    def clinician_buttons
      if ENV['tfd']
        ['Arm', 'Patient Dashboard', 'Messaging']
      elsif ENV['tfdso']
        ['Arm', 'Patient Dashboard', 'Messaging', 'Group Dashboard',
         'Moderate', 'Manage Profile Questions']
      elsif ENV['sunnyside'] || ENV['marigold']
        ['ARM', 'PATIENT DASHBOARD', 'GROUP DASHBOARD', 'MESSAGING',
         'MODERATE', 'MANAGE PROFILE QUESTIONS', 'MANAGE INCENTIVES']
      end
    end

    def researcher_buttons
      if ENV['tfd']
        ['Arm', 'Manage Tasks', 'Edit', 'Destroy']
      elsif ENV['tfdso']
        ['Arm', 'Manage Tasks', 'Edit', 'Destroy', 'Moderate',
         'Manage Profile Questions']
      elsif ENV['sunnyside'] || ENV['marigold']
        ['ARM', 'MANAGE TASKS', 'EDIT', 'DESTROY', 'MODERATE',
         'MANAGE PROFILE QUESTIONS', 'MANAGE INCENTIVES']
      end
    end

    def super_user_arms_buttons
      if ENV['tfd'] || ENV['tfdso']
        ['Edit', 'Manage Content', 'Destroy']
      elsif ENV['sunnyside'] || ENV['marigold']
        ['EDIT', 'MANAGE CONTENT', 'DESTROY']
      end
    end

    def super_user_groups_buttons
      if ENV['tfd']
        ['Arm', 'Patient Dashboard', 'Messaging', 'Manage Tasks', 'Edit',
         'Destroy']
      elsif ENV['tfdso']
        ['Arm', 'Patient Dashboard', 'Messaging', 'Manage Tasks', 'Edit',
         'Destroy', 'Group Dashboard', 'Moderate',
         'Manage Profile Questions']
      elsif ENV['sunnyside'] || ENV['marigold']
        ['ARM', 'PATIENT DASHBOARD', 'MESSAGING', 'MANAGE TASKS', 'EDIT',
         'DESTROY', 'GROUP DASHBOARD', 'MODERATE', 'MANAGE INCENTIVES',
         'MANAGE PROFILE QUESTIONS']
      end
    end
  end
end
