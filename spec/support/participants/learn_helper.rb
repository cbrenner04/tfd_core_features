# filename: ./spec/support/participants/learn_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/learn'

def participant_1
  @participant_1 ||= Participants.new(
    participant: ENV['Participant_Email'],
    old_participant: 'participant5',
    password: ENV['Participant_Password']
  )
end

def participant_5
  @participant_5 ||= Participants.new(
    participant: ENV['Participant_5_Email'],
    old_participant: 'participant1',
    password: ENV['Participant_5_Password']
  )
end

def learn
  @learn ||= Participants::Learn.new(
    lesson_title: 'Do - Awareness Introduction',
    first_slide_body: 'Do - Awareness Introduction'
  )
end
