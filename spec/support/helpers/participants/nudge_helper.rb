# frozen_string_literal: true
def social_networking
  Participants::SocialNetworking.new
end

def pt_1_prof_1
  Participants::SocialNetworkingModules::Profile.new(
    other_pt: 'participant5'
  )
end

def pt_1_prof_2
  Participants::SocialNetworkingModules::Profile.new(
    display_name: 'participant1'
  )
end
