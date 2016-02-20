class Participants
  # page object for Messages Tool
  class Messages
    include Capybara::DSL

    def initialize(messages_arry)
      @message_subject ||= messages_arry[:message_subject]
      @message_body ||= messages_arry[:message_body]
      @reply_body ||= messages_arry[:reply_body]
      @link ||= messages_arry[:link]
      @link_content ||= messages_arry[:link_content]
    end

    def landing_page
      "#{ENV['Base_URL']}/navigator/contexts/MESSAGES"
    end

    def open_new_message
      click_on 'Compose'
    end

    def has_coach_as_recipient?
      has_css?('.control-label', text: 'To Coach')
    end

    def write_message
      within('#new_message') do
        fill_in 'message_subject', with: @message_subject
        fill_in 'message_body', with: @message_body
      end
    end

    def send
      click_on 'Send'
    end

    def has_saved_alert?
      has_text? 'Message saved'
    end

    def go_to_sent_messages
      click_on 'Sent'
    end

    def open_message
      click_on @message_subject
    end

    def has_you_as_sender?
      has_css?('strong', text: 'From You')
    end

    def has_message_visible
      has_text? @message_body
    end

    def open_reply
      click_on 'Reply'
    end

    def enter_reply_message
      within('#new_message') { fill_in 'message_body', with: @reply_body }
    end

    def has_inbox_visible?
      has_text? 'Inbox'
    end

    def return_to_inbox
      click_on 'Return'
    end

    def go_to_link
      click_on @link
    end

    def has_link_content?
      has_text? @link_content
    end
  end
end
