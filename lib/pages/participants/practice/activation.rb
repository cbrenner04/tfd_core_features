class Participants
  class Practice
    # page object for the Activation Module
    class Activation
      include RSpec::Matchers
      include Capybara::DSL

      def initialize(activation)
        @activity_type ||= activation[:activity_type]
        @planned_for ||= activation[:planned_for]
        @pleasure ||= activation[:pleasure]
        @accomplishment ||= activation[:accomplishment]
        @reminder ||= activation[:reminder]
        @encouragement ||= activation[:encouragement]
        @actual_pleasure ||= activation[:actual_pleasure]
        @actual_accomplishment ||= activation[:actual_accomplishment]
        @reviewed ||= activation[:reviewed]
        @mood_rating ||= activation[:mood_rating]
        @notes ||= activation[:notes]
        @noncompliance_reason ||= activation[:noncompliance_reason]
      end

      def open
        click_on 'New Activation Activity'
      end

      def open_review
        click_on 'View Activation Activities'
      end

      def show_suggestions
        click_on 'click here for some suggestions'
      end

      def has_suggestions?
        encouragement_suggestions = find('#collapse-encouragement-examples')
        actual = (0..5).map { |i| encouragement_suggestions.all('li')[i].text }
        expect(actual).to eq(expected_suggestions)
      end

      def enter_activity_type
        find('#new_activity_radio').click
        fill_in 'planned_activity[activity_type_new_title]',
                with: @activity_type
      end

      def choose_pleasure
        select @pleasure,
               from: 'planned_activity[predicted_pleasure_intensity]'
      end

      def choose_accomplishment
        select @accomplishment,
               from: 'planned_activity[predicted_accomplishment_intensity]'
      end

      def complete_reminder_and_encouragement_fields
        fill_in 'planned_activity[reminder]', with: @reminder
        fill_in 'planned_activity[encouragement]', with: @encouragement
      end

      def has_activity_alert?
        has_css?('.alert', text: 'Select at least one activity.')
      end

      def on_new_activity_form?
        has_css?('h2', text: 'Your Next Activity')
      end

      def complete_new_activity
        enter_activity_type
        choose_pleasure
        choose_accomplishment
        complete_reminder_and_encouragement_fields
      end

      def complete_completed_activity
        find('.btn-success').click
        select @actual_pleasure, from: 'activity[actual_pleasure_intensity]'
        select @actual_accomplishment,
               from: 'activity[actual_accomplishment_intensity]'
        select @mood_rating, from: 'activity[mood_rating]'
        fill_in 'activity[notes]', with: @notes
      end

      def complete_incomplete_activity
        sleep(0.25)
        find('.btn-danger').click
        fill_in 'activity[noncompliance_reason]', with: @noncompliance_reason
      end

      def saved?
        has_css?('.alert', text: 'Activity saved')
      end

      def has_planned_activity?
        has_css?('tr', text: "#{@activity_type} " \
                             "#{@planned_for.strftime('%b %d %Y %I')}") &&
          has_css?('tr', text: "Actual: #{@actual_pleasure} Predicted: " \
                               "#{@pleasure} Actual: " \
                               "#{@actual_accomplishment} Predicted: " \
                               "#{@accomplishment} #{@reviewed} " \
                               "#{@encouragement} #{@reminder}")
      end

      def has_completed_activity?
        has_css?('tr', text: "#{@activity_type} " \
                             "#{@planned_for.strftime('%b %d %Y %I')}") &&
          has_css?('tr', text: "Actual: #{@actual_pleasure} Predicted: " \
                               "#{@pleasure} Actual: " \
                               "#{@actual_accomplishment} Predicted: " \
                               "#{@accomplishment} #{@reviewed} " \
                               "#{@encouragement} #{@mood_rating} #{@notes} " \
                               "#{@reminder}")
      end

      def has_incomplete_activity?
        has_css?('tr', text: "#{@activity_type} " \
                             "#{@planned_for.strftime('%b %d %Y %I')}") &&
          has_css?('tr', text: "Actual: #{@actual_pleasure} Predicted: " \
                               "#{@pleasure} Actual: " \
                               "#{@actual_accomplishment} Predicted: " \
                               "#{@accomplishment} #{@reviewed} " \
                               "#{@encouragement} #{@reminder} " \
                               "#{@noncompliance_reason}")
      end

      private

      def expected_suggestions
        @expected_suggestions ||= [
          'Just getting myself moving will be good for me.',
          'Depression makes me feel like I won\'t enjoy things, but I know I' \
          ' might.',
          'I might enjoy it or I might not... but it\'s worth finding out.',
          'The more I get myself doing pleasant things, the better I\'ll get' \
          ' at breaking out of the harmful spiral.',
          'Even if I don\'t feel like doing anything, I can still do things ' \
          'I want to do.',
          'I won\'t always manage to do it, but I can keep trying.'
        ]
      end
    end
  end
end
