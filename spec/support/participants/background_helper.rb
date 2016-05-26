# filename: ./spec/support/participants/background_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/think'
require './lib/pages/participants/incentives_modules/background'
require './lib/pages/participants/social_networking_modules/profile'

def background_participant
  @background_participant ||= Participant.new(
    participant: ENV['PTBackground_Email'],
    password: ENV['PTBackground_Password']
  )
end

def think
  @think ||= Participants::Think.new
end

def app_background_1
  @app_background_1 ||= Participants::IncentivesModules::Background.new(
    image: 'vine'
  )
end

def app_background_2
  @app_background_2 ||= Participants::IncentivesModules::Background.new(
    image: 'rainbow'
  )
end

def bkgd_pt_profile
  @bkgd_pt_profile ||= Participants::SocialNetworkingModules::Profile.new(
    display_name: 'participant_background'
  )
end
