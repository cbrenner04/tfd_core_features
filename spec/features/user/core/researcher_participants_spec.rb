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
    user_navigation.scroll_to_bottom
    click_on 'test_5'
    begin
      tries ||= 3
      click_on 'Assign Coach/Moderator'
    rescue Selenium::WebDriver::Error::UnknownError
      page.execute_script('window.scrollBy(0,1000)')
      retry unless (tries -= 1).zero?
    end

    if ENV['tfd']
      select 'clinician1@example.com', from: 'coach_assignment_coach_id'
      click_on 'Assign'
    end

    find('.alert-success', text: 'Coach/Moderator was successfully assigned')
    expect(page).to have_content 'Current Coach/Moderator: ' \
                                 "#{ENV['Clinician_Email']}"
  end

  scenario 'Researcher destroys a participant' do
    user_navigation.scroll_to_bottom
    click_on 'test_6'
    user_navigation.confirm_with_js
    click_on 'Destroy'
    find('.alert-success', text: 'Participant was successfully destroyed.')
    expect(page).to_not have_content 'test_6'
  end

  scenario 'Researcher uses breadcrumbs to return home through Participants' do
    user_navigation.scroll_to_bottom
    click_on 'TFD-1111'
    find('p', text: 'Contact Preference')
    within('.breadcrumb') { click_on 'Participants' }
    find('.list-group-item', text: 'participant61')
    within('.breadcrumb') { click_on 'Home' }

    expect(page).to have_content 'Arms'
  end

  scenario 'Researcher uses breadcrumbs to return to home through Groups' do
    user_navigation.scroll_to_bottom
    click_on 'TFD-1111'
    find('p', text: 'Contact Preference')
    click_on 'Group'
    within('.breadcrumb') { click_on 'Groups' }
    find('.list-group-item', text: 'Group 3')
    within('.breadcrumb') { click_on 'Home' }

    expect(page).to have_content 'Arms'
  end
end
