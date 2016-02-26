# filename: ./spec/support/participants_helper.rb

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

def participant_1_so4
  @participant_1_so4 ||= Participants.new(
    participant: ENV['Participant_Email'],
    old_participant: 'participant4',
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

def nonsocial_pt
  @nonsocial_pt ||= Participants.new(
    participant: ENV['NS_Participant_Email'],
    old_participant: 'participant1',
    password: ENV['NS_Participant_Password'],
    display_name: 'nonsocialpt'
  )
end

def marigold_participant_so3
  @marigold_participant_so3 ||= Participants.new(
    participant: ENV['Marigold_Participant_Email'],
    old_participant: 'participant3',
    password: ENV['Marigold_Participant_Password'],
    display_name: 'marigold_1'
  )
end
