# filename: ./spec/support/feature_helpers.rb

require './lib/pages/participants'

def participant_1_so1
  @participant_1_so1 ||= Participants.new(
    participant: ENV['Participant_Email'],
    old_participant: 'participant1',
    password: ENV['Participant_Password'],
    display_name: 'participant1'
  )
end

def participant_1_so2
  @participant_1_so2 ||= Participants.new(
    participant: ENV['Participant_Email'],
    old_participant: 'participant2',
    password: ENV['Participant_Password']
  )
end

def participant_1_so3
  @participant_1_so3 ||= Participants.new(
    participant: ENV['Participant_Email'],
    old_participant: 'participant3',
    password: ENV['Participant_Password']
  )
end

def participant_1_so5
  @participant_1_so5 ||= Participants.new(
    participant: ENV['Participant_Email'],
    old_participant: 'participant5',
    password: ENV['Participant_Password']
  )
end

def participant_1_soc
  @participant_1_soc ||= Participants.new(
    participant: ENV['Participant_Email'],
    old_participant: 'completer',
    password: ENV['Participant_Password']
  )
end

def participant_2_so1
  @participant_2_so1 ||= Participants.new(
    participant: ENV['Participant_2_Email'],
    old_participant: 'participant1',
    password: ENV['Participant_Password'],
    display_name: 'participant2'
  )
end

def participant_3_so1
  @participant_3_so1 ||= Participants.new(
    participant: ENV['Alt_Participant_Email'],
    old_participant: 'participant1',
    password: ENV['Alt_Participant_Password']
  )
end

def participant_5_so1
  @participant_5_so1 ||= Participants.new(
    participant: ENV['Participant_5_Email'],
    old_participant: 'participant1',
    password: ENV['Participant_5_Password'],
    display_name: 'participant5'
  )
end

def participant_5_so3
  @participant_5_so3 ||= Participants.new(
    participant: ENV['Participant_5_Email'],
    old_participant: 'participant3',
    password: ENV['Participant_5_Password']
  )
end
