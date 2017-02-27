# frozen_string_literal: true
require './spec/support/pages/shared/messages'

module Participants
  # page object for Messages Tool
  class Messages
    include Capybara::DSL
    include SharedMessages

    def initialize(messages)
      @message_subject ||= messages[:message_subject]
      @message_body ||= messages[:message_body]
      @reply_body ||= messages[:reply_body]
      @link ||= messages[:link]
      @link_content ||= messages[:link_content]
      @sender ||= messages[:sender]
    end

    def landing_page
      "#{ENV['Base_URL']}/navigator/contexts/MESSAGES"
    end

    def has_coach_as_recipient?
      has_css?('.control-label', text: 'To Coach')
    end

    def open_reply
      click_on 'Reply'
    end

    def has_inbox_visible?
      has_text? 'Inbox'
    end

    def has_compose_button?
      has_text? 'Compose'
    end

    def return_to_inbox
      click_on 'Return'
    end

    def go_to_link
      click_on @link
      sleep(1)
    end

    def has_link_content?
      has_text? @link_content
    end

    def go_to_contact_us
      find('.navbar-collapse').all('.dropdown-toggle').last.click
      click_on 'Contact Us'
    end

    def has_contact_us_visible?
      has_css?('h1', text: 'Contact Us') &&
        has_text?('We would love to hear from you! Use this form to get in' \
                  ' touch with the MARIGOLD team about: Website problems ' \
                  '(like broken links or trouble logging in) Questions about ' \
                  'the home practice (like if you\'re having trouble thinking' \
                  ' of positive events) Comments about the site Please do not' \
                  ' use this form if this is an emergency. If you are in ' \
                  'danger or need medical help, call 911. If you are having a' \
                  ' crisis and need someone to talk to right away, please ' \
                  'call 1-800-273-TALK or go to imalive.org.')
    end
  end
end
