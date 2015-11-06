# file: ./spec/features/participant/social_networking/participant_login_spec.rb

describe 'A visitor to the site,', :social_networking,
         type: :feature, sauce: sauce_labs do
  it 'was an active participant in a social arm who has completed' do
    sign_in_pt(ENV['Completed_Pt_Email'], 'nonsocialpt',
               ENV['Completed_Pt_Password'])
    find('h1', text: 'HOME')
    find_feed_item('nudged participant1')
    expect(page).to have_content 'nudged participant1'

    visit "#{ENV['Base_URL']}/navigator/contexts/MESSAGES"
    click_on 'Compose'
    expect(page).to have_content 'To Coach'

    within('#new_message') do
      fill_in 'message_subject', with: 'Test message from completer'
      fill_in 'message_body',
              with: 'Test'
    end

    click_on 'Send'
    expect(page).to have_content 'Message saved'

    unless ENV['safari']
      visit "#{ENV['Base_URL']}/users/sign_in"
      sign_in_user(ENV['Clinician_Email'], 'completer',
                   ENV['Clinician_Password'])
      click_on 'Arms'
      find('h1', text: 'Arms')
      click_on 'Arm 1'
      click_on 'Group 1'
      click_on 'Messaging'
      click_on 'Messages'
      click_on 'Test message from completer'
      expect(page).to have_content 'From You'

      expect(page).to have_content 'Test'

      sign_out('TFD Moderator')
    end
  end

  it 'was an active participant in a mobile arm who has completed' do
    sign_in_pt(ENV['Mobile_Comp_Pt_Email'], 'completer',
               ENV['Mobile_Comp_Pt_Password'])
    find('h1', text: 'HOME')
    visit "#{ENV['Base_URL']}/navigator/contexts/MESSAGES"
    expect(page).to have_content 'Inbox'

    expect(page).to_not have_content 'Compose'
  end
end
