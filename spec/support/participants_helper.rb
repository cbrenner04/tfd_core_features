# filename: ./spec/support/participants_helper.rb

require './lib/pages/participants'
require './lib/pages/particiapnts/navigation'

def navigation
  @navigation ||= Participants::Navigation.new
end

def participant_1
  @participant_1 ||= Participants.new(
    participant: ENV['Participant_Email'],
    password: ENV['Participant_Password']
  )
end

def participant_3
  @participant_3 ||= Participants.new(
    participant: ENV['Alt_Participant_Email'],
    password: ENV['Alt_Participant_Password']
  )
end

def participant_5
  @participant_5 ||= Participants.new(
    participant: ENV['Participant_5_Email'],
    password: ENV['Participant_5_Password']
  )
end

def nonsocial_pt
  @nonsocial_pt ||= Participants.new(
    participant: ENV['NS_Participant_Email'],
    password: ENV['NS_Participant_Password']
  )
end

def marigold_participant
  @marigold_participant ||= Participants.new(
    participant: ENV['Marigold_Participant_Email'],
    password: ENV['Marigold_Participant_Password']
  )
end
