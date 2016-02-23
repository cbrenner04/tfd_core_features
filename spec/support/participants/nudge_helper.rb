# filename: ./spec/support/participants/nudge_helper.rb

require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'
require './lib/pages/participants/social_networking/profile'

def navigation
  @navigation ||= Participants::Navigation.new
end

def social_networking
  @social_networking ||= Participants::SocialNetworking.new
end

def participant_1_profile
  @participant_1_profile ||= Participants::SocialNetworking::Profile.new(
    other_pt: 'participant5',
    nudger: 'participant2'
  )
end
