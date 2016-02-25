require './lib/pages/participants/incentives'

class Participants
  class Incentives
    # page object for Communal Incentives
    class Communal
      include RSpec::Matchers
      include Capybara::DSL

      def initialize(communal_incentive_arry)
        @incentive ||= communal_incentive_arry[:incentive]
        @completed ||= communal_incentive_arry[:completed]
        @total ||= communal_incentive_arry[:total]
        @pt_list_item ||= communal_incentive_arry[:pt_list_item]
      end

      def open
        find('#communal-plot-btn').click
      end

      def has_incomplete_image?
        incentive.has_css?('.flower-translucent')
        incentive.has_css?('img[src = "/assets/flower2.png"]')
      end

      def open_incentives_list
        incentive.click
      end

      def has_group_incentives_listed?
        has_css?('.list-group-item.task-status', count: @total)
      end

      def incomplete?
        within all('.list-group-item.task-status')[@pt_list_item] do
          has_no_css? '.fa.fa-check-circle'
          has_text? 'Completed at: ---'
        end
      end

      def has_image_in_plot?
        find('#garden-communal').has_css? 'img[src = "/assets/flower2.png"]'
      end

      def complete?
        incentives.check_completed_behavior(@pt_list_item,
                                            Time.now.strftime('%b %d %Y %I'))
      end

      private

      def incentive
        find('.panel-title',
             text: "#{@incentive} #{@completed}/#{@total} complete")
      end

      def incentives
        @incentives ||= Participants::Incentives.new
      end
    end
  end
end
