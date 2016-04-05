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

def practice
  @practice ||= Participants::Practice.new
end

def gratitude_1
  @gratitude_1 ||= Participants::Practice::Gratitude.new(
    response: 'I am grateful for nothing'
  )
end

def navigation
  @navigation ||= Participants::Navigation.new
end

def gratitude_2
  @gratitude_2 ||= Participants::Practice::Gratitude.new(
    response: 'My first gratitude recording',
    response_date: DateTime.now - 1
  )
end
