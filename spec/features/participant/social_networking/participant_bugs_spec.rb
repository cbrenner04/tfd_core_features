# frozen_string_literal: true
feature 'Social Networking Bugs, Non-social Participant',
        :social_networking, :marigold, sauce: sauce_labs do
  scenario 'Participant cannot select My Profile from navbar dropdown' do
    nonsocial_pt.sign_in

    expect(participant_navigation).to_not have_profile_link_in_dropdown
  end
end
