# filename: ./spec/features/user/core/coach_messages_spec.rb

require './spec/support/users/messages_helper'

feature 'Coach messaging', :core, sauce: sauce_labs do
  background(:all) { clinician_som.sign_in if ENV['safari'] }

  background do
    clinician_som.sign_in unless ENV['safari']
    visit navigation.arms_page
    user_messages.navigate_to_messages
  end

  scenario 'Coach reads a received message' do
    user_message_1.open_message

    expect(user_message_1).to have_sender

    expect(user_message_1).to have_message_visible
  end

  scenario 'Coach reads a sent message' do
    user_message_2.go_to_sent_messages
    user_message_2.open_message

    expect(user_message_2).to have_message_visible
  end

  scenario 'Coach replies to a message' do
    user_message_3.open_message
    user_message_3.reply
    user_message_3.enter_reply_message
    navigation.scroll_down
    user_message_3.send

    expect(user_message_3).to have_saved_alert

    unless ENV['safari']
      participant_1_so2.sign_in
      visit participant_message_1.landing_page
      expect(participant_message_1).to have_message
    end
  end

  scenario 'Coach composes a message' do
    user_message_4.open_new_message
    user_message_4.select_recipient
    user_message_4.write_message
    user_message_4.select_link
    user_message_4.send

    expect(user_message_4).to have_saved_alert

    unless ENV['safari']
      participant_1_so2.sign_in
      visit participant_message_2.landing_page

      expect(participant_message_2).to have_message
    end
  end

  scenario 'Coach searches for a specific participants messages' do
    user_message_5.search

    expect(user_message_5).to have_message

    user_message_5.go_to_sent_messages

    expect(user_message_6).to have_message

    expect(user_message_7).to_not have_message
  end

  scenario 'Coach uses breadcrumbs to return to home' do
    navigation.go_back_to_group_page
    navigation.go_back_to_home_page

    expect(navigation).to have_home_visible
  end
end
