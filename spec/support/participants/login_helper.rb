# filename: ./spec/support/participants/login_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/navigation'
require './lib/pages/participants/learn'
require './lib/pages/participants/think'
require './lib/pages/participants/messages'

def visitor
  @visitor ||= Participants.new(
    participant: 'asdf@example.com',
    password: 'asdf'
  )
end

def old_participant
  @old_participant ||= Participants.new(
    participant: ENV['Old_Participant_Email'],
    password: ENV['Old_Participant_Password']
  )
end

def completed_participant
  @completed_participant ||= Participants.new(
    participant: ENV['Completed_Pt_Email'],
    password: ENV['Completed_Pt_Password'],
    old_participant: 'participant1'
  )
end

def navigation
  @navigation ||= Participants::Navigation.new
end

def learn
  @learn ||= Participants::Learn.new(lesson_title: 'Introduction')
end

def think
  @think ||= Participants::Think.new
end

def messages
  @messages ||= Participants::Messages.new(message_subject: 'fake')
end
