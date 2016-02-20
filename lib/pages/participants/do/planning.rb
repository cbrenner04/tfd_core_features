require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'

class Participants
  class DoTool
    # page object for the Planning module
    class Planning
      include Capybara::DSL

      def initialize(planning_arry)
        @activity ||= planning_arry[:activity]
        @pleasure ||= planning_arry[:pleasure]
        @accomplishment ||= planning_arry[:accomplishment]
        @entries ||= planning_arry[:entries]
      end

      def open
        click_on '#2 Planning'
      end

      def has_first_slide_visible?
        has_text? 'The last few times you were here...'
      end

      def has_planning_form_visible?
        has_text? 'We want you to plan one fun thing'
      end

      def plan
        find('#new_activity_radio')
        navigation.scroll_down
        find('#new_activity_radio').click
        fill_in 'activity_activity_type_new_title', with: @activity
        navigation.scroll_down
        find('.fa.fa-calendar').click
        pick_tomorrow
        choose_rating('pleasure_0', @pleasure)
        choose_rating('accomplishment_0', @accomplishment)
        social_networking.accept_social
        find('.alert-success', text: 'Activity saved')
      end

      def move_to_review
        find('h1', text: 'OK...')
        click_on 'Next'
      end

      def has_review_page_visible?
        find('h2', text: 'Your Planned Activities')
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
