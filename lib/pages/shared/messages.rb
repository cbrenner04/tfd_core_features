# frozen_string_literal: true
# module for shared Messages functionality
module SharedMessages
  include Capybara::DSL

  def open_message
    click_on @message_subject
  end

  def write_message_with_more_than_1700_characters
    within('#new_message') do
      fill_in 'message_subject', with: @message_subject
      fill_in 'message_body', with: more_than_1700_characters
    end
  end

  def has_1700_characters_message?
    has_text? more_than_1700_characters[0..1699]
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

  private

  def more_than_1700_characters
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur' \
    ' lacus ut arcu porttitor elementum. Suspendisse potenti. Pellentesque ' \
    'rutrum magna sit amet nibh maximus pharetra. Fusce varius aliquam ' \
    'ornare. Quisque ut metus sit amet sapien tempus imperdiet quis ac nibh. ' \
    'Sed metus orci, faucibus vel gravida et, placerat eget augue. Aliquam ' \
    'at sollicitudin lectus, eget lacinia felis. Suspendisse suscipit sed ' \
    'neque ut sagittis. Phasellus ornare nisi at vestibulum mattis. Nunc ' \
    'gravida finibus accumsan. Praesent aliquet dictum urna. Proin id ' \
    'bibendum dui. Integer nec consequat ex. Fusce in porttitor justo, vel ' \
    'tempor arcu. Phasellus eu varius est, vel convallis enim. Vestibulum ' \
    'dapibus efficitur orci id varius. Ut porta lorem diam, sed suscipit ' \
    'massa euismod eget. Donec interdum convallis leo, sit amet commodo lacus' \
    ' bibendum sit amet. Nam nec placerat libero. Vestibulum eu nunc est. ' \
    'Integer tristique rhoncus lacus, vitae tempor sem luctus ut. Donec ' \
    'mollis eget orci id efficitur. Phasellus interdum blandit odio quis ' \
    'eleifend. Donec scelerisque cursus ante, et condimentum metus sodales ' \
    'vel. Nam ac placerat tortor. Sed id tellus et felis lacinia faucibus. ' \
    'Nunc malesuada, lacus ac laoreet finibus, nulla dolor accumsan eros, ' \
    'quis fermentum orci felis a sem. Nulla dictum blandit purus, non ' \
    'interdum nunc sagittis et. Class aptent taciti sociosqu ad litora ' \
    'torquent per conubia nostra, per inceptos himenaeos. In rutrum dolor ' \
    'feugiat viverra aliquam. Vivamus lorem tortor, varius tincidunt gravida ' \
    'non, auctor a justo. Proin tincidunt tincidunt nulla, sit amet placerat ' \
    'mauris. Etiam mollis fermentum convallis. In nisl arcu, porttitor eget ' \
    'molestie eget, ultricies a mauris cras amet.'
  end
end
