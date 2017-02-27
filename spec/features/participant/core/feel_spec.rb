# frozen_string_literal: true
feature 'FEEL tool, Tracking Mood', :core, sauce: sauce_labs do
  scenario 'Participant completes Tracking Your Mood' do
    participant_1.sign_in
    visit feel.landing_page
    tracking_mood.open
    tracking_mood.rate_mood(6)
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
    tracking_mood_and_emotions.rate_mood(6)
    tracking_mood_and_emotions.rate_emotion(
      emotion: 'anxious',
      type: 'negative',
      rating: 4
    )
    tracking_mood_and_emotions.add_and_rate_emotion(
      emotion: 'crazy',
      type: 'negative',
      rating: 8
    )
    tracking_mood_and_emotions.submit
    tracking_mood_and_emotions.finish
  end

  scenario 'Participant cannot create an emotion more than 255 characters' do
    tracking_mood_and_emotions.open
    tracking_mood_and_emotions.rate_mood(6)
    tracking_mood_and_emotions.create_emotion_with_more_than_255_characters

    expect(tracking_mood_and_emotions).to have_emotion_with_255_characters
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

    expect(recent_mood_and_emotions)
      .to have_moods_in_graph(mood_count: 1, mood_type: 'positive')

    recent_mood_and_emotions.open_mood_modal

    expect(recent_mood_and_emotions).to have_moods_in_modal
  end

  scenario 'Participant views ratings in Emotions graph' do
    recent_mood_and_emotions.open

    expect(recent_mood_and_emotions)
      .to have_emotions_in_graph(emotions_count: 1, emotion_type: 'negative')

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
