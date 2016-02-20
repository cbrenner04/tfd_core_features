# filename: ./spec/support/participants/messages_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/messages'
require './lib/pages/participants/navigation'

def navigation
  @navigation ||= Participants::Navigation.new
end

def participant_1
  @participant_1 ||= Participants.new(
    participant: ENV['Participant_Email'],
    old_participant: 'participant5',
    password: ENV['Participant_Password']
  )
end

def participant_3
  @participant_3 ||= Participant.new(
    participant: ENV['Alt_Participant_Email'],
    old_participant: 'participant1',
    password: ENV['Alt_Participant_Password']
  )
end

def messages
  @messages ||= Participants::Messages.new(reply_text: 'Got it. Thanks!')
end

def new_message
  @new_message ||= Participants.Messages.new(
    message_subject: 'New message',
    message_body: 'This is a test message to my moderator. ' \
                      'Hello, Moderator! How are you??'
  )
end

def sent_message
  @new_message ||= Participants.Messages.new(
    message_subject: 'I like this app',
    message_body: 'This app is really helpful!'
  )
end

def received_message
  @received_message ||= Participant::Messages.new(
    message_subject: 'Try out the LEARN tool',
    message_body: 'I think you will find it helpful'
  )
end

def linked_message
  @linked_message ||= Participants::Messages.new(
    message_subject: 'Check out the Introduction slideshow',
    message_body: 'Here\'s a link to the Introduction slideshow:',
    link: 'Introduction to ThinkFeelDo',
    link_content: 'Welcome to ThiFeDo'
  )
end
