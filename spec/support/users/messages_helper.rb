# filename: ./spec/support/users/messages_helper.rb

require './lib/pages/participants/messages'
require './lib/pages/users/messages'
require './lib/pages/users/navigation'

def navigation
  @navigation ||= Users::Navigation.new
end

def user_messages
  @user_messages ||= Users::Messages.new(message_subject: 'fake')
end

def user_message_1
  @user_message_1 ||= Users::Messages.new(
    message_subject: 'I like this app',
    sender: 'From TFD-1111',
    message_body: 'This app is really helpful!'
  )
end

def user_message_2
  @user_message_2 ||= Users::Messages.new(
    message_subject: 'Try out the LEARN tool',
    message_body: 'I think you will find it helpful'
  )
end

def user_message_3
  @user_message_3 ||= Users::Messages.new(
    message_subject: 'I like this app',
    reply_body: 'This message is to test the reply functionality'
  )
end

def participant_message_1
  @participant_message ||= Participants::Messages.new(
    message_subject: 'Reply: I like this app'
  )
end

def user_message_4
  @user_message_4 ||= Users::Messages.new(
    message_subject: 'Testing compose functionality',
    message_body: 'This message is to test the compose functionality.',
    participant: 'TFD-1111',
    link: 'Intro'
  )
end

def participant_message_2
  @participant_message_2 ||= Participants::Messages.new(
    message_subject: 'Testing compose functionality'
  )
end

def user_message_5
  @user_message_5 ||= Users::Messages.new(
    participant: 'TFD-1111',
    message_subject: 'I like this app'
  )
end

def user_message_6
  @user_message_6 ||= Users::Messages.new(
    message_subject: 'Try out the LEARN tool'
  )
end

def user_message_7
  @user_message_7 ||= Users::Messages.new(
    message_subject: 'Check out the Introduction slideshow'
  )
end
