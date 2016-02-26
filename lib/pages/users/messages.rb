require './lib/pages/shared/messages'

class Users
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
      click_on 'Arm 1'
      click_on 'Group 1'
      click_on 'Messaging'
      click_on 'Messages'
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
  end
end
