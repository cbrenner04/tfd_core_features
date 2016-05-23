# filename: ./spec/features/user/social_networking/coach_patients_spec.rb

require './lib/pages/participants'
require './lib/pages/participants/social_networking'
require './lib/pages/users/patient_dashboard'

def patient_dashboard_group_1
  @patient_dashboard_group_1 ||= Users::PatientDashboard.new(group: 'Group 1')
end

def patient_dashboard_group_6
  @patient_dashboard_group_6 ||= Users::PatientDashboard.new(group: 'Group 6')
end

def patient_data_dashboard
  @patient_data_dashboard ||= Users::PatientDashboard.new(
    participant: 'TFD-data'
  )
end

def patient_61_dashboard
  @patient_61_dashboard ||= Users::PatientDashboard.new(
    participant: 'participant61',
    total_logins: 11,
    date: Date.today - 4
  )
end

def patient_65_dashboard
  @patient_65_dashboard ||= Users::PatientDashboard.new(
    participant: 'participant65'
  )
end

def participant_61
  @participant_61 ||= Participant.new(
    participant: ENV['PT61_Email'],
    password: ENV['PT61_Password']
  )
end

def social_networking
  @social_networking ||= Participants::SocialNetworking.new
end

feature 'Coach, Patient Dashboard', :social_networking, sauce: sauce_labs do
  feature 'Group 1' do
    background do
      clinician.sign_in unless ENV['safari']
      visit user_navigation.arms_page
      patient_dashboard_group_1.navigate_to_patient_dashboard
    end

    scenario 'Coach views Tool Use table' do
      patient_data_dashboard.select_patient

      expect(patient_data_dashboard).to have_tool_use_data
    end

    scenario 'Coach uses the links within Tool Use table' do
      patient_data_dashboard.select_patient
      patient_data_dashboard.click_all_links_in_tool_use_table
    end

    scenario 'Coach uses the links within Social Activity table' do
      patient_data_dashboard.select_patient
      patient_data_dashboard.click_all_links_in_social_activity_table
    end
  end

  feature 'Group 6' do
    background do
      clinician.sign_in unless ENV['safari']
      visit user_navigation.arms_page
      patient_dashboard_group_6.navigate_to_patient_dashboard
    end

    scenario 'Coach sees consistent # of Logins' do
      expect(patient_61_dashboard).to have_login_info_in_patients_list
    end

    scenario 'Coach views Social Activity' do
      patient_61_dashboard.select_patient

      expect(patient_61_dashboard).to have_social_activity_data
    end

    scenario 'Coach views Likes' do
      patient_61_dashboard.select_patient

      expect(patient_61_dashboard).to have_likes_data
    end

    scenario 'Coach views Goals' do
      patient_61_dashboard.select_patient

      expect(patient_61_dashboard).to have_goals_data
    end

    scenario 'Coach views Comments' do
      patient_61_dashboard.select_patient

      expect(patient_61_dashboard).to have_comments_data
    end

    scenario 'Coach views Nudges Initiated' do
      patient_61_dashboard.select_patient

      expect(patient_61_dashboard).to have_nudges_initiated_data
    end

    scenario 'Coach views Nudges Received' do
      patient_61_dashboard.select_patient

      expect(patient_61_dashboard).to have_nudges_received_data
    end

    scenario 'Coach views On-My-Mind Statements' do
      patient_61_dashboard.select_patient

      expect(patient_61_dashboard).to have_on_the_mind_data
    end
  end

  feature 'Terminate Access' do
    scenario 'Coach Terminates Access, checks profile is removed' do
      clinician.sign_in unless ENV['safari']
      visit user_navigation.arms_page
      patient_dashboard_group_6.navigate_to_patient_dashboard
      patient_65_dashboard.terminate_access

      expect(patient_65_dashboard)
        .to_not have_participant_visible_in_patient_table

      patient_65_dashboard.navigate_to_inactive_patients

      expect(patient_65_dashboard).to have_participant_visible_in_patient_table

      unless ENV['safari']
        participant_61.sign_in

        expect(social_networking)
          .to_not have_participant65_visible_on_landing_page
      end
    end
  end
end
