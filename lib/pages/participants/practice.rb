class Participants
  # page object for PRACTICE
  class Practice
    include Capybara::DSL

    def landing_page
      @langing_page ||= "#{ENV['Base_URL']}/navigator/contexts/PRACTICE"
    end

    def has_practice_for_this_week?
      first('.col-md-6').has_css?('h3', text: 'Practice for this Week')
    end

    def has_past_practice?
      all('.col-md-6')[1].has_css?('h3', text: 'Past Practice')
    end
  end
end
