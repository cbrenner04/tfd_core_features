# filename: ./spec/support/participants/goal_helper.rb

require './lib/pages/participants/social_networking/achieve'

def achieve
  @achieve ||= Participants::SocialNetworking::Achieve.new(
    goal: 'fake'
  )
end

def eat_pizza_goal
  @eat_pizza_goal ||= Participants::SocialNetworking::Achieve.new(
    goal: 'eat a whole pizza',
    due_date: Date.today + 365,
    status: 'Created'
  )
end

def goal_due_yesterday
  @goal_due_yesterday ||= Participants::SocialNetworking::Achieve.new(
    goal: 'due yesterday'
  )
end

def goal_p1_alpha
  @goal_p1_alpha ||= Participants::SocialNetworking::Achieve.new(
    goal: 'p1 alpha',
    status: 'Completed'
  )
end

def goal_p1_gamma
  @goal_p1_gamma ||= Participants::SocialNetworking::Achieve.new(
    goal: 'p1 gamma'
  )
end

def goal_participant_1
  @goal_participant_1 ||= Participants.new(
    participant: ENV['PTGoal1_Email'],
    password: ENV['PTGoal1_Password']
  )
end

def goal_participant_2
  @goal_participant_2 ||= Participants.new(
    participant: ENV['PTGoal2_Email'],
    password: ENV['PTGoal2_Password']
  )
end

def goal_participant_3
  @goal_participant_3 ||= Participants.new(
    participant: ENV['PTGoal3_Email'],
    password: ENV['PTGoal3_Password']
  )
end

def goal_participant_4
  @goal_participant_4 ||= Participants.new(
    participant: ENV['PTGoal4_Email'],
    password: ENV['PTGoal4_Password']
  )
end

def completer_participant
  @completer_participant ||= Participants.new(
    participant: ENV['Completed_Pt_Email'],
    password: ENV['Completed_Pt_Password']
  )
end
