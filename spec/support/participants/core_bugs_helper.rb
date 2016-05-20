# filename: ./spec/support/participants/core_bugs_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/social_networking'
require './lib/pages/participants/do'
require './lib/pages/participants/do_modules/planning'
require './lib/pages/participants/do_modules/plan_new_activity'
require './lib/pages/participants/do_modules/awareness'
require './lib/pages/participants/do_modules/activity_visualization'
require './lib/pages/participants/feel'
require './lib/pages/participants/feel_modules/recent_mood_emotions'
require './lib/pages/participants/feel_modules/tracking_mood_emotions'

def social_networking
  @social_networking ||= Participants::SocialNetworking.new
end

def do_tool
  @do_tool ||= Participants::DoTool.new
end

def planning
  @planning ||= Participants::DoModules::Planning.new(activity: 'fake')
end

def participant_2
  @participant_2 ||= Participant.new(
    participant: ENV['Participant_2_Email'],
    password: ENV['Participant_Password']
  )
end

def first_planned_activity
  @first_planned_activity ||= Participants::DoModules::Planning.new(
    activity: 'New planned activity',
    pleasure: 6,
    accomplishment: 3
  )
end

def second_planned_activity
  @second_planned_activity ||= Participants::DoModules::Planning.new(
    activity: 'Another planned activity',
    pleasure: 4,
    accomplishment: 8
  )
end

def plan_new_activity
  @plan_new_activity ||= Participants::DoModules::PlanNewActivity.new(
    activity: 'New planned activity',
    pleasure: 4,
    accomplishment: 3
  )
end

def awareness
  @awareness ||= Participants::DoModules::Awareness.new(
    start_time: "#{Date.today.strftime('%a')} 2 AM",
    end_time: "#{Date.today.strftime('%a')} 3 AM",
    activity: 'Sleep',
    pleasure: 9,
    accomplishment: 3
  )
end

def activity_viz
  @activity_viz ||= Participants::DoModules::ActivityVisualization.new(
    prev_day: Date.today - 1
  )
end

def feel
  @feel ||= Participants::Feel.new
end

def recent_moods_emotions
  @recent_moods_emotions ||= Participants::FeelModules::RecentMoodsEmotions.new(
    mood_count: 1
  )
end

def tracking_mood_emotions
  @tracking_mood_emotions ||=
    Participants::FeelModules::TrackingMoodEmotions.new(
      mood_rating: 6,
      emotion: 'anxious',
      emotion_type: 'negative',
      emotion_rating: 4
    )
end
