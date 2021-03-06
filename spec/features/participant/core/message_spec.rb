# frozen_string_literal: true
# filename: ./spec/features/participant/core/message_spec.rb

require './spec/support/participants/messages_helper'

feature 'MESSAGES tool', :core, :marigold, sauce: sauce_labs do
  background(:all) { participant_1.sign_in if ENV['safari'] }

  background do
    participant_1.sign_in unless ENV['safari']
    visit messages.landing_page
  end

  scenario 'Participant cannot send message with more than 1700 characters' do
    messages.open_new_message
    message_1700.write_message_with_more_than_1700_characters
    messages.send

    expect(messages).to have_saved_alert

    messages.go_to_sent_messages
    message_1700.open_message

    expect(message_1700).to have_1700_characters_message
  end

  scenario 'Participant composes a new message' do
    messages.open_new_message

    expect(messages).to have_coach_as_recipient

    new_message.write_message
    messages.send

    expect(messages).to have_saved_alert
  end

  scenario 'Participant reads a sent message' do
    messages.go_to_sent_messages
    sent_message.open_message

    expect(sent_message).to have_sender
    expect(sent_message).to have_message_visible
  end

  scenario 'Participant reads and replies to a received message' do
    received_message.open_message

    expect(received_message).to have_message_visible

    messages.open_reply

    expect(messages).to have_coach_as_recipient

    messages.enter_reply_message
    participant_navigation.scroll_down
    messages.send

    expect(messages).to have_saved_alert
  end

  scenario 'Participant composes a message from reading a message' do
    received_message.open_message

    expect(received_message).to have_message_visible

    messages.open_new_message

    expect(messages).to have_coach_as_recipient
  end

  scenario 'Participant uses the cancel button within compose message' do
    messages.open_new_message
    participant_navigation.cancel

    expect(messages).to have_inbox_visible
  end

  scenario 'Participant uses return button within compose message' do
    messages.open_new_message
    messages.return_to_inbox

    expect(messages).to have_inbox_visible
  end
end

feature 'MESSAGES tool, with link', :core, :marigold, sauce: sauce_labs do
  scenario 'Participant accesses a link from a message in inbox' do
    participant_3.sign_in
    visit messages.landing_page
    linked_message.open_message

    expect(linked_message).to have_message_visible

    linked_message.go_to_link

    expect(linked_message).to have_link_content
  end
end

feature 'MESSAGES tool, Marigold specific', :marigold, sauce: sauce_labs do
  scenario 'Participant access the messaging tool from the logout dropdown' do
    marigold_participant.sign_in
    messages.go_to_contact_us

    expect(messages).to have_contact_us_visible
  end
end
