# filename: ./spec/support/participants/communal_incentives_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/navigation'
require './lib/pages/participants/incentives'
require './lib/pages/participants/social_networking/comment'

def navigation
  @navigation ||= Participants::Navigation.new
end

def participant_3_sob
  @participant_3_sob ||= Participants.new(
    participant: ENV['Alt_Participant_Email'],
    old_participant: 'participant_background',
    password: ENV['Alt_Participant_Password']
  )
end

def incomplete_communal_incentive
  @incomplete_communal_incentive ||= Participants::Incentives.new(
    incentive: 'comment on 3 feed items',
    completed: 6,
    total: 7,
    image: 'flower2',
    pt_list_item: 2
  )
end

def complete_communal_incentive
  @complete_communal_incentive ||= Participants::Incentives.new(
    incentive: 'comment on 3 feed items',
    completed: 7,
    total: 7,
    image: 'flower2',
    plot: 'communal',
    pt_list_item: 2,
    date: Time.now.strftime('%b %d %Y %I')
  )
end

def pt_3_comment_1
  @pt_3_comment_1 ||= Participants::SocialNetworking::Comment.new(
    feed_item: 'Did Not Complete a Goal: p2 gamma',
    comment: 'great'
  )
end

def pt_3_comment_2
  @pt_3_comment_2 ||= Participants::SocialNetworking::Comment.new(
    feed_item: 'Did Not Complete a Goal: p2 alpha',
    comment: 'cool'
  )
end

def pt_3_comment_3
  @pt_3_comment_3 ||= Participants::SocialNetworking::Comment.new(
    feed_item: 'said what about Bob?',
    comment: 'wow'
  )
end
