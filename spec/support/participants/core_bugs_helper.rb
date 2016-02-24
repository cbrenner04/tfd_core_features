# filename: ./spec/support/participants/core_bugs_helper.rb

require './lib/pages/participants'
require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'
require './lib/pages/participants/do'
require './lib/pages/participants/do/planning'
require './lib/pages/participants/do/plan_new_activity'
require './lib/pages/participants/do/awareness'
require './lib/pages/participants/do/activity_visualization'
require './lib/pages/participants/feel'
require './lib/pages/participants/feel/recent_mood_emotions'
require './lib/pages/participants/feel/tracking_mood_emotions'

def navigation
  @navigation ||= Participants::Navigation.new
end

def social_networking
  @social_networking ||= Participants::SocialNetworking.new
end

def do_tool
  @do_tool ||= Participants::DoTool.new
end

def planning
  @planning ||= Participants::DoTool::Planning.new(activity: 'fake')
end

def participant_2_so1
  @participant_2_so1 ||= Participants.new(
    participant: ENV['Participant_2_Email'],
    old_participant: 'participant1',
    password: ENV['Participant_Password'],
    display_name: 'participant2'
  )
end

def first_planned_activity
  @first_planned_activity ||= Participants::DoTool::Planning.new(
    activity: 'New planned activity',
    pleasure: 6,
    accomplishment: 3
  )
end

def second_planned_activity
  @second_planned_activity ||= Participants::DoTool::Planning.new(
    activity: 'Another planned activity',
    pleasure: 4,
    accomplishment: 8
  )
end

def plan_new_activity
  @plan_new_activity ||= Participants::DoTool::PlanNewActivity.new(
    activity: 'New planned activity',
    pleasure: 4,
    accomplishment: 3
  )
end

def awareness
  @awareness ||= Participants::DoTool::Awareness.new(
    start_time: "#{Date.today.strftime('%a')} 2 AM",
    end_time: "#{Date.today.strftime('%a')} 3 AM",
    activity: 'Sleep',
    pleasure: 9,
    accomplishment: 3
  )
end

def activity_viz
  @activity_viz ||= Participants::DoTool::ActivityVisualization.new(
    prev_day: Date.today - 1
  )
end

def feel
  @feel ||= Participants::Feel.new
end

def recent_moods_emotions
  @recent_moods_emotions ||= Participants::Feel::RecentMoodsEmotions.new(
    mood_count: 1
  )
end

def tracking_mood_emotions
  @tracking_mood_emotions ||= Participants::Feel::TrackingMoodEmotions.new(
    mood_rating: 6,
    emotion: 'anxious',
    emotion_type: 'negative',
    emotion_rating: 4
  )
end
