# frozen_string_literal: true
module Participants
  # page object for the Feel tool
  class Feel
    include RSpec::Matchers
    include Capybara::DSL

    def landing_page
      "#{ENV['Base_URL']}/navigator/contexts/FEEL"
    end

    def track_mood_emotions
      "#{ENV['Base_URL']}/navigator/modules/86966983"
    end

    def navigate_to_all_modules_through_navbar
      tools = ['Your Recent Moods & Emotions', 'Tracking Your Mood & Emotions',
               'FEEL Home']
      contents = ['Positive and Negative Emotions', 'Rate your Mood',
                  'Feeling Tracker Landing']
      tools.zip(contents) do |tool, content|
        click_on 'FEEL'
        click_on tool
        expect(page).to have_content content
      end
    end
  end
end
