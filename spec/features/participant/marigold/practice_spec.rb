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
end
