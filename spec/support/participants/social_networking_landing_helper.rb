# filename: ./spec/support/participants/social_networking_landing_helper.rb

require './lib/pages/participants/do'
require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'
require './lib/pages/participants/think/thoughts'
Dir['./lib/pages/participants/social_networking/*.rb'].each { |f| require f }

def do_tool
  @do_tool ||= Participants::DoTool.new
end

def navigation
  @navigation ||= Participants::Navigation.new
end

def social_networking
  @social_networking || Participants::SocialNetworking.new
end

def thoughts
  @thoughts ||= Participants::Think::Thoughts.new(thought: 'fake')
end

def participant_1_profile
  @participant_1_profile ||= Participants::SocialNetworking::Profile.new(
    answer: ['Running', 'Blue', 'Mineral', 'Group 1'],
    question: 'Group 1 profile question',
    display_name: 'participant1'
  )
end

def participant_1_to_do_list
  @participant_1_to_do_list ||= Participants::SocialNetworking::ToDoList.new(
    task: 'THINK: Thought Distortions'
  )
end

def pt_1_on_the_mind
  @pt_1_on_the_mind ||= Participants::SocialNetworking::OnTheMindStatement.new(
    statement: 'I\'m feeling happy!'
  )
end

def participant_5_profile
  @participant_5_profile ||= Participants::SocialNetworking::Profile.new(
    display_name: 'participant5'
  )
end
