# filename: ./spec/support/participants/shared_items_helper.rb

require './lib/pages/participants/do'
require './lib/pages/participants/do_modules/awareness'
require './lib/pages/participants/do_modules/planning'
require './lib/pages/participants/do_modules/plan_new_activity'
require './lib/pages/participants/do_modules/reviewing'
require './lib/pages/participants/learn'
require './lib/pages/participants/relax'
require './lib/pages/participants/social_networking'
require './lib/pages/participants/think'
require './lib/pages/participants/think_modules/identifying'
require './lib/pages/participants/think_modules/add_new_thought'
require './lib/pages/participants/think_modules/patterns'
require './lib/pages/participants/think_modules/reshape'

def think
  @think ||= Participants::Think.new
end

def do_tool
  @do_tool ||= Participants::DoTool.new
end

def social_networking
  @social_networking ||= Participants::SocialNetworking.new
end

def pt_1_identify_thought_1
  @pt_1_identify_thought_1 ||= Participants::ThinkModules::Identifying.new(
    feed_item: 'Public thought 1',
    timestamp: "Today at #{Time.now.strftime('%l')}"
  )
end

def pt_1_identify_thought_2
  @pt_1_identify_thought_2 ||= Participants::ThinkModules::Identifying.new(
    feed_item: 'Private thought 1'
  )
end

def pt_1_add_new_thought_1
  @pt_1_add_new_thought_1 ||= Participants::ThinkModules::AddNewThought.new(
    thought: 'Public thought 3',
    pattern: 'Magnification or Catastrophizing',
    challenge: 'Testing challenge thought',
    action: 'Testing act-as-if action',
    timestamp: "Today at #{Time.now.strftime('%-l')}"
  )
end

def pt_1_add_new_thought_2
  @pt_1_add_new_thought_2 ||= Participants::ThinkModules::AddNewThought.new(
    thought: 'Private thought 2',
    pattern: 'Magnification or Catastrophizing',
    challenge: 'Testing challenge thought',
    action: 'Testing act-as-if action'
  )
end

def pt_1_planning_1
  @pt_1_planning_1 ||= Participants::DoModules::Planning.new(
    activity: 'New public activity',
    pleasure: 6,
    accomplishment: 3,
    timestamp: "Today at #{Time.now.strftime('%l')}"
  )
end

def pt_1_planning_2
  @pt_1_planning_2 ||= Participants::DoModules::Planning.new(
    activity: 'New private activity',
    pleasure: 4,
    accomplishment: 8
  )
end

def pt_1_plan_new_1
  @pt_1_plan_new_1 ||= Participants::DoModules::PlanNewActivity.new(
    activity: 'New public activity 2',
    pleasure: 4,
    accomplishment: 3,
    timestamp: "Today at #{Time.now.strftime('%l')}"
  )
end

def pt_1_plan_new_2
  @pt_1_plan_new_2 ||= Participants::DoModules::PlanNewActivity.new(
    activity: 'New private activity 2',
    pleasure: 4,
    accomplishment: 3
  )
end

def ns_pt_identifying
  @ns_pt_identifying ||= Participants::ThinkModules::Identifying.new(
    first_thought: 'fake'
  )
end

def ns_pt_add_new_thought
  @ns_pt_add_new_thought ||= Participants::ThinkModules::Identifying.new(
    thought: 'fake'
  )
end

def ns_pt_awareness
  @ns_pt_awareness ||= Participants::DoModules::Awareness.new(
    start_time: "#{week_day(today)} 4 AM",
    end_time: "#{week_day(today)} 7 AM"
  )
end

def ns_pt_planning
  @ns_pt_planning ||= Participants::DoModules::Planning.new(
    activity: 'fake'
  )
end

def ns_pt_add_new_activity
  @ns_pt_add_new_activity ||= Participants::DoModules::PlanNewActivity.new(
    activity: 'fake'
  )
end

def pt_5_reviewing_1
  @pt_5_reviewing_1 ||= Participants::DoModules::Reviewing.new(
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
  @pt_5_reviewing_2 ||= Participants::DoModules::Reviewing.new(
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
  @pt_5_pattern ||= Participants::ThinkModules::Patterns.new(
    thought: 'ARG!',
    pattern: 'Personalization'
  )
end

def pt_5_reshape
  @pt_5_reshape ||= Participants::ThinkModules::Reshape.new(
    challenge: 'Example challenge',
    action: 'Example act-as-if',
    thought: 'I am useless',
    pattern: 'Labeling and Mislabeling'
  )
end
