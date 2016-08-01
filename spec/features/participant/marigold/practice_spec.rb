# frozen_string_literal: true
# filename: ./spec/features/participant/marigold/practice_spec.rb

require './spec/support/participants/practice_helper'

feature 'PRACTICE tool', :marigold, sauce: sauce_labs do
  background(:all) { marigold_participant.sign_in } if ENV['safari']

  background do
    marigold_participant.sign_in unless ENV['safari']
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
    participant_navigation.next

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
    sleep(1)
    participant_navigation.scroll_to_bottom
    participant_navigation.next

    # fails in firefox as alert does not show
    expect(positive_events_1).to have_description_alert
  end

  scenario 'Participant creates New Positive events' do
    positive_events_1.open
    positive_events_1.complete
    participant_navigation.scroll_to_bottom
    participant_navigation.next

    expect(positive_events_1).to be_saved

    positive_events_1.open_review

    expect(positive_events_1).to have_events
  end

  scenario 'Participant views past Positive events' do
    positive_events_2.open_review

    expect(positive_events_2).to have_events
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
    participant_navigation.next

    expect(activation_1).to have_activity_alert
  end

  scenario 'Participant must select pleasure to submit Activation' do
    activation_1.open
    activation_1.enter_activity_type
    activation_1.choose_accomplishment
    activation_1.complete_reminder_and_encouragement_fields
    participant_navigation.next

    expect(activation_1).to be_on_new_activity_form
  end

  scenario 'Participant must select accomplishment to submit Activation' do
    activation_1.open
    activation_1.enter_activity_type
    activation_1.choose_pleasure
    activation_1.complete_reminder_and_encouragement_fields
    participant_navigation.next

    expect(activation_1).to be_on_new_activity_form
  end

  scenario 'Participant completes Activation' do
    activation_1.open
    activation_1.complete_new_activity
    participant_navigation.next
    activation_2.complete_completed_activity
    social_networking.accept_social
    activation_3.complete_incomplete_activity
    social_networking.accept_social

    expect(practice).to be_visible
    expect(activation_1).to be_saved

    activation_1.open_review

    expect(activation_1).to have_planned_activity
    sleep(0.5)
    expect(activation_2).to have_completed_activity
    expect(activation_3).to have_incomplete_activity
  end

  scenario 'Participant views past Activation activities' do
    activation_4.open_review

    expect(activation_4).to have_completed_activity
  end

  scenario 'Participant views Meditation exercises' do
    meditation_1.open

    expect(meditation_1).to have_exercises
  end

  scenario 'Participant must enter comments to submit Meditation activity' do
    meditation_1.open

    expect(meditation_1).to have_exercises

    participant_navigation.next

    expect(meditation_1).to have_comments_alert
  end

  scenario 'Participant completes new Meditation activity' do
    meditation_1.open
    participant_navigation.reload
    meditation_1.complete
    participant_navigation.scroll_to_bottom
    participant_navigation.next

    expect(meditation_1).to have_activity
  end

  scenario 'Participant views past Mediation activities' do
    meditation_2.open_review

    expect(meditation_2).to have_activity
  end

  scenario 'Participant reviews past Mindfulness activity' do
    mindfulness_1.open_review
    mindfulness_1.review_incomplete_activity
    participant_navigation.next
    mindfulness_2.review_completed_activity
    participant_navigation.next

    sleep(2)
    expect(practice).to be_visible

    mindfulness_2.open_view # has thrown a stale element error in full suite

    expect(mindfulness_1).to have_incomplete_activity
    expect(mindfulness_2).to have_completed_activity
  end

  scenario 'Participant sees examples for Mindfulness activities' do
    mindfulness_3.open
    mindfulness_3.view_simple_examples

    expect(mindfulness_3).to have_simple_examples

    mindfulness_3.view_elaborate_examples

    expect(mindfulness_3).to have_elaborate_examples
  end

  scenario 'Participant must enter activity to submit Mindfulness activity' do
    mindfulness_3.open
    participant_navigation.next

    expect(mindfulness_3).to have_activity_alert
  end

  scenario 'Participant enters new Mindfulness activity' do
    mindfulness_3.open
    mindfulness_3.complete
    participant_navigation.next

    expect(mindfulness_3).to have_planned_activity
  end

  scenario 'Participant views past Mindfulness activities' do
    mindfulness_4.open_view

    expect(mindfulness_4).to have_completed_activity
  end

  scenario 'Participant must enter journal entry to submit Kindness Journal' do
    kindness_1.open
    participant_navigation.next

    expect(kindness_1).to have_entry_alert
  end

  scenario 'Participant completes Kindness Journal' do
    kindness_1.open
    kindness_1.complete
    participant_navigation.next

    expect(kindness_1).to have_journal_entry
  end

  scenario 'Participant views past Kindness Journal entries' do
    kindness_2.open_review

    expect(kindness_2).to have_journal_entry
  end

  scenario 'Participant must enter description to submit Strengths journal' do
    strengths_1.open
    strengths_1.enter_challenges
    participant_navigation.next

    expect(strengths_1).to have_description_alert
  end

  scenario 'Participant must enter challenges to submit Strengths journal' do
    strengths_1.open
    strengths_1.enter_description
    participant_navigation.next

    expect(strengths_1).to have_challenges_alert
  end

  scenario 'Participant completes Strengths journal' do
    strengths_1.open
    strengths_1.enter_description
    strengths_1.enter_challenges
    participant_navigation.next

    expect(strengths_1).to have_journal_entry
  end

  scenario 'Participant views previous Strengths journal entries' do
    strengths_2.open_review

    expect(strengths_2).to have_journal_entry
  end

  scenario 'Participant views Reappraisal examples' do
    reappraisal_1.open
    reappraisal_1.view_perspective_examples
    reappraisal_1.view_it_could_be_worse_examples
    participant_navigation.scroll_to_bottom
    reappraisal_1.view_got_through_it_examples

    expect(reappraisal_1).to have_perspective_examples
    expect(reappraisal_1).to have_it_could_be_worse_examples
    expect(reappraisal_1).to have_got_through_it_examples
  end

  scenario 'Participant must enter description to submit Reappraisal' do
    reappraisal_1.open
    reappraisal_1.enter_stressor
    reappraisal_1.enter_reappraisals
    reappraisal_1.enter_reflection
    participant_navigation.next

    expect(reappraisal_1).to have_description_alert
  end

  scenario 'Participant must enter stressor to submit Reappraisal' do
    reappraisal_1.open
    reappraisal_1.enter_description
    reappraisal_1.enter_reappraisals
    reappraisal_1.enter_reflection
    participant_navigation.next

    expect(reappraisal_1).to have_stressor_alert
  end

  scenario 'Participant must enter reappraisal to submit Reappraisal' do
    reappraisal_1.open
    reappraisal_1.enter_description
    reappraisal_1.enter_stressor
    reappraisal_1.enter_reflection
    participant_navigation.next

    expect(reappraisal_1).to have_reappraisal_alert
  end

  scenario 'Participant must enter reflection to submit Reappraisal' do
    reappraisal_1.open
    reappraisal_1.enter_description
    reappraisal_1.enter_stressor
    reappraisal_1.enter_reappraisals
    participant_navigation.next

    expect(reappraisal_1).to have_reflection_alert
  end

  scenario 'Participant completes Reappraisal' do
    reappraisal_1.open
    reappraisal_1.complete
    participant_navigation.next

    expect(reappraisal_1).to have_reappraisal
  end

  scenario 'Participant views past Reappraisals' do
    reappraisal_2.open_review

    expect(reappraisal_2).to have_reappraisal
  end
end

feature 'Practice incentives', :marigold, sauce: sauce_labs do
  scenario 'completes 4-day incentive' do
    marigold_2.sign_in
    visit practice.landing_page
    meditation_1.open
    participant_navigation.reload
    meditation_1.complete
    participant_navigation.scroll_to_bottom
    participant_navigation.next

    expect(meditation_1).to have_activity

    profile_practice.visit_profile

    expect(incentives_practice).to have_image_in_plot

    incentives_practice.open_incentives_list

    expect(incentives_practice).to be_complete
  end
end
