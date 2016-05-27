# filename: researcher_participants_spec.rb

require './spec/support/users/researcher_participants_helper'

feature 'Researcher, Participants', :core, sauce: sauce_labs do
  background(:all) { researcher.sign_in } if ENV['safari']

  background do
    researcher.sign_in unless ENV['safari']
    visit researcher_participants.landing_page

    expect(researcher_participants).to be_visible
  end

  scenario 'Researcher creates a participant' do
    new_participant.create

    expect(new_participant).to be_created_successfully
  end

  scenario 'Researcher updates a participant' do
    update_participant.open
    update_participant.update

    expect(update_participant).to be_updated_successfully
  end

  scenario 'Researcher cannot assign a coach without a group membership' do
    test_2_participant.open

    expect(test_2_participant).to have_no_coach_assigned
    expect(test_2_participant).to be_unable_to_take_coach_assignment
  end

  unless ENV['chrome']
    scenario 'Researcher cannot assign a membership with invalid start date' do
      invalid_start_participant.open
      invalid_start_participant.assign_group

      expect(invalid_start_participant).to have_invalid_membership_alert
      expect(invalid_start_participant).to have_blank_start_date_alert
    end

    scenario 'Researcher cannot assign membership with a blank end date' do
      invalid_end_participant.open
      invalid_end_participant.assign_group

      expect(invalid_end_participant).to have_invalid_membership_alert
      expect(invalid_end_participant).to have_blank_end_date_alert
    end

    scenario 'Researcher cannot assign membership with invalid start date' do
      past_end_participant.open
      past_end_participant.assign_group

      expect(past_end_participant).to have_invalid_membership_alert
      expect(past_end_participant).to have_end_date_in_the_past
    end

    scenario 'Researcher assigns a group membership' do
      test_4_participant.open
      test_4_participant.assign_group

      expect(test_4_participant).to have_group_assigned_successfully
    end
  end

  scenario 'Researcher assigns a coach' do
    test_5_participant.open
    test_5_participant.assign_coach

    expect(test_5_participant).to have_coach_assigned_successfully
  end

  scenario 'Researcher destroys a participant' do
    test_6_participant.open
    user_navigation.destroy

    expect(test_6_participant).to be_destroyed_successfully
  end

  scenario 'Researcher uses breadcrumbs to return home through Participants' do
    user_navigation.scroll_to_bottom
    test_5_participant.open
    user_navigation.go_back_to_participants_page
    user_navigation.go_back_to_home_page

    expect(user_navigation).to have_home_visible
  end

  scenario 'Researcher uses breadcrumbs to return to home through Groups' do
    user_navigation.scroll_to_bottom
    test_5_participant.open
    if ENV['tfd']
      group_5.go_back_to_group_page
    else
      group_1.go_back_to_group_page
    end
    user_navigation.go_back_to_groups_page
    user_navigation.go_back_to_home_page

    expect(user_navigation).to have_home_visible
  end
end
