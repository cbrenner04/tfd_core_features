# filename: ./spec/features/participant/social_networking/nudge_spec.rb

describe 'Active participant in a social arm signs in,',
         :social_networking, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_pt(ENV['Participant_Email'], 'participant1',
                 ENV['Participant_Password'])
    end
  else
    before do
      sign_in_pt(ENV['Participant_Email'], 'participant1',
                 ENV['Participant_Password'])
    end
  end

  it 'nudges another participant' do
    visit ENV['Base_URL']
    within('.profile-border.profile-icon-top', text: moderator) do
      click_on moderator
    end

    click_on 'Nudge'
    expect(page).to have_content 'Nudge sent!'

    visit ENV['Base_URL']
    find_feed_item("nudged #{moderator}")
    expect(page).to have_content "nudged #{moderator}"
  end

  it 'receives a nudge alert on profile page' do
    visit "#{ENV['Base_URL']}/social_networking/profile_page"
    if page.has_css?('.modal-content')
      within('.modal-content') do
        page.all('img')[2].click
      end
    end

    expect(page).to have_content "#{moderator} nudged you!"
  end

  it 'sees nudge on landing page' do
    visit ENV['Base_URL']
    find('h1', text: 'HOME')
    find_feed_item('nudged participant1')
    expect(page).to have_content 'nudged participant1'
  end
end
