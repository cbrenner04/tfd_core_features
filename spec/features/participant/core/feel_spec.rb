# filename: ./spec/features/participant/core/feel_spec.rb

require './spec/support/participants/feel_helper'

feature 'FEEL tool, Tracking Mood', :core, sauce: sauce_labs do
  scenario 'Participant completes Tracking Your Mood' do
    participant_1_so3.sign_in
    visit feel.landing_page
    tracking_mood.open
    tracking_mood.rate_mood
    tracking_mood.finish
  end
end

feature 'FEEL tool, Tracking Mood & Emotions', :core, sauce: sauce_labs do
  background(:all) { participant_3_so1.sign_in if ENV['safari'] }

  background do
    participant_3_so1.sign_in unless ENV['safari']
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

  scenario 'Participant uses navbar functionality in all of FEEL' do
    visit feel.track_mood_emotions
    feel.navigate_to_all_modules_through_navbar
  end
end

feature 'FEEL Tool, Your Recent Mood & Emotions', :core, sauce: sauce_labs do
  background(:all) { participant_5_so3.sign_in if ENV['safari'] }

  background do
    participant_5_so3.sign_in unless ENV['safari']
    visit feel.landing_page
  end

  scenario 'Participant views ratings in Mood Graph' do
    recent_mood_and_emotions.open

    expect(recent_mood_and_emotions).to have_moods
  end

  scenario 'Participant views ratings in Emotions graph' do
    recent_mood_and_emotions.open

    expect(recent_mood_and_emotions).to have_emotions
  end

  scenario 'Participant navigates to 28 day view' do
    recent_mood_and_emotions.open

    expect(recent_mood_and_emotions).to have_week_view_visible

    recent_mood_and_emotions.click

    expect(recent_mood_and_emotions).to have_28_day_view_visible
  end

  scenario 'Participant navigates to Previous Period' do
    recent_mood_and_emotions.open
    recent_mood_and_emotions.switch_to_previous_period

    expect(page).to have_previous_period_visible
  end
end
