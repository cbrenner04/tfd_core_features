# frozen_string_literal: true
def visitor
  Participant.new(
    participant: 'asdf@example.com',
    password: 'asdf'
  )
end

def old_participant
  Participant.new(
    participant: ENV['Old_Participant_Email'],
    password: ENV['Old_Participant_Password']
  )
end

def completed_participant
  Participant.new(
    participant: ENV['Completed_Pt_Email'],
    password: ENV['Completed_Pt_Password']
  )
end

def learn_1
  Participants::Learn.new(lesson_title: 'Introduction')
end

def think
  Participants::Think.new
end

def messages
  Participants::Messages.new(message_subject: 'fake')
end
