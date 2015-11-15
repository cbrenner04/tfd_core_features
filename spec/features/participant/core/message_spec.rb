# filename: ./spec/features/participant/core/message_spec.rb

describe 'Active participant in group 1 signs in, navigates to MESSAGES,',
         :core, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_pt(ENV['Participant_Email'], 'participant5',
                 ENV['Participant_Password'])
    end
  end

  before do
    unless ENV['safari']
      sign_in_pt(ENV['Participant_Email'], 'participant5',
                 ENV['Participant_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/MESSAGES"
  end

  it 'composes a new message' do
    click_on 'Compose'
    find('.control-label', text: 'To Coach')
    within('#new_message') do
      fill_in 'message_subject', with: 'New message'
      fill_in 'message_body',
              with: 'This is a test message to my moderator. ' \
              'Hello, Moderator! How are you??'
    end

    click_on 'Send'
    expect(page).to have_content 'Message saved'
  end

  it 'reads a sent message' do
    click_on 'Sent'
    click_on 'I like this app'
    find('.well', text: 'From You')
    expect(page).to have_content 'This app is really helpful!'
  end

  it 'reads a received message' do
    click_on 'Try out the LEARN tool'
    expect(page).to have_content 'I think you will find it helpful.'
  end

  it 'replies to a received message' do
    click_on 'Try out the LEARN tool'
    find('p', text: 'I think you will find it helpful.')
    click_on 'Reply'
    find('.control-label', text: 'To Coach')
    within('#new_message') do
      fill_in 'message_body', with: 'Got it. Thanks!'
    end

    page.execute_script('window.scrollBy(0,500)')
    click_on 'Send'
    expect(page).to have_content 'Message saved'
  end

  it 'composes a message from reading a message' do
    click_on 'Try out the LEARN tool'
    find('p', text: 'I think you will find it helpful.')
    click_on 'Compose'
    expect(page).to have_content 'To Coach'
  end

  it 'uses the cancel button within compose message' do
    click_on 'Compose'
    click_on 'Cancel'
    expect(page).to have_content 'Inbox'
  end

  it 'uses return button within compose message' do
    click_on 'Compose'
    click_on 'Return'
    expect(page).to have_content 'Inbox'
  end
end

describe 'Active participant in group 3 signs in, navigates to MESSAGES',
         :core, type: :feature, sauce: sauce_labs do
  before do
    sign_in_pt(ENV['Alt_Participant_Email'], 'participant1',
               ENV['Alt_Participant_Password'])
    visit "#{ENV['Base_URL']}/navigator/contexts/MESSAGES"
  end

  it 'accesses a link from a message in inbox' do
    click_on 'Check out the Introduction slideshow'
    find('p', text: "Here's a link to the introduction slideshow:")
    click_on 'Introduction to ThinkFeelDo'
    expect(page).to have_content 'Welcome to ThiFeDo'
  end
end
