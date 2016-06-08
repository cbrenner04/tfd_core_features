# frozen_string_literal: true
# filename: ./spec/support/participants/feel_helper.rb

require './lib/pages/participants/feel'
Dir['./lib/pages/participants/feel_modules/*.rb'].each { |file| require file }

def feel
  @feel ||= Participants::Feel.new
end

def tracking_mood
  @tracking_mood ||= Participants::FeelModules::TrackingMood.new(
    rating: 6
  )
end

def tracking_mood_and_emotions
  @tracking_mood_and_emotions ||=
    Participants::FeelModules::TrackingMoodEmotions.new(
      mood_rating: 6
    )
end

def first_emotion
  @first_emotion ||= Participants::FeelModules::TrackingMoodEmotions.new(
    emotion: 'anxious',
    emotion_type: 'negative',
    emotion_rating: 4
  )
end

def second_emotion
  @second_emotion ||= Participants::FeelModules::TrackingMoodEmotions.new(
    emotion: 'crazy',
    emotion_type: 'negative',
    emotion_rating: 8
  )
end

def recent_mood_and_emotions
  @recent_moods_and_emotions ||=
    Participants::FeelModules::RecentMoodsEmotions.new(
      mood_count: 1,
      emotion_count: 1,
      mood_type: 'positive',
      emotion_type: 'negative'
    )
end
