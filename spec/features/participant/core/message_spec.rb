# filename: ./spec/features/participant/core/message_spec.rb

feature 'MESSAGES tool', :core, :marigold, sauce: sauce_labs do
  background(:all) { participant_1.sign_in if ENV['safari'] }

  background do
    participant_1.sign_in unless ENV['safari']
    visit messages.landing_page
  end

  scenario 'Participant composes a new message' do
    messages.open_new_message

    expect(messages).to have_coach_as_recipient

    messages.write_message
    messages.send

    expect(messages).to have_saved_alert
  end

  scenario 'Participant reads a sent message' do
    messages.go_to_sent_messages
    messages.open_sent_message

    expect(messages).to have_sent_message_visible
  end

  scenario 'Participant reads and replies to a received message' do
    messages.open_received_message

    expect(messages).to have_received_message_visible

    messages.open_reply

    expect(messages).to have_coach_as_recipient

    mesages.enter_reply_message
    navigation.scroll_down
    messages.send

    expect(messages).to have_saved_alert
  end

  scenario 'Participant composes a message from reading a message' do
    messages.open_received_message

    expect(messages).to have_received_message_visible

    messages.open_new_message

    expect(messages).to have_coach_as_recipient
  end

  scenario 'Participant uses the cancel button within compose message' do
    messages.open_new_message
    navigation.cancel

    expect(messages).to have_inbox_visible
  end

  scenario 'uses return button within compose message' do
    messages.open_new_message
    messages.return_to_inbox

    expect(messages).to have_inbox_visible
  end
end

feature 'MESSAGES tool, accessing a link',
        :core, :marigold, sauce: sauce_labs do
  scenario 'Participant accesses a link from a message in inbox' do
    participant_3.sign_in
    visit messages.landing_page
    messages.open_linked_message

    expect(messages).to have_linked_message_visible

    messages.go_to_link

    expect(messages).to have_link_content
  end
end
