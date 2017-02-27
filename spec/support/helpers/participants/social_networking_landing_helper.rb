# frozen_string_literal: true
def participant_4
  Participant.new(
    participant: ENV['Participant_4_Email'],
    password: ENV['Participant_4_Password']
  )
end

def sn_landing_page_incentives
  Participants::Incentives.new(date: Date.today)
end

def do_tool
  Participants::DoTool.new
end

def social_networking
  Participants::SocialNetworking.new
end

def think
  Participants::Think.new
end

def to_do_list
  Participants::SocialNetworkingModules::ToDoList.new(task: 'fake')
end

def participant_1_profile_1
  Participants::SocialNetworkingModules::Profile.new(
    answer: ['Running', 'Blue', 'Mineral', 'Group 1'],
    question: 'Group 1 profile question',
    display_name: 'participant1'
  )
end

def participant_1_profile_2
  Participants::SocialNetworkingModules::Profile.new(
    display_name: 'participant1'
  )
end

def participant_1_profile_3
  Participants::SocialNetworkingModules::Profile.new(
    other_pt: 'participant5'
  )
end

def participant_1_to_do_list
  Participants::SocialNetworkingModules::ToDoList.new(
    task: 'THINK: Thought Distortions'
  )
end

def participant_4_to_do_list
  Participants::SocialNetworkingModules::ToDoList.new(
    task: 'Create a Profile'
  )
end

def pt_1_on_the_mind
  Participants::SocialNetworkingModules::OnTheMindStatement.new(
    statement: 'I\'m feeling happy!'
  )
end

def participant_4_profile
  Participants::SocialNetworkingModules::Profile.new(answer: 'Running')
end

def participant_5_profile
  Participants::SocialNetworkingModules::Profile.new(
    display_name: 'participant5'
  )
end

def moderator_profile
  Participants::SocialNetworkingModules::Profile.new(
    display_name: 'ThinkFeelDo',
    last_seen: ''
  )
end

def incomplete_goal
  Participants::SocialNetworkingModules::Achieve.new(
    status: 'Did Not Complete',
    goal: 'due yesterday'
  )
end

def two_day_old_incomplete_goal
  Participants::SocialNetworkingModules::Achieve.new(
    status: 'Did Not Complete',
    goal: 'due two days ago'
  )
end

def goal_due_two_days_ago
  Participants::SocialNetworkingModules::Achieve.new(
    status: '',
    goal: 'due two days ago'
  )
end

def goal_p1_alpha
  Participants::SocialNetworkingModules::Achieve.new(
    goal: 'p1 alpha',
    due_date: today
  )
end

def goal_p2_alpha
  Participants::SocialNetworkingModules::Achieve.new(
    goal: 'p2 alpha',
    due_date: today - 1
  )
end

def philly_feed_item
  Participants::SocialNetworkingModules::Like.new(
    feed_item: 'said it\'s always sunny in Philadelphia',
    participant: 'participant1'
  )
end

def nudge_feed_item
  Participants::SocialNetworkingModules::Comment.new(
    feed_item: 'nudged participant1',
    comment: 'Sweet Dude!',
    participant: 'participant1'
  )
end

def thought_viz
  Participants::ThinkModules::ThoughtVisualization.new(
    pattern: 'Magnification or Catastro...',
    detail_pattern: 'Magnification or Catastro...',
    thought: 'No one likes me'
  )
end
