# module for shared Messages functionality
module SharedMessages
  include Capybara::DSL

  def open_message
    click_on @message_subject
  end

  def has_sender?
    has_css?('strong', text: @sender)
  end

  def has_message?
    has_text? @message_subject
  end

  def has_message_visible?
    has_text? @message_body
  end

  def go_to_sent_messages
    click_on 'Sent'
  end

  def send
    click_on 'Send'
  end

  def has_saved_alert?
    has_text? 'Message saved'
  end

  def open_new_message
    click_on 'Compose'
  end

  def write_message
    within('#new_message') do
      fill_in 'message_subject', with: @message_subject
      fill_in 'message_body', with: @message_body
    end
  end

  def enter_reply_message
    within('#new_message') { fill_in 'message_body', with: @reply_body }
  end
end
