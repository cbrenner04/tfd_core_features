# frozen_string_literal: true
# filename: ./spec/support/participants/messages_helper.rb

require './lib/pages/participants/messages'

def messages
  @messages ||= Participants::Messages.new(reply_body: 'Got it. Thanks!')
end

def new_message
  @new_message ||= Participants::Messages.new(
    message_subject: 'New message',
    message_body: 'This is a test message to my moderator. ' \
                      'Hello, Moderator! How are you??'
  )
end

def sent_message
  @new_message ||= Participants::Messages.new(
    message_subject: 'I like this app',
    message_body: 'This app is really helpful!',
    sender: 'From You'
  )
end

def received_message
  @received_message ||= Participants::Messages.new(
    message_subject: 'Try out the LEARN tool',
    message_body: 'I think you will find it helpful'
  )
end

def linked_message
  @linked_message ||= Participants::Messages.new(
    message_subject: 'Check out the Introduction slideshow',
    message_body: 'Here\'s a link to the introduction slideshow:',
    link: 'Introduction to ThinkFeelDo',
    link_content: 'Welcome to ThiFeDo'
  )
end

def message_1700
  @message_1700 ||= Participants::Messages.new(
    message_subject: 'Too many characters'
  )
end
