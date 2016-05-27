module Participants
  # page object for DO tool
  class DoTool
    include RSpec::Matchers
    include Capybara::DSL

    def landing_page
      @landing_page ||= "#{ENV['Base_URL']}/navigator/contexts/DO"
    end

    def awareness
      @awareness ||= "#{ENV['Base_URL']}/navigator/modules/339588004"
    end

    def choose_rating(element_id, value)
      find("##{element_id} select")
        .find(:xpath, "option[#{(value + 1)}]").select_option
    end

    def navigate_to_all_modules_through_nav_bar
      tool = ['#2 Planning', '#1 Awareness', 'View Planned Activities',
              '#3 Doing', 'Add a New Activity', 'Your Activities', 'DO Home']
      content = ['The last few times you were here...',
                 'This is just the beginning...', 'Speech', 'Welcome back!',
                 "But you don't have to start from scratch", 'Daily Averages',
                 'Add a New Activity']
      tool.zip(content) do |t, c|
        click_on 'DO'
        click_on t
        expect(page).to have_content c
      end
    end

    def has_success_alert?
      has_css?('.alert-success', text: 'Activity saved')
    end

    def has_upcoming_activities_visible?
      has_text? 'Activities in your near future'
    end

    def has_landing_visible?
      sleep(1)
      has_css?('h1', text: 'Do Landing')
    end

    def review_activities_from_landing
      click_on 'Review'
    end
  end
end
