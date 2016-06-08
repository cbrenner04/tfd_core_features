# frozen_string_literal: true
# filename: ./spec/support/particiapnts/do_helper.rb

require './lib/pages/participants/do'
require './lib/pages/participants/social_networking'
Dir['./lib/pages/participants/do_modules/*.rb'].each { |file| require file }

def do_tool
  @do_tool ||= Participants::DoTool.new
end

def awareness
  @awareness ||= Participants::DoModules::Awareness.new(start_time: Time.now)
end

def social_networking
  @social_networking ||= Participants::SocialNetworking.new
end

def awareness_7a_to_10p
  @awareness_7a_to_10p ||= Participants::DoModules::Awareness.new(
    start_time: "#{week_day(today.prev_day)} 7 AM",
    end_time: "#{week_day(today.prev_day)} 10 PM",
    num_fields: 0..14,
    activity: ['Get ready for work', 'Travel to work', 'Work', 'Work', 'Work',
               'Work', 'Work', 'Work', 'Work', 'Work', 'Travel from work',
               'Eat dinner', 'Watch TV', 'read', 'Get ready for bed'],
    pleasure: [6, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 8, 9, 9, 2],
    accomplishment: [7, 5, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 3, 3, 3],
    count: [17, 5, 5]
  )
end

def awareness_11p_to_1a
  @awareness_11p_to_1a ||= Participants::DoModules::Awareness.new(
    start_time: "#{week_day(today.prev_day)} 11 PM",
    end_time: "#{week_day(today)} 1 AM",
    count: [3, 2, 1]
  )
end

def awareness_complete_entry
  @awareness_complete_entry ||= Participants::DoModules::Awareness.new(
    activity: ['Get ready for work', 'Travel to work', 'Work'],
    num_fields: 0..2,
    pleasure: [6, 2, 8],
    accomplishment: [7, 3, 9],
    count: [4, 3, 3]
  )
end

def planning
  @planning ||= Participants::DoModules::Planning.new(entries: 6)
end

def plan_activity_1
  @plan_activity_1 ||= Participants::DoModules::Planning.new(
    activity: 'New planned activity',
    pleasure: 6,
    accomplishment: 3
  )
end

def plan_activity_2
  @plan_activity_2 ||= Participants::DoModules::Planning.new(
    activity: 'Another planned activity',
    pleasure: 4,
    accomplishment: 8
  )
end

def reviewing
  @reviewing ||= Participants::DoModules::Reviewing.new(
    pleasure: 7,
    accomplishment: 5,
    non_compliance_reason: 'I didn\'t have time'
  )
end

def plan_new_activity
  @plan_new_activity ||= Participants::DoModules::PlanNewActivity.new(
    activity: 'New planned activity',
    pleasure: 4,
    accomplishment: 3
  )
end

def activity_viz
  @activity_viz ||= Participants::DoModules::ActivityVisualization.new(
    activity: 'fake'
  )
end

def edit_activity_viz
  @edit_activity_viz ||= Participants::DoModules::ActivityVisualization.new(
    activity: 'Parkour',
    start_time: Time.now,
    end_time: Time.now + (60 * 60),
    importance: 4,
    fun: 9,
    accomplishment: 7,
    pleasure: 6
  )
end

def planned_activities
  @planned_activity ||= Participants::DoModules::PlannedActivities.new(
    activity: 'Speech'
  )
end
