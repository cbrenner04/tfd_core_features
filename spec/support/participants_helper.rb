# frozen_string_literal: true
# filename: ./spec/support/participants_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/navigation'
require './lib/pages/time_formats'

include TimeFormats

def participant_navigation
  @participant_navigation ||= Participants::Navigation.new
end

def participant_1
  @participant_1 ||= Participant.new(
    participant: ENV['Participant_Email'],
    password: ENV['Participant_Password']
  )
end

def participant_3
  @participant_3 ||= Participant.new(
    participant: ENV['Alt_Participant_Email'],
    password: ENV['Alt_Participant_Password']
  )
end

def participant_5
  @participant_5 ||= Participant.new(
    participant: ENV['Participant_5_Email'],
    password: ENV['Participant_5_Password']
  )
end

def nonsocial_pt
  @nonsocial_pt ||= Participant.new(
    participant: ENV['NS_Participant_Email'],
    password: ENV['NS_Participant_Password']
  )
end

def marigold_participant
  @marigold_participant ||= Participant.new(
    participant: ENV['Marigold_Participant_Email'],
    password: ENV['Marigold_Participant_Password']
  )
end
