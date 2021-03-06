# frozen_string_literal: true
# filename: ./spec/features/user/core/coach_patients_spec.rb

require './spec/support/users/coach_patients_helper'

feature 'Patient Dasbhoard', :core, :marigold, sauce: sauce_labs do
  feature 'Group 1' do
    background(:all) { clinician.sign_in } if ENV['safari']

    background do
      clinician.sign_in unless ENV['safari']
      visit user_navigation.arms_page
      arm_1.open
      group_1.open
      patient_table_group_1.open
    end

    scenario 'Coach views active participants assigned to them' do
      expect(participant_1_patient_table).to have_participant_visible
    end

    scenario 'Coach views inactive participants assigned to them' do
      patient_table_group_1.navigate_to_inactive_patients

      expect(completer_patient_table).to have_participant_visible
    end

    scenario 'Coach selects Terminate Access' do
      withdraw_patient_table.terminate_access

      expect(withdraw_patient_table).to_not have_participant_visible

      patient_table_group_1.navigate_to_inactive_patients

      expect(withdraw_patient_table).to have_withdrawal_date
    end

    scenario 'Coach uses breadcrumbs to return to home' do
      group_1.go_back_to_group_page
      user_navigation.go_back_to_home_page

      expect(user_navigation).to have_home_visible
    end
  end

  feature 'Participant \'TFD-Data\'' do
    background(:all) { clinician.sign_in } if ENV['safari']

    background do
      clinician.sign_in unless ENV['safari']
      visit user_navigation.arms_page
      arm_1.open
      group_1.open
      patient_table_group_1.open
      data_patient_table.select_patient
    end

    scenario 'Coach views General Patient Info' do
      expect(data_dashboard).to have_general_patient_info
    end

    scenario 'Coach views Login Info' do
      expect(data_dashboard).to have_login_info
    end

    scenario 'Coach uses the table of contents in the patient report' do
      dashboard_table_of_contents.select_all_links
      dashboard_table_of_contents.select_activity_viz

      expect(patient_dashboard_group_1).to have_activity_viz_visible

      patient_dashboard_group_1.return_to_dashboard

      expect(patient_dashboard_group_1).to be_visible

      dashboard_table_of_contents.select_thoughts_viz

      expect(patient_dashboard_group_1).to have_thoughts_viz_container

      patient_dashboard_group_1.return_to_dashboard

      expect(patient_dashboard_group_1).to be_visible
    end

    scenario 'Coach views Mood and Emotions viz' do
      dashboard_table_of_contents.select_mood_emotions_viz

      expect(patient_dashboard_group_1).to have_mood_emotions_viz_visible
    end

    scenario 'Coach navigates to 28 day view in Mood and Emotions viz' do
      dashboard_table_of_contents.select_mood_emotions_viz
      within(patient_dashboard_group_1.mood_emotions_viz) do
        expect(patient_dashboard_group_1).to have_week_view_visible

        patient_dashboard_group_1.switch_to_28_day_view

        expect(patient_dashboard_group_1).to have_28_day_view_visible
      end
    end

    scenario 'Coach navigates to Previous Period in Mood and Emotions viz' do
      dashboard_table_of_contents.select_mood_emotions_viz
      within(patient_dashboard_group_1.mood_emotions_viz) do
        patient_dashboard_group_1.switch_to_previous_period

        expect(patient_dashboard_group_1).to have_previous_period_visible
      end
    end

    scenario 'Coach views Mood' do
      dashboard_table_of_contents.select_mood

      expect(data_dashboard).to have_mood_data
    end

    scenario 'Coach views Feelings' do
      dashboard_table_of_contents.select_feel

      expect(data_dashboard).to have_feelings_data
    end

    scenario 'Coach views Logins' do
      dashboard_table_of_contents.select_logins

      expect(data_dashboard).to have_login_data
    end

    scenario 'Coach views Lessons' do
      dashboard_table_of_contents.select_lessons

      expect(data_dashboard).to have_lessons_data
    end

    scenario 'Coach views Audio Access' do
      dashboard_table_of_contents.select_audio_access

      expect(patient_dashboard_group_1).to have_audio_access_data
    end

    scenario 'Coach views Activities viz' do
      patient_dashboard_group_1.select_activity_viz_from_body

      expect(patient_dashboard_group_1).to have_current_day_visible
    end

    scenario 'Coach collapses Daily Summaries in Activities viz' do
      patient_dashboard_group_1.select_activity_viz_from_body
      patient_dashboard_group_1.go_to_previous_day

      expect(patient_dashboard_group_1).to have_daily_summary_visible

      patient_dashboard_group_1.toggle_daily_summary

      expect(patient_dashboard_group_1).to_not have_daily_summary_visible
    end

    scenario 'Coach navigates to previous day in Activities viz' do
      patient_dashboard_group_1.select_activity_viz_from_body
      patient_dashboard_group_1.go_to_previous_day

      expect(patient_dashboard_group_1).to have_previous_day_visible
    end

    scenario 'Coach views ratings of an activity in Activity Viz' do
      patient_dashboard_group_1.select_activity_viz_from_body
      patient_dashboard_group_1.go_to_previous_day

      expect(patient_dashboard_group_1).to have_previous_day_visible

      patient_dashboard_group_1.view_activity_in_viz

      expect(patient_dashboard_group_1).to have_activity_ratings_in_viz
    end

    scenario 'Coach uses the visualization in Activities viz' do
      patient_dashboard_group_1.select_activity_viz_from_body

      expect(patient_dashboard_group_1).to have_current_day_visible

      patient_dashboard_group_1.open_visualize
      patient_dashboard_group_1.go_to_three_day_view

      expect(patient_dashboard_group_1).to be_on_three_day_view

      patient_dashboard_group_1.open_date_picker

      expect(patient_dashboard_group_1).to have_date_picker
    end

    scenario 'Coach views Activities - Future' do
      dashboard_table_of_contents.select_activities_future

      expect(patient_dashboard_group_1).to have_activities_future_data
    end

    scenario 'Coach views Activities - Past' do
      dashboard_table_of_contents.select_activities_past

      expect(patient_dashboard_group_1).to have_completed_activities_past_data
    end

    scenario 'Coach views noncompliance reason in Activities - Past' do
      dashboard_table_of_contents.select_activities_past

      expect(patient_dashboard_group_1).to have_incomplete_activities_past_data
    end

    scenario 'Coach views Thoughts viz' do
      dashboard_table_of_contents.select_thoughts
      patient_dashboard_group_1.select_thoughts_viz_from_body

      expect(patient_dashboard_group_1).to have_thoughts_viz_container

      expect(patient_dashboard_group_1).to have_thought_viz_detail
    end

    scenario 'Coach views Thoughts' do
      dashboard_table_of_contents.select_thoughts

      expect(patient_dashboard_group_1).to have_thoughts_data
    end

    scenario 'Coach views Messages' do
      dashboard_table_of_contents.select_messages

      expect(patient_dashboard_group_1).to have_messages_data
    end

    scenario 'Coach views Tasks' do
      dashboard_table_of_contents.select_tasks

      expect(patient_dashboard_group_1).to have_tasks_data
    end
  end

  feature 'Group 2' do
    scenario 'Coach sees data for a patient who has been withdrawn' do
      clinician.sign_in
      visit user_navigation.arms_page
      arm_1.open
      group_2.open
      patient_table_group_2.open
      patient_table_group_2.navigate_to_inactive_patients
      inactive_patient_table.select_patient

      expect(inactive_dashboard).to have_inactive_label

      dashboard_table_of_contents.select_all_links
      dashboard_table_of_contents.select_activity_viz

      expect(patient_dashboard_group_2).to have_activity_viz_visible

      patient_dashboard_group_2.return_to_dashboard

      expect(patient_dashboard_group_2).to be_visible

      dashboard_table_of_contents.select_thoughts_viz

      expect(patient_dashboard_group_2).to have_thoughts_viz_container

      patient_dashboard_group_2.return_to_dashboard

      expect(patient_dashboard_group_2).to be_visible
    end
  end
end
