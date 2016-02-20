# filename: ./spec/support/do_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/do'
require './lib/pages/participants/navigation'
require './lib/pages/participants/do/awareness'
require './lib/pages/participants/do/planning'
require './lib/pages/participants/do/reviewing'
require './lib/pages/participants/do/plan_new_activity'
require './lib/pages/participants/do/activity_visualization'

def participant_1
  @participant_1 ||= Participants.new(
    participant: ENV['Participant_Email'],
    old_participant: 'participant1',
    password: ENV['Participant_Password']
  )
end

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

def planning
  @planning ||= Participants::DoTool::Planning.new(
    first_activity: 'New planned activity',
    first_pleasure: 6,
    first_accomplishment: 3,
    second_activity: 'Another planned activity',
    second_pleasure: 4,
    second_accomplishment: 8,
    entries: 6
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
  @activity_vis ||= Participants.DoTool.ActivityVisualization.new
end
