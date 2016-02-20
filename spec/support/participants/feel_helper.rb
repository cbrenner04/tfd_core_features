# filename: ./spec/support/participants/feel_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/feel'
Dir['./lib/pages/participants/feel/*.rb'].each { |file| require file }

def participant_1
  @participant_1 ||= Participants.new(
    participant: ENV['Participant_Email'],
    old_participant: 'participant3',
    password: ENV['Participant_Password']
  )
end

def participant_3
  @participant_3 ||= Participants.new(
    participant: ENV['Alt_Participant_Email'],
    old_participant: 'participant1',
    password: ENV['Alt_Participant_Password']
  )
end

def participant_5
  @participant_5 ||= Participants.new(
    participant: ENV['Participant_5_Email'],
    old_participant: 'participant3',
    password: ENV['Participant_5_Password']
  )
end

def feel
  @feel ||= Participants::Feel.new
end

def tracking_mood
  @tracking_mood ||= Participants::Feel::TrackingMood.new(
    rating: 6
  )
end

def tracking_mood_and_emotions
  @tracking_mood_and_emotions ||= Participants::Feel::TrackingMoodEmotions.new(
    mood_rating: 6,
    first_emotion: 'anxious',
    first_emotion_type: 'negative',
    first_emotion_rating: 4,
    second_emotion: 'crazy',
    second_emotion_type: 'negative',
    second_emotion_rating: 8
  )
end

def recent_moods_and_emotions
  @recent_moods_and_emotions ||= Participants::Feel::RecentMoodsEmotions.new(
    mood_count: 1,
    emotion_count: 1,
    mood_type: 'positive',
    emotion_type: 'negative'
  )
end
