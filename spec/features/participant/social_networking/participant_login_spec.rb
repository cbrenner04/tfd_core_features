# file: ./spec/features/participant/social_networking/participant_login_spec.rb

require './spec/support/participants/social_networking_login_helper'

feature 'Social Networking login', :social_networking, :marigold,
        sauce: sauce_labs do
  scenario 'Completed participant in a social arm sends message' do
    completer.sign_in

    expect(participant_navigation).to have_home_page_visible

    visit completer_message.landing_page
    completer_message.open_new_message

    expect(completer_message).to have_coach_as_recipient

    completer_message.write_message
    completer_message.send

    expect(completer_message).to have_saved_alert
  end

  scenario 'Completed participant in a mobile arm cannot compose a message' do
    mobile_completer.sign_in

    expect(participant_navigation).to have_home_page_visible

    visit mobile_completer_message.landing_page

    expect(mobile_completer_message).to have_inbox_visible
    expect(mobile_completer_message).to_not have_compose_button
  end
end
