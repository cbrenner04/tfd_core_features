# filename: ./spec/support/participants/shared_items_helper.rb

require './lib/pages/participants/do'
require './lib/pages/participants/do/awareness'
require './lib/pages/participants/do/planning'
require './lib/pages/participants/do/plan_new_activity'
require './lib/pages/participants/do/reviewing'
require './lib/pages/participants/think'
require './lib/pages/participants/think/identifying'
require './lib/pages/participants/think/add_new_thought'
require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'

def think
  @think ||= Participants::Think.new
end

def do_tool
  @do_tool ||= Participants::DoTool.new
end

def navigation
  @navigation ||= Participants::Navigation.new
end

def social_networking
  @social_networking ||= Participants::SocialNetworking.new
end

def pt_1_identify_thought_1
  @pt_1_identify_thought_1 ||= Participants::Think::Identifying.new(
    feed_item: 'Public thought 1',
    timestamp: "Today at #{Time.now.strftime('%l')}"
  )
end

def pt_1_identify_thought_2
  @pt_1_identify_thought_2 ||= Participants::Think::Identifying.new(
    feed_item: 'Private thought 1'
  )
end

def pt_1_add_new_thought_1
  @pt_1_add_new_thought_1 ||= Participants::Think::AddNewThought.new(
    thought: 'Public thought 3',
    pattern: 'Magnification or Catastrophizing',
    challenge: 'Testing challenge thought',
    action: 'Testing act-as-if action',
    timestamp: "Today at #{Time.now.strftime('%l')}"
  )
end

def pt_1_add_new_thought_2
  @pt_1_add_new_thought_2 ||= Participants::Think::AddNewThought.new(
    thought: 'Private thought 2',
    pattern: 'Magnification or Catastrophizing',
    challenge: 'Testing challenge thought',
    action: 'Testing act-as-if action'
  )
end

def pt_1_planning_1
  @pt_1_planning_1 ||= Participaants::DoTool::Planning.new(
    activity: 'New public activity',
    pleasure: 6,
    accomplishment: 3,
    timestamp: "Today at #{Time.now.strftime('%l')}"
  )
end

def pt_1_planning_2
  @pt_1_planning_2 ||= Participaants::DoTool::Planning.new(
    activity: 'New private activity',
    pleasure: 4,
    accomplishment: 8
  )
end

def pt_1_plan_new_1
  @pt_1_plan_new_1 ||= Participants::DoTool::PlanNewActivity.new(
    activity: 'New public activity 2',
    pleasure: 4,
    accomplishment: 3,
    timestamp: "Today at #{Time.now.strftime('%l')}"
  )
end

def pt_1_plan_new_2
  @pt_1_plan_new_2 ||= Participants::DoTool::PlanNewActivity.new(
    activity: 'New private activity 2',
    pleasure: 4,
    accomplishment: 3
  )
end

def ns_pt_identifying
  @ns_pt_identifying ||= Participants::Think::Identifying.new(
    first_thought: 'fake'
  )
end

def ns_pt_add_new_thought
  @ns_pt_add_new_thought ||= Participants::Think::Identifying.new(
    thought: 'fake'
  )
end

def ns_pt_awareness
  @ns_pt_awareness ||= Participants::DoTool::Awareness.new(
    start_time: "#{Date.today.strftime('%a')} 4 AM",
    end_time: "#{Date.today.strftime('%a')} 7 AM"
  )
end

def ns_pt_planning
  @ns_pt_planning ||= Participants::DoTool::Planning.new(
    activity: 'fake'
  )
end

def ns_pt_add_new_activity
  @ns_pt_add_new_activity ||= Participants::DoTool::PlanNewActivity.new(
    activity: 'fake'
  )
end

def pt_5_reviewing
  @pt_5_reviewing ||= Participants::DoTool::Reviewing.new(
    activity: 'Parkour',
    start_time: Time.now - (60 * 60 * 24),
    end_time: Time.now - (60 * 60 * 23),
    pleasure: 7,
    accomplishment: 5,
    non_compliance_reason: 'I didn\'t have time',
    predicted_pleasure: 9,
    predicted_accomplishment: 4
  )
end

def pt_5_reviewing_2
  @pt_5_reviewing_2 ||= Participants::DoTool::Reviewing.new(
    activity: 'Loving'
  )
end
