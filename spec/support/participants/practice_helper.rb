# filename: ./spec/support/participants/practice_helper.rb

require './lib/pages/participants/practice'
Dir['./lib/pages/participants/practice/*.rb'].each { |file| require file }
require './lib/pages/participants/social_networking'

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

def mindfulness_1
  @mindfulness_1 ||= Participants::Practice::Mindfulness.new(
    activity: 'Speech',
    planned_for: Time.now - ((1 * 60 * 60 * 24) + (2 * 60 * 60)),
    reviewed: 'Yes',
    encouragement: 'Speech encouragement',
    reminder: 'Speech reminder',
    challenges: 'Speech challenges',
    noncompliance_reason: 'Speech noncompliance reason'
  )
end

def mindfulness_2
  @mindfulness_2 ||= Participants::Practice::Mindfulness.new(
    activity: 'Jogging',
    planned_for: Time.now - ((1 * 60 * 60 * 24) + (1 * 60 * 60)),
    reviewed: 'Yes',
    encouragement: 'Mindfulness encouragement',
    reminder: 'Mindfulness reminder',
    challenges: 'Mindfulness challenges',
    emotions: 'Mindfulness emotions',
    notes: 'Mindfulness notes'
  )
end

def mindfulness_3
  @mindfulness_3 ||= Participants::Practice::Mindfulness.new(
    activity: 'New mindfulness activity',
    planned_for: Time.now,
    reviewed: 'No',
    encouragement: 'New mindfulness encouragement',
    reminder: 'New mindfulness reminder',
    challenges: 'New mindfulness challenges'
  )
end

def mindfulness_4
  @mindfulness_4 ||= Participants::Practice::Mindfulness.new(
    activity: 'Parkour',
    planned_for: Time.now - ((1 * 60 * 60 * 24) + (3 * 60 * 60)),
    reviewed: 'Yes',
    encouragement: 'Parkour encouragement',
    reminder: 'Parkour reminder',
    challenges: 'Parkour challenges',
    emotions: 'Parkour emotions',
    notes: 'Parkour notes'
  )
end

def kindness_1
  @kindness_1 ||= Participants::Practice::Kindness.new(
    kindness: 'New kindness entry',
    created_at: Time.now
  )
end

def kindness_2
  @kindness_2 ||= Participants::Practice::Kindness.new(
    kindness: 'Old kindness',
    created_at: Time.now - (2 * 60 * 60)
  )
end

def strengths_1
  @strengths_1 ||= Participants::Practice::Strengths.new(
    description: 'New strengths entry',
    challenges: 'New strengths challenges',
    created_at: Time.now
  )
end

def strengths_2
  @strengths_2 ||= Participants::Practice::Strengths.new(
    description: 'Strengths description',
    challenges: 'Strengths challenges',
    created_at: Time.now - (2 * 60 * 60)
  )
end

def reappraisal_1
  @reappraisal_1 ||= Participants::Practice::Reappraisals.new(
    description: 'New description',
    stressor: 'New stressor',
    reappraisal: 'New reappraisal',
    reflection: 'New reflection',
    created_at: Time.now
  )
end

def reappraisal_2
  @reappraisal_2 ||= Participants::Practice::Reappraisals.new(
    description: 'Reappraisal description',
    stressor: 'Reappraisal stressor',
    reappraisal: 'Reappraisal reappraisal',
    reflection: 'Reappraisal reflection',
    created_at: Time.now - (2 * 60 * 60)
  )
end
