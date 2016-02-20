class Participants
  # page object for DO tool
  class DoTool
    include Capybara::DSL

    def landing_page
      @landing_page ||= "#{ENV['Base_URL']}/navigator/contexts/DO"
    end
  end
end
