# frozen_string_literal: true
# filename: ./spec/features/user/core/coach_site_messages_spec.rb

require './lib/pages/users/groups'
require './lib/pages/users/messages'

def group_1
  @group_1 ||= Users::Groups.new(title: 'Group 1')
end

def site_messaging_1
  @site_messaging_1 ||= Users::Messages.new(
    message_subject: 'Testing site messaging',
    message_body: 'This message is intended to test the functionality of ' \
                  'site messaging.',
    participant: 'TFD-1111'
  )
end

def site_messaging_2
  @site_messaging_2 ||= Users::Messages.new(
    message_subject: 'message subject',
    message_body: 'message body',
    participant: 'TFD-1111'
  )
end

def site_messaging_3
  @site_messaging_3 ||= Users::Messages.new(
    message_subject: '',
    message_body: 'message body',
    participant: 'TFD-1111'
  )
end

def site_messaging_4
  @site_messaging_4 ||= Users::Messages.new(
    message_subject: 'message subject',
    message_body: '',
    participant: 'TFD-1111'
  )
end

feature 'Site Messaging', :core, :marigold, sauce: sauce_labs do
  background(:all) { clinician.sign_in } if ENV['safari']

  background do
    clinician.sign_in unless ENV['safari']
    visit user_navigation.arms_page
    site_messaging_1.navigate_to_site_messages
    expect(site_messaging_1).to have_site_messages_visible
  end

  scenario 'Coach cannot send site message until all fields are complete' do
    site_messaging_3.send_new_site_message

    expect(site_messaging_3).to_not have_site_message_successfully_sent
    expect(site_messaging_3)
      .to have_failed_to_send_message_due_to_blank_subject_alert

    site_messaging_4.fill_in_message
    site_messaging_4.send

    expect(site_messaging_4).to_not have_site_message_successfully_sent
    expect(site_messaging_4)
      .to have_failed_to_send_message_due_to_blank_body_alert
  end

  scenario 'Coach creates and sends a new site message' do
    site_messaging_1.send_new_site_message

    expect(site_messaging_1).to have_site_message_successfully_sent

    site_messaging_1.return_to_site_messaging

    expect(site_messaging_1).to have_site_message
  end

  scenario 'Coach reviews a previously sent site message' do
    site_messaging_2.show_site_message

    expect(site_messaging_2).to have_site_message_visible
  end

  scenario 'Coach uses breadcrumbs to return to home' do
    group_1.go_back_to_group_page
    user_navigation.go_back_to_home_page

    expect(user_navigation).to have_home_visible
  end
end
