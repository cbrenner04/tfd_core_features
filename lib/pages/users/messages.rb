require './lib/pages/shared/messages'

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

    def navigate_to_site_messages
      navigate_to_messaging
      click_on 'Site Messaging'
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
      find('p', text: app_email)
      select @participant, from: 'site_message_participant_id'
      fill_in 'site_message_subject', with: @message_subject
      fill_in 'site_message_body', with: @message_body
      click_on 'Send'
    end

    def has_site_message_successfully_sent?
      has_text? 'Site message was successfully created.' \
                "\nParticipant: #{@participant}" \
                "\nSubject: #{@message_subject}" \
                "\nBody: #{@message_body}"
    end

    def return_to_site_messaging
      click_on 'Back'
    end

    def has_site_message?
      find('tr:nth-child(2)')
        .has_text? "#{@participant} #{@message_subject}  " \
                   "#{@message_body} #{Date.today.strftime('%b %d %Y')}"
    end

    def show_site_message
      find('tr', text: @message_subject).find('a', text: 'Show').click
    end

    def has_site_message_visible?
      has_text? "Participant: #{@participant}\nSubject: #{@message_subject}" \
                "\nBody: #{@message_body}"
    end

    private

    def navigate_to_messaging
      click_on 'Arm 1'
      click_on 'Group 1'
      click_on 'Messaging'
    end

    def app_email
      if ENV['tfd']
        'localhost'
      elsif ENV['tfdso']
        'localhost'
      elsif ENV['sunnyside']
        'sunnyside.northwestern.edu'
      elsif ENV['marigold']
        'marigold.northwestern.edu'
      end
    end
  end
end
