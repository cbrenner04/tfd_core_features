class Participants
  # page object for Sunnyside features
  class Sunnyside
    include Capybara::DSL

    def check_completed_behavior(num, date)
      behavior = all('.list-group-item.task-status')
      within behavior[num] do
        expect(page).to have_css('.fa.fa-check-circle')
        expect(page).to have_content "Completed at: #{date}"
      end
    end
  end
end
