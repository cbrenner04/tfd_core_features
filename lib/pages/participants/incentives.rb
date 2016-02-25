class Participants
  # page object for Incentives features
  class Incentives
    include Capybara::DSL

    def check_completed_behavior(num, date)
      within all('.list-group-item')[num] do
        has_css?('.fa.fa-check-circle')
        has_text? "Completed at: #{date}"
      end
    end
  end
end
