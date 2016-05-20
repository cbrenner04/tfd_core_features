module Participants
  # page object for the Feel tool
  class Feel
    include RSpec::Matchers
    include Capybara::DSL

    def landing_page
      @landing_page ||= "#{ENV['Base_URL']}/navigator/contexts/FEEL"
    end

    def track_mood_emotions
      @track_mood_emotions ||= "#{ENV['Base_URL']}/navigator/modules/86966983"
    end

    def navigate_to_all_modules_through_navbar
      tool = ['Your Recent Moods & Emotions', 'Tracking Your Mood & Emotions',
              'FEEL Home']
      content = ['Positive and Negative Emotions', 'Rate your Mood',
                 'Feeling Tracker Landing']
      tool.zip(content) do |t, c|
        click_on 'FEEL'
        click_on t
        expect(page).to have_content c
      end
    end
  end
end
