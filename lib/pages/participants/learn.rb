require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'

module Participants
  # page object for the Learn tool
  class Learn
    include Capybara::DSL

    def initialize(learn)
      @lesson_title ||= learn[:lesson_title]
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
      patient_navigation.next
      click_on 'Finish'
    end

    def has_read_record?
      has_text? "Read on #{Date.today.strftime('%b %d')}"
    end

    def has_printable_link_visible?
      has_text? 'Printable'
    end

    def has_last_week_listed?
      has_css?('.panel-title.panel-unreleased',
               text: "Week #{last_wk_num} · #{last_week.strftime('%b %d %Y')}")
    end

    def has_week_listed_beyond_study?
      has_css?('.panel-title.panel-unreleased',
               text: "Week #{after_wk_num} " \
                     "· #{after_study.strftime('%b %d %Y')}")
    end

    def print
      click_on 'Printable'
      find('a', text: 'Print')
    end

    def return_to_lessons
      click_on 'Return to Lessons'
      find('h3', text: 'Week 1')
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
      @last_wk_num ||= (16 if ENV['tfd']) || (8 if social_networking_app?)
    end

    def last_week
      @last_week ||= (Date.today + 105 if ENV['tfd']) ||
                     (Date.today + 49 if social_networking_app?)
    end

    def after_wk_num
      @after_wk_num ||= (17 if ENV['tfd']) || (9 if social_networking_app?)
    end

    def after_study
      @after_study ||= (Date.today + 112 if ENV['tfd']) ||
                       (Date.today + 56 if social_networking_app?)
    end

    def social_networking_app?
      return true if ENV['tfdso'] || ENV['sunnyside'] || ENV['marigold']
    end
  end
end
