# frozen_string_literal: true
def group_1
  Users::Groups.new(title: 'Group 1')
end

def site_messaging_1
  Users::Messages.new(
    message_subject: 'Testing site messaging',
    message_body: 'This message is intended to test the functionality of ' \
                  'site messaging.',
    participant: 'TFD-1111'
  )
end

def site_messaging_2
  Users::Messages.new(
    message_subject: 'message subject',
    message_body: 'message body',
    participant: 'TFD-1111'
  )
end

def site_messaging_3
  Users::Messages.new(
    message_subject: '',
    message_body: 'message body',
    participant: 'TFD-1111'
  )
end

def site_messaging_4
  Users::Messages.new(
    message_subject: 'message subject',
    message_body: '',
    participant: 'TFD-1111'
  )
end

def site_messaging_1700
  Users::Messages.new(
    message_subject: 'Too many characters',
    participant: 'TFD-1111'
  )
end
