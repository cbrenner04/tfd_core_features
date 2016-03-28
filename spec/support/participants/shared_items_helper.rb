# filename: ./spec/support/participants/shared_items_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/do'
require './lib/pages/participants/do/awareness'
require './lib/pages/participants/do/planning'
require './lib/pages/participants/do/plan_new_activity'
require './lib/pages/participants/do/reviewing'
require './lib/pages/participants/learn'
require './lib/pages/participants/relax'
require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'
require './lib/pages/participants/think'
require './lib/pages/participants/think/identifying'
require './lib/pages/participants/think/add_new_thought'
require './lib/pages/participants/think/patterns'
require './lib/pages/participants/think/reshape'

def participant_1_somc
  @participant_1_somc ||= Participants.new(
    participant: ENV['Participant_Email'],
    old_participant: 'mobilecompleter',
    password: ENV['Participant_Password']
  )
end

def participant_5_sons
  @participant_5_sons ||= Participants.new(
    participant: ENV['Participant_5_Email'],
    old_participant: 'nonsocialpt',
    password: ENV['Participant_5_Password'],
    display_name: 'participant5'
  )
end

def nonsocial_pt_sons
  @nonsocial_pt ||= Participants.new(
    participant: ENV['NS_Participant_Email'],
    old_participant: 'nonsocialpt',
    password: ENV['NS_Participant_Password'],
    display_name: 'nonsocialpt'
  )
end

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
    timestamp: "Today at #{Time.now.strftime('%-l')}"
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
  @pt_1_planning_1 ||= Participants::DoTool::Planning.new(
    activity: 'New public activity',
    pleasure: 6,
    accomplishment: 3,
    timestamp: "Today at #{Time.now.strftime('%l')}"
  )
end

def pt_1_planning_2
  @pt_1_planning_2 ||= Participants::DoTool::Planning.new(
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

def pt_5_reviewing_1
  @pt_5_reviewing_1 ||= Participants::DoTool::Reviewing.new(
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

def learn_2
  @learn_2 ||= Participants::Learn.new(lesson_title: 'fake')
end

def pt_5_lesson
  @pt_5_lesson ||= Participants::Learn.new(
    lesson_title: 'Do - Awareness Introduction'
  )
end

def relax
  @relax ||= Participants::Relax.new(feed_item: 'Audio!')
end

def pt_5_pattern
  @pt_5_pattern ||= Participants::Think::Patterns.new(
    thought: 'ARG!',
    pattern: 'Personalization'
  )
end

def pt_5_reshape
  @pt_5_reshape ||= Participants::Think::Reshape.new(
    challenge: 'Example challenge',
    action: 'Example act-as-if',
    thought: 'I am useless',
    pattern: 'Labeling and Mislabeling'
  )
end
