# frozen_string_literal: true
require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'

module Participants
  # page object for the Learn tool
  class Learn
    include Capybara::DSL

    def initialize(learn)
      @lesson_title ||= learn[:lesson_title]
      @reading_duration ||= learn.fetch(:reading_duration, 0)
    end

    def landing_page
      "#{ENV['Base_URL']}/navigator/contexts/LEARN"
    end

    def visible?
      find('h1', text: 'Lessons Week 1')
    end

    def toggle_week_1_panel
      first('.panel-title', text: 'Week 1').click
      sleep(1)
    end

    def has_lesson_visible?
      has_text? @lesson_title
    end

    def read_lesson
      click_on @lesson_title
      sleep(@reading_duration)
      patient_navigation.next
      sleep(1)
      click_on 'Finish'
    end

    def has_read_record?
      has_text? "Read on #{today.strftime('%b %d')}"
    end

    def has_printable_link_visible?
      has_text? 'Printable'
    end

    def has_last_week_listed?
      has_css?('.panel-title.panel-unreleased',
               text: "Week #{last_wk_num} · #{long_date(last_week)}")
    end

    def has_week_listed_beyond_study?
      has_css?('.panel-title.panel-unreleased',
               text: "Week #{after_wk_num} · #{long_date(after_study)}")
    end

    def print
      click_on 'Printable'
      find('a', text: 'Print')
    end

    def return_to_lessons
      click_on 'Return to Lessons'
      find('h3', text: 'Week 1', match: :first)
    end

    def find_in_feed
      social_networking.find_feed_item("Read a Lesson: #{@lesson_title}")
    end

    private

    def patient_navigation
      @patient_navigation ||= Participants::Navigation.new
    end

    def social_networking
      @social_networking ||= Participants::SocialNetworking.new
    end

    def last_wk_num
      return 16 if ENV['tfd']
      return 14 if ENV['sunnyside']
      return 8 if ENV['tfdso']
      return 5 if ENV['marigold']
    end

    def last_week
      return today + 105 if ENV['tfd']
      return today + 91 if ENV['sunnyside']
      return today + 49 if ENV['tfdso']
      return today + 28 if ENV['marigold']
    end

    def after_wk_num
      return 17 if ENV['tfd']
      return 15 if ENV['sunnyside']
      return 9 if ENV['tfdso']
      return 6 if ENV['marigold']
    end

    def after_study
      return today + 112 if ENV['tfd'] || ENV['sunnyside']
      return today + 56 if ENV['tfdso']
      return today + 35 if ENV['marigold']
    end
  end
end
