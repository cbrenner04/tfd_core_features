class Participants
  class DoTool
    # page object for the Activity Viz
    class ActivityVisualization
      include Capybara::DSL

      def open
        click_on 'Your Activities'
      end

      def visible?
        has_text? "Daily Averages for #{Date.today.strftime('%b %d %Y')}"
      end
    end
  end
end
