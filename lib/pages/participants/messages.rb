require './lib/pages/shared/messages'

class Participants
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
  end
end
