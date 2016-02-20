class Participants
  # page object for Messages Tool
  class Messages
    include Capybara::DSL

    def initialize(messages_arry)
      @new_message_subject ||= messages_arry[:new_message_subject]
      @new_message_body ||= messages_arry[:new_message_body]
      @sent_message_subject ||= messages_arry[:sent_message_subject]
      @sent_message_body ||= messages_arry[:sent_message_body]
      @received_message_subject ||= messages_arry[:received_message_subject]
      @received_message_body ||= messages_arry[:received_message_body]
      @reply_body ||= messages_arry[:reply_body]
      @linked_message_subject ||= messages_arry[:linked_message_subject]
      @linked_message_body ||= messages_arry[:linked_message_body]
      @linked_message_link ||= messages_arry[:linked_message_link]
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
        fill_in 'message_body', with: @new_message_body
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

    def open_sent_message
      click_on @sent_message_subject
      find('strong', text: 'From You')
    end

    def has_sent_message_visible
      has_text? @sent_message_body
    end

    def open_recieved_message
      click_on @received_message_subject
    end

    def has_received_message_visible?
      has_text? @received_message_body
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

    def open_linked_message
      click_on @linked_message_subject
    end

    def has_linked_message_visible?
      has_text? @linked_message_body
    end

    def go_to_link
      click_on @linked_message_link
    end

    def has_link_content?
      has_text? @link_content
    end
  end
end
