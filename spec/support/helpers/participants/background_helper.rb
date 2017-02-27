# frozen_string_literal: true
def background_participant
  Participant.new(
    participant: ENV['PTBackground_Email'],
    password: ENV['PTBackground_Password']
  )
end

def think
  Participants::Think.new
end

def app_background_1
  Participants::IncentivesModules::Background.new(image: 'vine')
end

def app_background_2
  Participants::IncentivesModules::Background.new(image: 'rainbow')
end

def bkgd_pt_profile
  Participants::SocialNetworkingModules::Profile.new(
    display_name: 'participant_background'
  )
end
