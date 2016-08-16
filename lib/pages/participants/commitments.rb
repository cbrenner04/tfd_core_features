# frozen_string_literal: true
module Participants
  # page object for the Commitments tool in Marigold
  class Commitments
    include Capybara::DSL

    def has_thank_you_visible?
      has_text? 'Thank you for visiting the MARIGOLD booster session!'
    end

    def visible?
      has_text? 'Trying to practice lots of skills at once can be ' \
               'overwhelming. To start with, choose just one skill, ' \
               'and we\'ll suggest a few easy options for practicing it.'
    end

    def inaccessible?
      has_css?('.alert', text: 'Boosters Available Soon!')
    end

    def open
      click_on 'COMMITMENTS'
    end

    def has_summary_cant_be_blank_alert?
      has_css?('.alert', text: 'Summary can\'t be blank')
    end

    def has_duration_cant_be_blank_alert?
      has_css?('.alert', text: 'Duration i.e., the minimum time you\'ll stick' \
                               ' to this booster can\'t be blank')
    end

    def has_making_commitment_form_visible?
      has_css?('h1', text: 'Making a Commitment')
    end

    def set_minimum_time
      @minimum_time ||= ['One week', 'Two weeks', 'One month',
                         'Two months'].sample
      choose @minimum_time
    end

    def set_frequency
      participant_navigation.scroll_down
      @frequency ||= ['More than once a day', 'Once a day', 'Every other day',
                      'At least twice a week'].sample
      choose @frequency
    end

    def set_tracking
      @tracking ||= ['Mark off days on a calendar',
                     'Write about it on the marigold website',
                     'Write about it in a personal journal (paper or ' \
                     'electronic)',
                     'Talk to a friend or activity partner',
                     'Track it or post about it online (e.g., blog, tweet, ' \
                     'use a goal-tracking site)'].sample(2)
      @tracking.each { |tracking_choice| check tracking_choice }
    end

    def enter_details
      @details = 'some details'
      fill_in 'commitment[details]', with: @details
    end

    def enter_affirmation
      @affirmation = 'some affirmation'
      fill_in 'commitment[affirmation]', with: @affirmation
    end

    def has_responses?
      has_text?('And will continue for at least ' \
                "#{minimum_time_lookup[@minimum_time]}") &&
        has_text?("I will do it #{@frequency.downcase}") &&
        @tracking.each { |tracking_choice| has_text?(tracking_choice) } &&
        has_text?(@details) && has_text?(@affirmation)
    end

    def sign
      fill_in 'commitment[signature]', with: 'My Signature'
    end

    def done?
      has_text? 'You\'re Done!'
    end

    private

    def minimum_time_lookup
      {
        'One week' => '7 days',
        'Two weeks' => '14 days',
        'One month' => 'about 1 month',
        'Two months' => '2 months'
      }
    end
  end
end
