# filename: ./spec/support/particiapnts/do_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/do'
Dir['./lib/pages/participants/do/*.rb'].each { |file| require file }

def do_tool
  @do_tool ||= Participants::DoTool.new
end

def navigation
  @navigation ||= Participants::Navigation.new
end

def awareness
  @awareness ||= Participants::DoTool::Awareness.new
end

def awareness_7a_to_10p
  @awareness_7a_to_10p ||= Participants::DoTool::Awareness.new(
    start_time: '7 AM',
    end_time: '10 PM',
    num_fields: [0..14],
    activity: ['Get ready for work', 'Travel to work', 'Work', 'Work', 'Work',
               'Work', 'Work', 'Work', 'Work', 'Work', 'Travel from work',
               'Eat dinner', 'Watch TV', 'read', 'Get ready for bed'],
    pleasure: [6, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 8, 9, 9, 2],
    accomplishment: [7, 5, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 3, 3, 3],
    count: [17, 5, 5]
  )
end

def awareness_11p_to_1a
  @awareness_11p_to_1a ||= Participants::DoTool::Awareness.new(
    start_time: '11 PM',
    end_time: '10 AM',
    count: [3, 2, 1]
  )
end

def awareness_complete_entry
  @awareness_complete_entry ||= Participants::DoTool::Awareness.new(
    activity: ['Get ready for work', 'Travel to work', 'Work'],
    num_fields: [0..2],
    pleasure: [6, 2, 8],
    accomplishment: [7, 3, 9],
    count: [4, 3, 3]
  )
end

def planning
  @planning ||= Participants::DoTool::Planning.new(entries: 6)
end

def plan_activity_1
  @plan_activity_1 ||= Participants::DoTool::Planning.new(
    activity: 'New planned activity',
    pleasure: 6,
    accomplishment: 3
  )
end

def plan_activity_2
  @plan_activity_2 ||= Participants::DoTool::Planning.new(
    activity: 'Another planned activity',
    pleasure: 4,
    accomplishment: 8
  )
end

def reviewing
  @reviewing ||= Participants::DoTool::Reviewing.new(
    pleasure: 7,
    accomplishment: 5,
    non_compliance_reason: 'I didn\'t have time'
  )
end

def plan_new_activity
  @plan_new_activity ||= Participants::DoTool::PlanNewActivity.new(
    activity: 'New planned activity',
    pleasure: 4,
    accomplishment: 3
  )
end

def activity_viz
  @activity_vis ||= Participants.DoTool::ActivityVisualization.new(
    prev_day: Date.today - 1,
    activity: 'Parkour',
    start_time: Time.now,
    end_time: Time.now + (60 * 60),
    importance: 4,
    fun: 9,
    accomplishment: 7,
    pleasure: 6
  )
end

def planned_activity
  @planned_activity ||= Participants::DoTool::PlannedActivities.new(
    activity: 'Speech'
  )
end
