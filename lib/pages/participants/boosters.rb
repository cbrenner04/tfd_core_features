# frozen_string_literal: true
module Participants
  # page object for the Boosters tool in Marigold
  class Boosters
    include Capybara::DSL

    def has_thank_you_visible?
      has_text? 'Thank you for visiting the MARIGOLD booster session!'
    end

    def visible?
      has_text? 'Trying to practice lots of skills at once can be ' \
               'overwhelming. To start with, choose just one skill, ' \
               'and we\'ll suggest a few easy options for practicing it.'
    end

    def click
      click_on 'COMMITMENTS'
    end
  end
end
