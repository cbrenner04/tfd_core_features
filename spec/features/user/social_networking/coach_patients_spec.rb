# frozen_string_literal: true
feature 'Coach, Patient Dashboard', :social_networking, :marigold,
        sauce: sauce_labs do
  feature 'Group 1' do
    background(:all) { clinician.sign_in } if ENV['safari']

    background do
      clinician.sign_in unless ENV['safari']
      visit user_navigation.arms_page
      arm_1.open
      group_1.open
      patient_table_group_1.open
    end

    scenario 'Coach views Tool Use table' do
      patient_data_patient_table.select_patient

      expect(patient_data_dashboard).to have_tool_use_data
    end

    scenario 'Coach uses the links within Tool Use table' do
      patient_data_patient_table.select_patient
      patient_data_dashboard.click_all_links_in_tool_use_table
    end

    scenario 'Coach uses the links within Social Activity table' do
      patient_data_patient_table.select_patient
      patient_data_dashboard.click_all_links_in_social_activity_table
    end
  end

  feature 'Group 6' do
    background(:all) { clinician.sign_in } if ENV['safari']

    background do
      clinician.sign_in unless ENV['safari']
      visit user_navigation.arms_page
      arm_1.open
      group_6.open
      patient_table_group_6.open
    end

    scenario 'Coach sees consistent # of Logins' do
      expect(patient_61_patient_table).to have_login_info
    end

    scenario 'Coach views Social Activity' do
      patient_61_patient_table.select_patient

      expect(patient_61_dashboard).to have_social_activity_data
    end

    scenario 'Coach views Likes' do
      patient_61_patient_table.select_patient

      expect(patient_61_dashboard).to have_likes_data
    end

    scenario 'Coach views Goals' do
      patient_61_patient_table.select_patient

      expect(patient_61_dashboard).to have_goals_data
    end

    scenario 'Coach views Comments' do
      patient_61_patient_table.select_patient

      expect(patient_61_dashboard).to have_comments_data
    end

    scenario 'Coach views Nudges Initiated' do
      patient_61_patient_table.select_patient

      expect(patient_61_dashboard).to have_nudges_initiated_data
    end

    scenario 'Coach views Nudges Received' do
      patient_61_patient_table.select_patient

      expect(patient_61_dashboard).to have_nudges_received_data
    end

    scenario 'Coach views On-My-Mind Statements' do
      patient_61_patient_table.select_patient

      expect(patient_61_dashboard).to have_on_the_mind_data
    end
  end

  feature 'Terminate Access' do
    scenario 'Coach Terminates Access, checks profile is removed' do
      clinician.sign_in
      visit user_navigation.arms_page
      arm_1.open
      group_6.open
      patient_table_group_6.open
      patient_65_patient_table.terminate_access

      expect(patient_65_patient_table).to_not have_participant_visible

      patient_65_patient_table.navigate_to_inactive_patients

      expect(patient_65_patient_table).to have_participant_visible

      unless ENV['safari']
        participant_61.sign_in

        expect(social_networking)
          .to_not have_participant65_visible_on_landing_page
      end
    end
  end
end
