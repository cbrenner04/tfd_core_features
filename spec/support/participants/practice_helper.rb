# filename: ./spec/support/participants/practice_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/navigation'
require './lib/pages/participants/practice'
Dir['./lib/pages/participants/practice/*.rb'].each { |file| require file }

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
