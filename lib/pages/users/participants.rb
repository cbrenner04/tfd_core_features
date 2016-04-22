class Users
  # page object for Participants
  class ResearcherPatients
    include Capybara::DSL

    def landing_page
      "#{ENV['Base_URL']}/think_feel_do_dashboard/participants"
    end
  end
end
