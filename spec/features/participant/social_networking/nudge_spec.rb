# filename: ./spec/features/participant/social_networking/nudge_spec.rb

require './spec/support/participants/nudge_helper'

feature 'Nudge', :social_networking, :marigold, sauce: sauce_labs do
  background(:all) { participant_1.sign_in } if ENV['safari']

  background do
    participant_1.sign_in unless ENV['safari']
    visit ENV['Base_URL']

    expect(navigation).to have_home_page_visible
  end

  scenario 'Participant nudges another participant' do
    pt_1_prof_1.visit_another_participants_profile
    navigation.scroll_down
    pt_1_prof_1.nudge
    visit ENV['Base_URL']

    expect(pt_1_prof_1).to have_nudge_in_feed
  end

  scenario 'Participant receives a nudge alert on profile page' do
    pt_1_prof_2.visit_profile

    expect(pt_1_prof_2).to have_nudge
  end

  scenario 'Participant sees nudge on landing page' do
    social_networking.scroll_to_bottom_of_feed
    navigation.scroll_to_bottom

    expect(social_networking).to have_last_feed_item
  end
end
