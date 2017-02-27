# frozen_string_literal: true
require './spec/support/pages/shared/messages'

module Users
  # page object for messages
  class Messages
    include Capybara::DSL
    include SharedMessages

    def initialize(message)
      @message_subject ||= message[:message_subject]
      @message_body ||= message[:message_body]
      @reply_body ||= message[:reply_body]
      @sender ||= message[:sender]
      @participant ||= message[:participant]
      @link ||= message[:link]
    end

    def navigate_to_messages
      navigate_to_messaging
      click_on 'Messages'
    end

    def visible?
      has_css?('h1', text: 'Messages')
    end

    def navigate_to_site_messages
      navigate_to_messaging
      click_on 'Site Messaging'
    end

    def has_site_messages_visible?
      has_css?('h1', text: 'Listing Site Messages')
    end

    def reply
      click_on 'Reply to this message'
    end

    def select_recipient
      select @participant, from: 'message_recipient_id'
    end

    def select_link
      select @link, from: 'coach-message-link-selection'
    end

    def search
      select @participant, from: 'search'
      click_on 'Search'
    end

    def send_new_site_message
      click_on 'New'
      fill_in_message
      send
    end

    def fill_in_message
      select @participant, from: 'site_message_participant_id'
      fill_in 'site_message_subject', with: @message_subject
      fill_in 'site_message_body', with: @message_body
    end

    def send
      click_on 'Send'
    end

    def send_1700_character_site_message
      click_on 'New'
      select @participant, from: 'site_message_participant_id'
      fill_in 'site_message_subject', with: @message_subject
      fill_in 'site_message_body', with: more_than_1700_characters
      send
    end

    def has_site_message_successfully_sent?
      has_text? 'Site message was successfully created.' \
                "\nParticipant: #{@participant}" \
                "\nSubject: #{@message_subject}" \
                "\nBody: #{@message_body}"
    end

    def has_failed_to_send_message_due_to_blank_subject_alert?
      has_text? '1 error prohibited this site_message from being saved: ' \
                'Subject can\'t be blank'
    end

    def has_failed_to_send_message_due_to_blank_body_alert?
      has_text? '1 error prohibited this site_message from being saved: ' \
                'Body can\'t be blank'
    end

    def return_to_site_messaging
      click_on 'Back'
    end

    def has_site_message?
      find('tr', text: @message_subject)
        .has_text? "#{@participant} #{@message_subject}  " \
                   "#{@message_body} #{long_date(today)}"
    end

    def show_site_message
      find('tr', text: @message_subject).find('a', text: 'Show').click
    end

    def has_site_message_visible?
      has_text? "Participant: #{@participant}\nSubject: #{@message_subject}" \
                "\nBody: #{@message_body}"
    end

    def has_1700_character_site_message_visible?
      has_text? "Participant: #{@participant}\nSubject: #{@message_subject}" \
                "\nBody: #{more_than_1700_characters[0..1699]}"
    end

    private

    def navigate_to_messaging
      click_on 'Arm 1'
      click_on 'Group 1'
      click_on 'Messaging'
    end

    def app_email
      return 'localhost' if ENV['tfd'] || ENV['tfdso'] || ENV['marigold']
      return 'sunnyside.northwestern.edu' if ENV['sunnyside']
    end
  end
end
