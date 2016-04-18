# filename: ./spec/support/participants/practice_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/navigation'
require './lib/pages/participants/practice'
Dir['./lib/pages/participants/practice/*.rb'].each { |file| require file }
require './lib/pages/participants/social_networking'

def marigold_participant_so3
  @marigold_participant_so3 ||= Participants.new(
    participant: ENV['Marigold_Participant_Email'],
    old_participant: 'participant3',
    password: ENV['Marigold_Participant_Password'],
    display_name: 'marigold_1'
  )
end

def navigation
  @navigation ||= Participants::Navigation.new
end

def practice
  @practice ||= Participants::Practice.new
end

def social_networking
  @social_networking ||= Participants::SocialNetworking.new
end

def gratitude_1
  @gratitude_1 ||= Participants::Practice::Gratitude.new(
    response: 'I am grateful for nothing',
    response_date: DateTime.now
  )
end

def gratitude_2
  @gratitude_2 ||= Participants::Practice::Gratitude.new(
    response: 'My first gratitude recording',
    response_date: DateTime.now - 1
  )
end

def positive_events_1
  @positive_events_1 ||= Participants::Practice::PositiveEvents.new(
    description: 'new positive event',
    emotions: 'new emotions',
    thoughts: 'new thoughts',
    body_feelings: 'new body feelings',
    challenging_amplification: 'new challenging amplification'
  )
end

def positive_events_2
  @positive_events_2 ||= Participants::Practice::PositiveEvents.new(
    description: 'Past description',
    emotions: 'Past emotion',
    thoughts: 'Past thought',
    body_feelings: 'Past body feeling',
    challenging_amplification: 'Past challenging amplification'
  )
end

def activation_1
  @activation_1 ||= Participants::Practice::Activation.new(
    activity_type: 'new activity',
    planned_for: Time.now + (1 * 60 * 60),
    pleasure: 4,
    accomplishment: 7,
    reminder: 'new reminder for activity',
    reviewed: 'No',
    encouragement: 'just do it',
    actual_pleasure: 'Not Rated',
    actual_accomplishment: 'Not Rated'
  )
end

def activation_2
  @activation_2 ||= Participants::Practice::Activation.new(
    activity_type: 'Jogging',
    planned_for: Time.now - (3 * 60 * 60),
    pleasure: 3,
    accomplishment: 5,
    reminder: 'Remind remind remind',
    reviewed: 'Yes',
    encouragement: 'Not a clue',
    actual_pleasure: 3,
    actual_accomplishment: 5,
    mood_rating: 5,
    notes: 'completion notes'
  )
end

def activation_3
  @activation_3 ||= Participants::Practice::Activation.new(
    activity_type: 'Parkour',
    planned_for: Time.now - (2 * 60 * 60),
    pleasure: 3,
    accomplishment: 5,
    reminder: 'I will yell at myself',
    reviewed: 'Yes',
    encouragement: 'Incentives, duh',
    actual_pleasure: 'Not Rated',
    actual_accomplishment: 'Not Rated',
    mood_rating: 0,
    noncompliance_reason: 'i didn\'t feel like it'
  )
end

def activation_4
  @activation_4 ||= Participants::Practice::Activation.new(
    activity_type: 'Speech',
    planned_for: Time.now - (3 * 60 * 60),
    pleasure: 3,
    accomplishment: 5,
    actual_pleasure: 6,
    actual_accomplishment: 7,
    reminder: 'So many reminders',
    reviewed: 'Yes',
    encouragement: 'So much encouragement',
    mood_rating: 7,
    notes: 'The best notes'
  )
end

def meditation_1
  @meditation_1 ||= Participants::Practice::Meditation.new(
    comment: 'new meditation comment',
    activity_time: Time.now
  )
end

def meditation_2
  @meditation_2 ||= Participants::Practice::Meditation.new(
    type: 'Guided-Breathing Meditation',
    comment: 'What an experience',
    activity_time: Time.now - (2 * 60 * 60)
  )
end
