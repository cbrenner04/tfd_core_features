# filename: ./spec/features/participant/social_networking/nudge_spec.rb

feature 'Nudge', :social_networking, :marigold, sauce: sauce_labs do
  if ENV['safari']
    if ENV['sunnyside'] || ENV['marigold']
      background(:all) do
        sign_in_pt(ENV['Participant_Email'], 'participant4',
                   ENV['Participant_Password'])
      end
    end
  else
    background do
      sign_in_pt(ENV['Participant_Email'], 'participant1',
                 ENV['Participant_Password'])
    end
  end

  scenario 'Participant nudges another participant' do
    visit ENV['Base_URL']
    find('a', text: 'participant5').click
    page.execute_script('window.scrollBy(0,500)')
    click_on 'Nudge'
    expect(page).to have_content 'Nudge sent!'

    visit ENV['Base_URL']
    find_feed_item('nudged participant5')
    expect(page).to have_content 'nudged participant5'
  end

  scenario 'Participant receives a nudge alert on profile page' do
    visit "#{ENV['Base_URL']}/social_networking/profile_page"
    unless page.has_no_css?('.modal-content')
      within('.modal-content') do
        page.all('img')[2].click
      end
    end

    expect(page).to have_content "#{moderator} nudged you!"
  end

  scenario 'Participant sees nudge on landing page' do
    visit ENV['Base_URL']
    find('h1', text: 'HOME')
    find_feed_item('nudged participant1')
    page.execute_script('window.scrollBy(0,2000)')
    expect(page).to have_content 'nudged participant1'
  end
end
