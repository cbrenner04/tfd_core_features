# filename: ./spec/features/participant/core/participant_login_spec.rb

require './spec/support/participants/login_helper'

feature 'Login', :core, :marigold, sauce: sauce_labs do
  scenario 'Participant signs in' do
    participant_1.sign_in

    expect(participant_navigation).to have_successful_login_alert
  end

  scenario 'Participant uses brand link to get to home page' do
    participant_1.sign_in unless ENV['safari']
    visit learn_1.landing_page

    expect(learn_1).to be_visible

    participant_navigation.click_brand

    expect(participant_navigation).to have_home_page_visible
  end

  scenario 'Participant signs out' do
    ENV['safari'] ? visit(ENV['Base_URL']) : participant_1.sign_in
    participant_1.sign_out

    expect(participant_navigation).to have_sign_up_alert
  end

  scenario 'Visitor is not able to log in with invalid creds' do
    visit visitor.login_page
    visitor.fill_in_login_form
    visitor.submit_login

    expect(participant_navigation).to have_unsuccessful_login_alert
  end

  scenario 'Participant who has withdrawn cannot sign in' do
    visit visitor.login_page
    old_participant.fill_in_login_form
    old_participant.submit_login

    expect(participant_navigation).to have_no_active_membership_alert
  end

  scenario 'Visitor tries to visit a specific page, is redirected to login' do
    visit think.landing_page

    expect(participant_navigation).to have_sign_up_alert
  end

  scenario 'Visitor views the intro slideshow' do
    visit ENV['Base_URL']
    participant_navigation.click_on_login_page_slideshow
    participant_navigation.done

    expect(participant_navigation).to have_sign_up_alert
  end

  scenario 'Participant uses the forgot password functionality' do
    visit ENV['Base_URL']
    participant_1.select_forgot_password
    participant_1.submit_forgot_password

    expect(participant_navigation).to have_password_reset_alert
  end
end

feature 'Login', :tfd, sauce: sauce_labs do
  scenario 'Participant who has completed signs in' do
    completed_participant.sign_in
    visit messages.landing_page

    expect(messages).to have_inbox_visible
    expect(messages).to_not have_compose_button
  end
end
