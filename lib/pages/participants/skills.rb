# frozen_string_literal: true
module Participants
  # page object for the SKILLS tool
  class Skills
    include Capybara::DSL

    def initialize(skills)
      @lesson ||= skills[:lesson]
    end

    def landing_page
      "#{ENV['Base_URL']}/navigator/contexts/SKILLS"
    end

    def unavailable?
      has_css?('.disabled', text: @lesson)
    end

    def available?
      has_css?('.enabled', text: @lesson)
    end

    def open_lesson
      click_on @lesson
    end

    def finish
      click_on 'Finish'
    end

    def on_feedback_slide?
      has_css?('h2', text: 'Lesson Feedback')
    end

    def rate
      rating = (1..5).to_a.sample
      find("#star#{rating}").click
    end

    def enter_feedback
      fill_in 'Your answer', with: 'New feedback response'
    end

    def has_feedback_saved?
      has_css?('.alert', text: 'Lesson Feedback saved')
    end
  end
end
