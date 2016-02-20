require './lib/pages/participants/navigation'

class Participants
  # page object for the Learn tool
  class Learn
    include Capybara::DSL

    def landing_page
      "#{ENV['Base_URL']}/navigator/contexts/LEARN"
    end

    def toggle_week_1_panel
      first('.panel-title', text: 'Week 1').click
    end

    def has_do_intro_lesson_visible?
      has_text? 'Do - Awareness Introduction'
    end

    def read_do_intro_lesson
      click_on 'Do - Awareness Introduction'
      find('h1', text: 'This is just the beginning...')
      navigation.next
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
      has_text? 'Week 1'
    end

    private

    def navigation
      @navigation ||= Participants::Navigation.new
    end

    def last_wk_num
      @last_wk_num ||= (16 if ENV['tfd']) ||
                       (8 if ENV['tfdso'] || ENV['sunnyside'] ||
                        ENV['marigold'])
    end

    def last_week
      @last_week ||= (Date.today + 105 if ENV['tfd']) ||
                     (Date.today + 49 if ENV['tfdso'] || ENV['sunnyside'] ||
                      ENV['marigold'])
    end

    def after_wk_num
      @after_wk_num ||= (17 if ENV['tfd']) ||
                        (9 if ENV['tfdso'] || ENV['sunnyside'] ||
                         ENV['marigold'])
    end

    def after_study
      @after_study ||= (Date.today + 112 if ENV['tfd']) ||
                       (Date.today + 56 if ENV['tfdso'] || ENV['sunnyside'] ||
                        ENV['marigold'])
    end
  end
end
