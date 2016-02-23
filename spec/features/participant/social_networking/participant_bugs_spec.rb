# file: ./spec/features/participant/social_networking/participant_bugs_spec.rb

require './lib/pages/participants/navigation'

def navigation
  @navigation ||= Participants::Navigation.new
end

feature 'Social Networking Bugs, Non-social Participant',
        :social_networking, :marigold, sauce: sauce_labs do
  scenario 'Participant cannot select My Profile from navbar dropdown' do
    nonsocial_pt.sign_in

    expect(navigation).to_not have_profile_link_in_dropdown

    nonsocial_pt.sign_out
  end
end
