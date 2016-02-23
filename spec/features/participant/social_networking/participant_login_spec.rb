# file: ./spec/features/participant/social_networking/participant_login_spec.rb

require './spec/support/participants/social_networking_login_helper'

feature 'Social Networking login', :social_networking, :marigold,
        sauce: sauce_labs do
  scenario 'Completed participant in a social arm sends message' do
    completer_sons.sign_in

    expect(navigation).to have_home_page_visible

    visit completer_message.landing_page
    completer_message.open_new_message

    expect(completer_message).to have_coach_as_recipient

    completer_message.write_message
    completer_message.send

    expect(completer_message).to have_saved_alert

    completer_sons.sign_out

    unless ENV['safari']
      visit "#{ENV['Base_URL']}/users/sign_in"
      user.sign_in_user(ENV['Clinician_Email'], 'completer',
                        ENV['Clinician_Password'])
      click_on 'Arms'
      find('h1', text: 'Arms')
      click_on 'Arm 1'
      click_on 'Group 1'
      click_on 'Messaging'
      click_on 'Messages'
      click_on 'Test message from completer'

      expect(page).to have_content 'From Completer'

      expect(page).to have_content 'Test'

      user.sign_out('participant2')
    end
  end

  scenario 'Completed participant in a mobile arm cannot compose a message' do
    mobile_completer.sign_in

    expect(navigation).to have_home_page_visible

    visit mobile_completer_message.landing_page

    expect(mobile_completer_message).to have_inbox_visible

    expect(mobile_completer_message).to_not have_compose_button

    mobile_completer.sign_out
  end
end
