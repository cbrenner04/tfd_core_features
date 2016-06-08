require './lib/pages/users/navigation'

module Users
  module PatientDashboards
    # module of phq assessment portion of the Patient Dashboard
    module PHQAssessments
      def has_too_early_suggestion?
        check_score_and_suggestion('.label-warning', 'No; Too Early')
      end

      def has_step_suggestion?
        check_score_and_suggestion('.label-danger', 'YES')
      end

      def has_stay_suggestion?
        check_score_and_suggestion('.label-success', 'No')
      end

      def has_discontinue_suggestion?
        check_score_and_suggestion('.label-success', 'No - Low Scores')
      end

      def open_stepping_details
        patient_row.find('button', text: 'Details').click
      end

      def has_stepping_details?
        within('.modal-content') do
          has_text?("Week 4 - Started on #{short_date(today - 25)}\n" \
                    'Suggestion: Step to t-CBT') &&
            has_css?('.danger.suffix_row', text: "4 (#{short_date(@date)} - " \
                                                 "#{short_date(today + 2)}) " \
                                                 "#{short_date(@date)} 17") &&
            find('tr', text: 'PHQ-9 Score >= 17 for two consecutive weeks')
              .has_css?('.label-danger.label-adj_danger', text: 'True')
        end
      end

      def step
        user_navigation.confirm_with_js if ENV['chrome'] || ENV['safari']
        patient_row.find('input[value = "Step"]').click
        accept_alert "You can't undo this! Please make sure you really want" \
                     ' to STEP this participant before confirming. Otherwise' \
                     ' click CANCEL.' unless ENV['chrome'] || ENV['safari']
      end

      def stepped_successfully?
        find('#patients').has_no_css?('tr', text: 'PHQ-2') &&
          find('#stepped-patients').find('tr', text: 'PHQ-2')
                                   .has_text?("Stepped #{short_date(today)}") &&
          find('#stepped-patients').find('tr', text: 'PHQ-2')
                                   .has_no_text?('Details')
      end

      def has_phq9_data?
        find('#phq9-container').has_text? "Released #{short_date(@date)}" \
                                          " Created #{short_date(@date)}" \
                                          ' 9 * 1 2  1 2 1 1 1  '
      end

      def manage_phqs
        find('.list-group').find('a', text: 'PHQ9').click
        click_on 'Manage'
      end

      def has_phq_management_tool_visible?
        has_css?('h2', text: "PHQ assessments for #{@participant}")
      end

      def create_phq
        click_on 'New Phq assessment'
        (1..9).each { |i| fill_in "phq_assessment_q#{i}", with: '2' }
        user_navigation.scroll_to_bottom
        click_on 'Create Phq assessment'
      end

      def has_new_phq?
        has_css?('.alert', text: 'Phq assessment was successfully created.') &&
          find('tr', text: iso_date(today))
            .has_text?('2 2 2 2 2 2 2 2 2 Edit Delete') &&
          find('tr', text: iso_date(today)).has_css?('.fa.fa-flag', count: '9')
      end

      def has_most_recent_phq_score?
        patient_row.has_text? "#{@most_recent_phq_score} on " \
                              "#{short_date(@date)}"
      end

      def edit_old_phq
        find('tr', text: iso_date(today - 18)).find('a', text: 'Edit').click
        fill_in 'phq_assessment_q3', with: '2'
        fill_in 'phq_assessment_q9', with: '2'
        user_navigation.scroll_to_bottom
        click_on 'Update Phq assessment'
      end

      def has_updated_phq?
        has_css?('.alert', text: 'Phq assessment was successfully updated.') &&
          find('tr', text: iso_date(today - 18))
            .has_text?('1 2 2 1 2 1 1 1 2 Edit Delete') &&
          find('tr', text: iso_date(today - 18))
            .has_css?('.fa.fa-flag', count: '2')
      end

      def navigate_back_to_patients_list
        click_on 'Patient dashboard'
        click_on 'Patients'
      end

      def delete_old_phq
        user_navigation.confirm_with_js
        find('tr', text: iso_date(today - 25)).find('a', text: 'Delete').click
      end

      def has_phq_deleted?
        has_css?('.alert', text: 'Phq assessment was successfully destroyed') &&
          has_no_css?('tr', text: iso_date(today - 25))
      end

      private

      def check_score_and_suggestion(label, suggestion)
        has_most_recent_phq_score? &&
          patient_row.has_css?(label, text: suggestion)
      end
    end
  end
end
