class Participants
  # page object for PRACTICE
  class Practice
    include Capybara::DSL

    def landing_page
      @langing_page ||= "#{ENV['Base_URL']}/navigator/contexts/PRACTICE"
    end
  end
end
