# frozen_string_literal: true
def incomplete_communal_incentive
  Participants::Incentives.new(
    incentive: 'comment on 3 feed items',
    completed: 6,
    total: 7,
    image: 'flower2',
    pt_list_item: 2
  )
end

def complete_communal_incentive
  Participants::Incentives.new(
    incentive: 'comment on 3 feed items',
    completed: 7,
    total: 7,
    image: 'flower2',
    plot: 'communal',
    pt_list_item: 2,
    date: long_date_with_hour(Time.now)
  )
end

def partial_communal_incentive_1
  Participants::Incentives.new(
    incentive: 'comment on 1 feed items',
    completed: 2,
    total: 7,
    image: 'flower4',
    plot: 'communal'
  )
end

def partial_communal_incentive_2
  Participants::Incentives.new(
    incentive: 'comment on 1 feed items',
    completed: 3,
    total: 7,
    image: 'flower4',
    plot: 'communal',
    pt_list_item: 0,
    date: long_date_with_hour(Time.now)
  )
end

def pt_3_comment_1
  Participants::SocialNetworkingModules::Comment.new(
    feed_item: 'Did Not Complete a Goal: p2 gamma',
    comment: 'great'
  )
end

def pt_3_comment_2
  Participants::SocialNetworkingModules::Comment.new(
    feed_item: 'Did Not Complete a Goal: p2 alpha',
    comment: 'cool'
  )
end

def pt_3_comment_3
  Participants::SocialNetworkingModules::Comment.new(
    feed_item: 'said what about Bob?',
    comment: 'wow'
  )
end

def pt_1_comment_1
  Participants::SocialNetworkingModules::Comment.new(
    feed_item: 'Did Not Complete a Goal: p2 gamma',
    comment: 'great'
  )
end
