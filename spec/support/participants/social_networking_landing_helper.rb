# filename: ./spec/support/participants/social_networking_landing_helper.rb

require './lib/pages/participants/do'
require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'
require './lib/pages/participants/think'
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

def think
  @think ||= Participants::Think.new
end

def to_do_list
  @to_do_list ||= Participants::SocialNetworking::ToDoList.new(task: 'fake')
end

def participant_1_profile_1
  @participant_1_profile_1 ||= Participants::SocialNetworking::Profile.new(
    answer: ['Running', 'Blue', 'Mineral', 'Group 1'],
    question: 'Group 1 profile question',
    display_name: 'participant1'
  )
end

def participant_1_profile_2
  @participant_1_profile_2 ||= Participants::SocialNetworking::Profile.new(
    display_name: 'participant1'
  )
end

def participant_1_profile_3
  @participant_1_profile_3 ||= Participants::SocialNetworking::Profile.new(
    other_pt: 'participant5'
  )
end

def participant_1_to_do_list
  @participant_1_to_do_list ||= Participants::SocialNetworking::ToDoList.new(
    task: 'THINK: Thought Distortions'
  )
end

def participant_4_to_do_list
  @participant_4_to_do_list ||= Participants::SocialNetworking::ToDoList.new(
    task: 'Create a Profile'
  )
end

def pt_1_on_the_mind
  @pt_1_on_the_mind ||= Participants::SocialNetworking::OnTheMindStatement.new(
    statement: 'I\'m feeling happy!'
  )
end

def participant_4_profile
  @participant_4_profile ||= Participants::SocialNetworking::Profile.new(
    answer: 'Running'
  )
end

def participant_5_profile
  @participant_5_profile ||= Participants::SocialNetworking::Profile.new(
    display_name: 'participant5'
  )
end

def moderator_profile
  @moderator_profile ||= Participants::SocialNetworking::Profile.new(
    display_name: 'ThinkFeelDo',
    last_seen: ''
  )
end

def incomplete_goal
  @incomplete_goal ||= Participants::SocialNetworking::Achieve.new(
    status: 'Did Not Complete',
    goal: 'due yesterday'
  )
end

def two_day_old_incomplete_goal
  @two_day_old_incomplete_goal ||= Participants::SocialNetworking::Achieve.new(
    status: 'Did Not Complete',
    goal: 'due two days ago'
  )
end

def goal_due_two_days_ago
  @goal_due_two_days_ago ||= Participants::SocialNetworking::Achieve.new(
    status: '',
    goal: 'due two days ago'
  )
end

def goal_p1_alpha
  @goal_p1_alpha ||= Participants::SocialNetworking::Achieve.new(
    goal: 'p1 alpha',
    due_date: Date.today
  )
end

def philly_feed_item
  @philly_feed_item ||= Participants::SocialNetworking::Like.new(
    feed_item: 'said it\'s always sunny in Philadelphia',
    participant: 'participant1'
  )
end

def nudge_feed_item
  @nudge_feed_item ||= Participants::SocialNetworking::Comment.new(
    feed_item: 'nudged participant1',
    comment: 'Sweet Dude!',
    participant: 'participant1'
  )
end

def thought_viz
  @thought_viz ||= Participants::Think::ThoughtVisualization.new(
    thought: 'fake'
  )
end
