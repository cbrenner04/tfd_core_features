# filename: ./spec/support/participants/login_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/learn'
require './lib/pages/participants/think'
require './lib/pages/participants/messages'

def visitor
  @visitor ||= Participant.new(
    participant: 'asdf@example.com',
    password: 'asdf'
  )
end

def old_participant
  @old_participant ||= Participant.new(
    participant: ENV['Old_Participant_Email'],
    password: ENV['Old_Participant_Password']
  )
end

def completed_participant
  @completed_participant ||= Participant.new(
    participant: ENV['Completed_Pt_Email'],
    password: ENV['Completed_Pt_Password']
  )
end

def learn_1
  @learn_1 ||= Participants::Learn.new(lesson_title: 'Introduction')
end

def think
  @think ||= Participants::Think.new
end

def messages
  @messages ||= Participants::Messages.new(message_subject: 'fake')
end
