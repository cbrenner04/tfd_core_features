require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'

class Participants
  class DoTool
    # page object for the Planning module
    class Planning
      include Capybara::DSL

      def initialize(planning_arry)
        @first_activity ||= planning_arry[:first_activity]
        @first_pleasure ||= planning_arry[:first_pleasure]
        @first_accomplishment ||= planning_arry[:first_accomplishment]
        @second_activity ||= planning_arry[:second_activity]
        @second_pleasure ||= planning_arry[:second_pleasure]
        @second_accomplishment ||= planning_arry[:second_accomplishment]
        @entries ||= planning_arry[:entries]
      end

      def open
        click_on '#2 Planning'
      end

      def plan_first_activity
        plan(@first_activity, @first_pleasure, @first_accomplishment)
      end

      def plan_second_activity
        plan(@second_activity, @second_pleasure, @second_accomplishment)
      end

      def move_to_review
        find('h1', text: 'OK...')
        click_on 'Next'
      end

      def has_entries?
        find('#previous_activities').have_css?('tr', count: @entries)
      end

      def finish
        click_on 'Next'
        find('h1', text: 'Do Landing')
      end

      private

      def navigation
        @navigation ||= Participants::Navigation.new
      end

      def social_networking
        @social_networking ||= Participants::SocialNetworking.new
      end

      def plan(activity, pleasure, accomplishment)
        find('#new_activity_radio')
        navigation.scroll_down
        find('#new_activity_radio').click
        fill_in 'activity_activity_type_new_title', with: activity
        navigation.scroll_down
        find('.fa.fa-calendar').click
        pick_tomorrow
        choose_rating('pleasure_0', pleasure)
        choose_rating('accomplishment_0', accomplishment)
        social_networking.accept_social
        find('.alert-success', text: 'Activity saved')
      end

      def pick_tomorrow
        tomorrow = Date.today + 1
        within('#ui-datepicker-div') do
          unless has_no_css?('.ui-datepicker-unselectable.ui-state-disabled',
                             text: "#{tomorrow.strftime('%-e')}")
            find('.ui-datepicker-next.ui-corner-all').click
          end
          click_on tomorrow.strftime('%-e')
        end
      end
    end
  end
end
