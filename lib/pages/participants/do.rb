class Participants
  # page object for DO tool
  class DoTool
    include Capybara::DSL

    def landing_page
      @landing_page ||= "#{ENV['Base_URL']}/navigator/contexts/DO"
    end

    def awareness
      @awareness ||= "#{ENV['Base_URL']}/navigator/modules/339588004"
    end

    def navigate_to_all_modules_through_nav_bar
      tool = ['#2 Planning', '#1 Awareness', '#3 Doing', 'Add a New Activity',
              'Your Activities', 'View Planned Activities', 'DO Home']
      content = ['The last few times you were here...',
                 'This is just the beginning...', 'Welcome back!',
                 "But you don't have to start from scratch", 'Daily Averages',
                 'Speech', 'Add a New Activity']
      tool.zip(content) do |t, c|
        click_on 'DO'
        click_on t
        has_text? c
      end
    end

    def has_upcoming_activities_visible?
      has_text? 'Activities in your near future'
    end

    def has_landing_visible?
      has_css?('h1', text: 'Do Landing')
    end

    def review_activities_from_landing
      click_on 'Review'
    end
  end
end