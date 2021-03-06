# frozen_string_literal: true
# filename: ./spec/features/participant/core/feel_spec.rb

require './spec/support/participants/feel_helper'

feature 'FEEL tool, Tracking Mood', :core, sauce: sauce_labs do
  scenario 'Participant completes Tracking Your Mood' do
    participant_1.sign_in
    visit feel.landing_page
    tracking_mood.open
    tracking_mood.rate_mood
    tracking_mood.finish
  end
end

feature 'FEEL tool, Tracking Mood & Emotions', :core, sauce: sauce_labs do
  background(:all) { participant_3.sign_in } if ENV['safari']

  background do
    participant_3.sign_in unless ENV['safari']
    visit feel.landing_page
  end

  scenario 'Participant completes Tracking Your Mood & Emotions' do
    tracking_mood_and_emotions.open
    tracking_mood_and_emotions.rate_mood
    first_emotion.rate_emotion
    second_emotion.add_and_rate_emotion
    tracking_mood_and_emotions.submit
    tracking_mood_and_emotions.finish
  end

  scenario 'Participant cannot create an emotion more than 255 characters' do
    tracking_mood_and_emotions.open
    tracking_mood_and_emotions.rate_mood
    emotion_255.create_emotion_with_more_than_255_characters

    expect(emotion_255).to have_emotion_with_255_characters
  end

  scenario 'Participant uses navbar functionality in all of FEEL' do
    visit feel.track_mood_emotions
    feel.navigate_to_all_modules_through_navbar
  end
end

feature 'FEEL Tool, Your Recent Mood & Emotions', :core, sauce: sauce_labs do
  background(:all) { participant_5.sign_in if ENV['safari'] }

  background do
    participant_5.sign_in unless ENV['safari']
    visit feel.landing_page
  end

  scenario 'Participant views ratings in Mood Graph' do
    recent_mood_and_emotions.open

    expect(recent_mood_and_emotions).to have_moods_in_graph

    recent_mood_and_emotions.open_mood_modal

    expect(recent_mood_and_emotions).to have_moods_in_modal
  end

  scenario 'Participant views ratings in Emotions graph' do
    recent_mood_and_emotions.open

    expect(recent_mood_and_emotions).to have_emotions_in_graph

    recent_mood_and_emotions.open_emotion_modal

    expect(recent_mood_and_emotions).to have_emotions_in_modal
  end

  scenario 'Participant navigates to 28 day view' do
    recent_mood_and_emotions.open

    expect(recent_mood_and_emotions).to have_week_view_visible

    recent_mood_and_emotions.switch_to_28_day_view

    expect(recent_mood_and_emotions).to have_28_day_view_visible
  end

  scenario 'Participant navigates to Previous Period' do
    recent_mood_and_emotions.open
    recent_mood_and_emotions.switch_to_previous_period

    expect(recent_mood_and_emotions).to have_previous_period_visible
  end
end
