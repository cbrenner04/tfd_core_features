# filename: ./spec/support/participants/social_networking_login_helper.rb

require './lib/pages/users'
require './lib/pages/participants'
require './lib/pages/participants/navigation'
require './lib/pages/participants/messages'

def user
  @user ||= Users.new
end

def completer_sons
  @completer_sons ||= Participants.new(
    participant: ENV['Completed_Pt_Email'],
    old_participant: 'nonsocialpt',
    password: ENV['Completed_Pt_Password'],
    display_name: 'completer'
  )
end

def mobile_completer
  @completer_sons ||= Participants.new(
    participant: ENV['Mobile_Comp_Pt_Email'],
    old_participant: 'completer',
    password: ENV['Mobile_Comp_Pt_Password'],
    display_name: 'mobilecompleter'
  )
end

def navigation
  @navigation ||= Participants::Navigation.new
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
