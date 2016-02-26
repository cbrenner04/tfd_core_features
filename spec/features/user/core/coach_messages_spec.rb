# filename: ./spec/features/user/core/coach_messages_spec.rb

feature 'Coach messaging', :core, sauce: sauce_labs do
  if ENV['safari']
    background(:all) do
      users.sign_in_user(ENV['Clinician_Email'], 'mobilecompleter',
                   ENV['Clinician_Password'])
    end
  end

  background do
    unless ENV['safari']
      users.sign_in_user(ENV['Clinician_Email'], 'mobilecompleter',
                   ENV['Clinician_Password'])
    end

    visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
    click_on 'Arm 1'
    click_on 'Group 1'
    click_on 'Messaging'
    click_on 'Messages'
  end

  scenario 'Coach reads a received message' do
    click_on 'I like this app'
    find('strong', text: 'From TFD-1111')
    expect(page).to have_content 'This app is really helpful!'
  end

  scenario 'Coach reads a sent message' do
    click_on 'Sent'
    click_on 'Try out the LEARN tool'
    expect(page).to have_content 'I think you will find it helpful.'
  end

  scenario 'Coach replies to a message' do
    click_on 'I like this app'
    click_on 'Reply to this message'
    find('#coach-message-link-selection')
    fill_in 'message[body]',
            with: 'This message is to test the reply functionality'
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Send'
    expect(page).to have_content 'Message saved'

    unless ENV['safari']
      sign_in_pt(ENV['Participant_Email'], 'participant2',
                 ENV['Participant_Password'])
      visit "#{ENV['Base_URL']}/navigator/contexts/MESSAGES"
      expect(page).to have_content 'Reply: I like this app'
    end
  end

  scenario 'Coach composes a message' do
    click_on 'Compose'
    select 'TFD-1111', from: 'message_recipient_id'
    fill_in 'message_subject', with: 'Testing compose functionality'
    select 'Intro', from: 'coach-message-link-selection'
    fill_in 'message_body',
            with: 'This message is to test the compose functionality.'
    click_on 'Send'
    expect(page).to have_content 'Message saved'

    unless ENV['safari']
      sign_in_pt(ENV['Participant_Email'], 'participant2',
                 ENV['Participant_Password'])
      visit "#{ENV['Base_URL']}/navigator/contexts/MESSAGES"
      expect(page).to have_content 'Testing compose functionality'
    end
  end

  scenario 'Coach searches for a specific participants messages' do
    select 'TFD-1111', from: 'search'
    click_on 'Search'
    find('.list-group-item', text: 'I like this app')
    click_on 'Sent'
    expect(page).to have_content 'Try out the LEARN tool'

    expect(page).to_not have_content 'Check out the Introduction slideshow'
  end

  scenario 'Coach uses breadcrumbs to return to home' do
    click_on 'Group'
    within('.breadcrumb') do
      click_on 'Home'
    end

    expect(page).to have_content 'Arms'
  end
end
