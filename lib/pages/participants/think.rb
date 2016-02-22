class Participants
  # page object for the Think tool
  class Think
    include Capybara::DSL

    def landing_page
      "#{ENV['Base_URL']}/navigator/contexts/THINK"
    end

    def visible?
      has_text? 'Add a New Harmful Thought'
    end

    def identifying_tool
      "#{ENV['Base_URL']}/navigator/modules/954850709"
    end

    def navigate_to_all_modules_through_nav_bar
      tool = ['#2 Patterns', '#1 Identifying', '#3 Reshape',
              'Add a New Harmful Thought', 'Thoughts']
      content = ['Like we said, you are what you think...',
                 'You are what you think...', 'Challenging Harmful Thoughts',
                 'Add a New Harmful Thought', 'Harmful Thoughts']

      tool.zip(content) do |t, c|
        click_on 'THINK'
        click_on t
        has_text? c
      end
    end
  end
end
