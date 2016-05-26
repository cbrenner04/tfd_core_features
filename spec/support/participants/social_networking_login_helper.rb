# filename: ./spec/support/participants/social_networking_login_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/messages'

def completer
  @completer ||= Participant.new(
    participant: ENV['Completed_Pt_Email'],
    password: ENV['Completed_Pt_Password']
  )
end

def mobile_completer
  @mobile_completer ||= Participant.new(
    participant: ENV['Mobile_Comp_Pt_Email'],
    password: ENV['Mobile_Comp_Pt_Password']
  )
end

def completer_message
  @completer_message ||= Participants::Messages.new(
    message_subject: 'Test message from completer',
    message_body: 'Test'
  )
end

def mobile_completer_message
  @mobile_completer_message ||= Participants::Messages.new(
    message_subject: 'fake'
  )
end
