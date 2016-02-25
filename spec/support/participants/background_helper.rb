# filename: ./spec/support/participants/background_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/navigation'
require './lib/pages/participants/think'
require './lib/pages/participants/incentives/background'
require './lib/pages/participants/social_networking/profile'

def background_participant
  @background_participant ||= Participants.new(
    participant: ENV['PTBackground_Email'],
    old_participants: 'participant5',
    password: ENV['PTBackground_Password']
  )
end

def navigation
  @navigation ||= Participants::Navigation.new
end

def think
  @think ||= Participants::Think.new
end

def app_background_1
  @app_background_1 ||= Participants::Incentives::Background.new(
    image: 'vine'
  )
end

def app_background_2
  @app_background_2 ||= Participants::Incentives::Background.new(
    image: 'rainbow'
  )
end

def bkgd_pt_profile
  @bkgd_pt_profile ||= Participants::SocialNetworking::Profile.new(
    display_name: 'participant_background'
  )
end
