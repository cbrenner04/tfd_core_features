# frozen_string_literal: true
# filename: ./spec/features/user/social_networking/user_bugs_spec.rb

require './lib/pages/users/participants_set_up'
require './lib/pages/users/patient_dashboard'

def new_participant_a
  @new_participant_a ||= Users::ParticipantsSetUp.new(
    study_id: 'Fake',
    email: 'fake@test.com',
    contact_preference: 'Email',
    group_number: 6,
    display_name: '',
    start_date: today - 1,
    end_date: today + 365
  )
end

def participant_data_dashboard
  @participant_data_dashboard ||= Users::PatientDashboard.new(
    participant: 'TFD-data',
    group: 'Group 1'
  )
end

feature 'User Dashboard Bugs', :social_networking, :marigold,
        sauce: sauce_labs do
  feature 'Researcher' do
    scenario 'Researcher creates a participant, assigns social membership wo' \
             ' a display name, receives alert that display name is needed' do
      researcher.sign_in
      visit new_participant_a.landing_page
      new_participant_a.create

      expect(new_participant_a).to be_created_successfully

      new_participant_a.assign_group

      expect(new_participant_a).to have_display_name_needed_alert
    end
  end

  feature 'Clinician' do
    scenario 'Clinician navigates to Patient Dashboard, views Tool Use table' \
             ', sees correct data for activities' do
      clinician.sign_in
      visit user_navigation.arms_page
      arm_1.open
      group_1.open
      participant_data_dashboard.open
      participant_data_dashboard.select_patient

      expect(participant_data_dashboard).to have_tool_use_data
    end
  end
end
