# filename: ./spec/support/participants/nudge_helper.rb

require './lib/pages/participants/social_networking'
require './lib/pages/participants/social_networking_modules/profile'

def social_networking
  @social_networking ||= Participants::SocialNetworking.new
end

def pt_1_prof_1
  @pt_1_prof_1 ||= Participants::SocialNetworkingModules::Profile.new(
    other_pt: 'participant5'
  )
end

def pt_1_prof_2
  @pt_1_prof_2 ||= Participants::SocialNetworkingModules::Profile.new(
    nudger: 'participant2'
  )
end
