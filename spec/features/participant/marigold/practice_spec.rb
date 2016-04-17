# filename: ./spec/features/participant/marigold/practice_spec.rb

require './spec/support/participants/practice_helper'

feature 'PRACTICE tool', :marigold, sauce: sauce_labs do
  background do
    marigold_participant_so3.sign_in
    visit practice.landing_page
  end

  scenario 'Participant sees two columns with Practice modules' do
    expect(practice).to have_practice_for_this_week
    expect(practice).to have_past_practice
  end

  scenario 'Participant views examples of Gratitude recordings' do
    gratitude_1.open

    expect(gratitude_1).to have_question

    gratitude_1.show_examples

    expect(gratitude_1).to have_examples
  end

  scenario 'Participant adds entry to Gratitude module' do
    gratitude_1.open

    expect(gratitude_1).to have_question

    gratitude_1.enter_response
    navigation.next

    expect(gratitude_1).to be_saved

    gratitude_1.open_review

    expect(gratitude_1).to have_recording
  end

  scenario 'Participant views past Gratitude entries' do
    gratitude_2.open_review

    expect(gratitude_2).to have_recording
  end

  scenario 'Participant view examples of Positive events' do
    positive_events_1.open

    expect(positive_events_1).to have_questions

    positive_events_1.show_examples

    expect(positive_events_1).to have_examples

    positive_events_1.show_amplifying_examples

    expect(positive_events_1).to have_amplifying_examples
  end

  scenario 'Participant must submit New Positive events with description' do
    positive_events_1.open
    navigation.next

    expect(positive_events_1).to have_description_alert
  end

  scenario 'Participant creates New Positive events' do
    positive_events_1.open
    positive_events_1.complete
    navigation.next

    expect(positive_events_1).to be_saved

    positive_events_1.open_review

    expect(positive_events_1).to have_events
  end

  scenario 'Participant views past Positive events' do
    positive_events_2.open_review

    expect(positive_events_2).to have_events
  end

  scenario 'Participant creates new Positive event from index page' do
    positive_events_2.open_review
    navigation.create_new

    expect(positive_events_2).to have_questions
  end

  scenario 'Participant sees encouragement suggestions' do
    activation_1.open
    activation_1.show_suggestions

    expect(activation_1).to have_suggestions
  end

  scenario 'Participant must select activity to submit Activation' do
    activation_1.open
    activation_1.choose_pleasure
    activation_1.choose_accomplishment
    activation_1.complete_reminder_and_encouragement_fields
    navigation.next

    expect(activation_1).to have_activity_alert
  end

  scenario 'Participant must select pleasure to submit Activation' do
    activation_1.open
    activation_1.enter_activity_type
    activation_1.choose_accomplishment
    activation_1.complete_reminder_and_encouragement_fields
    navigation.next

    expect(activation_1).to be_on_new_activity_form
  end

  scenario 'Participant must select accomplishment to submit Activation' do
    activation_1.open
    activation_1.enter_activity_type
    activation_1.choose_pleasure
    activation_1.complete_reminder_and_encouragement_fields
    navigation.next

    expect(activation_1).to be_on_new_activity_form
  end

  scenario 'Participant completes Activation' do
    activation_1.open
    activation_1.complete_new_activity
    navigation.next
    activation_2.complete_completed_activity
    social_networking.accept_social
    activation_3.complete_incomplete_activity
    social_networking.accept_social

    expect(practice).to be_visible
    expect(activation_1).to be_saved

    activation_1.open_review

    expect(activation_1).to have_planned_activity
    expect(activation_2).to have_completed_activity
    expect(activation_3).to have_incomplete_activity
  end

  scenario 'Participant views past Activation activities' do
    activation_4.open_review

    expect(activation_4).to have_completed_activity
  end
end
