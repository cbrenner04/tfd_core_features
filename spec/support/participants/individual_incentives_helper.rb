# frozen_string_literal: true
# filename: ./spec/support/participants/individual_incentives_helper.rb

require './lib/pages/participants/incentives'
require './lib/pages/participants/social_networking_modules/profile'
require './lib/pages/participants/social_networking_modules/like'
require './lib/pages/participants/social_networking_modules/achieve'

def participant_3_profile
  @participant_3_profile ||= Participants::SocialNetworkingModules::Profile.new(
    display_name: 'participant3'
  )
end

def pt_3_incentive_1
  @pt_3_incentive_1 ||= Participants::Incentives.new(
    incentive: 'like 3 feed items',
    completed: 0,
    total: 3,
    image: 'flower1'
  )
end

def pt_3_incentive_2
  @pt_3_incentive_2 ||= Participants::Incentives.new(
    incentive: 'like 3 feed items',
    completed: 1,
    total: 3,
    image: 'flower1'
  )
end

def pt_3_incentive_3
  @pt_3_incentive_3 ||= Participants::Incentives.new(
    incentive: 'like 3 feed items',
    completed: 3,
    total: 3,
    image: 'flower1',
    plot: 'individual'
  )
end

def pt_3_repeatable_incentive_1
  @pt_3_repeatable_incentive_1 ||= Participants::Incentives.new(
    incentive: 'create a goal',
    completed: 1,
    image: 'flower3',
    plot: 'individual'
  )
end

def pt_3_repeatable_incentive_2
  @pt_3_repeatable_incentive_2 ||= Participants::Incentives.new(
    incentive: 'create a goal',
    completed: 2,
    plot: 'individual',
    flower_count: 3
  )
end

def pt_3_behavior_1
  @pt_3_behavior_1 ||= Participants::Incentives.new(
    pt_list_item: 0,
    date: long_date_with_hour(Time.now)
  )
end

def pt_3_behavior_2
  @pt_3_behavior_2 ||= Participants::Incentives.new(
    pt_list_item: 1,
    date: long_date_with_hour(Time.now)
  )
end

def pt_3_behavior_3
  @pt_3_behavior_3 ||= Participants::Incentives.new(
    pt_list_item: 2,
    date: long_date_with_hour(Time.now)
  )
end

def pt_3_like_1
  @pt_3_like_1 ||= Participants::SocialNetworkingModules::Like.new(
    feed_item: 'Did Not Complete a Goal: p2 alpha'
  )
end

def pt_3_like_2
  @pt_3_like_2 ||= Participants::SocialNetworkingModules::Like.new(
    feed_item: 'Did Not Complete a Goal: p2 gamma'
  )
end

def pt_3_like_3
  @pt_3_like_3 ||= Participants::SocialNetworkingModules::Like.new(
    feed_item: 'said what about Bob?'
  )
end

def pt_3_goal
  @pt_3_goal ||= Participants::SocialNetworkingModules::Achieve.new(
    goal: 'do something fun'
  )
end

def participant_2_incentive
  @participant_2_incentive ||= Participants::Incentives.new(
    incentive: 'like 3 feed items',
    completed: 3,
    total: 3,
    image: 'flower1',
    plot: 'individual',
    participant: 'participant2'
  )
end

def pt_2_behavior_1
  @pt_2_behavior_1 ||= Participants::Incentives.new(
    pt_list_item: 0,
    date: long_date_with_hour(Time.now)
  )
end

def pt_2_behavior_2
  @pt_2_behavior_2 ||= Participants::Incentives.new(
    pt_list_item: 1,
    date: long_date_with_hour(Time.now)
  )
end

def pt_2_behavior_3
  @pt_2_behavior_3 ||= Participants::Incentives.new(
    pt_list_item: 2,
    date: long_date_with_hour(Time.now)
  )
end
