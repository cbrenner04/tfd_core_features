# filename: ./spec/features/participant/social_networking/nudge_spec.rb

require './spec/support/participants/nudge_helper'

feature 'Nudge', :social_networking, :marigold, sauce: sauce_labs do
  if ENV['safari']
    if ENV['sunnyside'] || ENV['marigold']
      background(:all) { participant_1_so4.sign_in }
    end
  else
    background do
      participant_1_so1.sign_in
      visit ENV['Base_URL']

      expect(navigation).to have_home_page_visible
    end
  end

  scenario 'Participant nudges another participant' do
    participant_1_profile.visit_another_participants_profile
    navigation.scroll_down
    participant_1_profile.nudge
    visit ENV['Base_URL']

    expect(participant_1_profile).to have_nudge_in_feed
  end

  scenario 'Participant receives a nudge alert on profile page' do
    participant_1_profile.visit_profile

    expect(participant_1_profile).to have_nudge
  end

  scenario 'Participant sees nudge on landing page' do
    social_networking.scroll_to_bottom_of_feed
    navigation.scroll_to_bottom

    expect(social_networking).to have_last_feed_item
  end
end
