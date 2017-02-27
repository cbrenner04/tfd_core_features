# frozen_string_literal: true
require_relative '../pages/time_formats'
include TimeFormats

def participant_navigation
  Participants::Navigation.new
end

def do_tool
  Participants::DoTool.new
end

def feel
  Participants::Feel.new
end

def think
  Participants::Think.new
end

def social_networking
  Participants::SocialNetworking.new
end

def activity_viz
  Participants::DoModules::ActivityVisualization.new(activity: 'generic')
end

def awareness
  Participants::DoModules::Awareness.new
end

def planning
  Participants::DoModules::Planning.new
end

def plan_new_activity
  Participants::DoModules::PlanNewActivity.new
end

def planned_activities
  Participants::DoModules::PlannedActivities.new
end

def reviewing
  Participants::DoModules::Reviewing.new
end

def recent_mood_and_emotions
  Participants::FeelModules::RecentMoodsEmotions.new
end

def tracking_mood
  Participants::FeelModules::TrackingMood.new
end

def tracking_mood_and_emotions
  Participants::FeelModules::TrackingMoodEmotions.new
end

def add_new_thought
  Participants::ThinkModules::AddNewThought.new
end

def identifying
  Participants::ThinkModules::Identifying.new
end

def patterns
  Participants::ThinkModules::Patterns.new
end

def reshape
  Participants::ThinkModules::Reshape.new
end

def participant_1
  Participant.new(
    participant: ENV['Participant_Email'],
    password: ENV['Participant_Password']
  )
end

def participant_3
  Participant.new(
    participant: ENV['Alt_Participant_Email'],
    password: ENV['Alt_Participant_Password']
  )
end

def participant_5
  Participant.new(
    participant: ENV['Participant_5_Email'],
    password: ENV['Participant_5_Password']
  )
end

def nonsocial_pt
  Participant.new(
    participant: ENV['NS_Participant_Email'],
    password: ENV['NS_Participant_Password']
  )
end

def marigold_participant
  Participant.new(
    participant: ENV['Marigold_Participant_Email'],
    password: ENV['Marigold_Participant_Password']
  )
end

def marigold_2
  Participant.new(
    participant: ENV['marigold_2_email'],
    password: ENV['marigold_2_Password']
  )
end

def marigold_3
  Participant.new(
    participant: ENV['marigold_3_email'],
    password: ENV['marigold_3_Password']
  )
end

def participant_marigold_4
  Participant.new(
    participant: ENV['marigold_4_email'],
    password: ENV['marigold_4_Password']
  )
end

def marigold_5
  Participant.new(
    participant: ENV['marigold_5_email'],
    password: ENV['marigold_5_Password']
  )
end

def marigold_6
  Participant.new(
    participant: ENV['marigold_6_email'],
    password: ENV['marigold_6_Password']
  )
end

def marigold_7
  Participant.new(
    participant: ENV['marigold_7_email'],
    password: ENV['marigold_7_Password']
  )
end

def marigold_8
  Participant.new(
    participant: ENV['marigold_8_email'],
    password: ENV['marigold_8_Password']
  )
end
