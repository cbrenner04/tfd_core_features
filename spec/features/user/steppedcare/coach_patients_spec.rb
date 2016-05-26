# filename ./spec/features/user/steppedcare/coach_patients_spec.rb

require './spec/support/users/steppedcare_coach_patients_helper'

def date_1
  @date_1 ||= Date.today - 4
end

feature 'Coach', :tfd, sauce: sauce_labs do
  feature 'Patient Dashboard' do
    background do
      clinician.sign_in unless ENV['safari']
      visit user_navigation.arms_page
    end

    scenario 'Coach sees consistent # of Logins' do
      participant_61_dashboard.navigate_to_patient_dashboard

      expect(participant_61_dashboard).to have_login_info_in_patients_list
    end

    scenario 'Coach uses the table of contents in the patient report' do
      participant_1_dashboard.navigate_to_patient_dashboard
      participant_1_dashboard.select_patient
      user_navigation.scroll_to_bottom
      participant_1_dashboard.select_phq_from_toc
    end

    scenario 'Coach views Login Info' do
      participant_61_dashboard.navigate_to_patient_dashboard
      participant_61_dashboard.select_patient

      expect(participant_61_dashboard).to have_partial_login_info
    end
  end
end

feature 'Coach', :tfd, sauce: sauce_labs do
  feature 'Patient Dashboard, PHQ Group' do
    background do
      clinician.sign_in unless ENV['safari']
      visit user_navigation.arms_page
      phq_group_dashboard.navigate_to_patient_dashboard
    end

    scenario 'Coach checks details for stepping' do
      phq1_dashboard.open_stepping_details

      expect(phq1_dashboard).to have_stepping_details
    end

    scenario 'Coach does not see a suggestion for a participant in week 3' do
      expect(phq6_dashboard).to have_too_early_suggestion
    end

    scenario 'Coach sees a suggestion to step for a participant in week 4' do
      expect(phq7_dashboard).to have_step_suggestion
    end

    scenario 'Coach sees a suggestion to stay for a participant in week 4' do
      expect(phq8_dashboard).to have_stay_suggestion
    end

    scenario 'Coach sees discontinue suggestion for participant in week 4' do
      expect(phq9_dashboard).to have_discontinue_suggestion
    end

    scenario 'Coach sees a suggestion to step for a participant in week 8' do
      expect(phq10_dashboard).to have_step_suggestion
    end

    scenario 'Coach sees a suggestion to stay for a participant in week 8' do
      expect(phq11_dashboard).to have_stay_suggestion
    end

    scenario 'Coach sees discontinue suggestion for participant in week 9' do
      expect(phq12_dashboard).to have_discontinue_suggestion
    end

    scenario 'Coach sees a suggestion to step for a participant in week 9' do
      expect(phq13_dashboard).to have_step_suggestion
    end

    scenario 'Coach sees a suggestion to stay for a participant in week 9' do
      expect(phq14_dashboard).to have_stay_suggestion
    end

    scenario 'Coach sees a suggestion to step for a participant in week 10' do
      expect(phq15_dashboard).to have_step_suggestion
    end

    scenario 'Coach sees a suggestion to stay for a participant in week 10' do
      expect(phq16_dashboard).to have_stay_suggestion
    end

    scenario 'Coach steps a participant' do
      phq2_dashboard.step

      expect(phq2_dashboard).to be_stepped_successfully
    end

    scenario 'Coach views PHQ9' do
      phq3_dashboard.select_patient

      expect(phq3_dashboard).to have_phq9_data
    end

    scenario 'Coach creates a new PHQ9 assessment' do
      phq4_dashboard.select_patient
      phq4_dashboard.manage_phqs

      expect(phq4_dashboard).to have_phq_management_tool_visible

      phq4_dashboard.create_phq

      expect(phq4_dashboard).to have_new_phq
    end

    scenario 'Coach manages an existing PHQ9, Most Recent stays the same' do
      expect(phq1_dashboard).to have_most_recent_phq_score

      phq1_dashboard.select_patient
      phq1_dashboard.manage_phqs

      expect(phq1_dashboard).to have_phq_management_tool_visible

      phq1_dashboard.edit_old_phq

      expect(phq1_dashboard).to have_updated_phq

      # check to make sure update of old phq doesn't change whats in listing
      phq1_dashboard.navigate_back_to_patients_list

      expect(phq1_dashboard).to have_most_recent_phq_score
    end

    scenario 'Coach deletes an existing PHQ9 assessment' do
      phq5_dashboard.select_patient
      phq5_dashboard.manage_phqs

      expect(phq5_dashboard).to have_phq_management_tool_visible

      phq5_dashboard.delete_old_phq

      expect(phq5_dashboard).to have_phq_deleted
    end
  end
end
