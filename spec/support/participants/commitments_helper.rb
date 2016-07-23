# frozen_string_literal: true

require './lib/pages/participants'
require './lib/pages/participants/commitments'
require './lib/pages/participants/commitments_modules/' \
        'positive_events_and_gratitude'
require './lib/pages/participants/commitments_modules/activation'
require './lib/pages/participants/practice_modules/activation'
require './lib/pages/participants/practice_modules/positive_events'
require './lib/pages/participants/skills'

def participant_marigold_4
  @participant_marigold_4 ||= Participant.new(
    participant: ENV['Marigold_4_Email'],
    password: ENV['Marigold_4_Password']
  )
end

def commitments
  @commitments ||= Participants::Commitments.new
end

def commitments_1
  @commitments_1 ||= Participants::Commitments.new
end

def commitments_2
  @commitments_2 ||= Participants::Commitments.new
end

def positive_events_and_gratitude
  @positive_events_and_gratitude ||=
    Participants::CommitmentsModules::PositiveEventsAndGratitude.new
end

def activation_commitment
  @activation_commitment ||= Participants::CommitmentsModules::Activation.new
end

def skills
  @skills ||= Participants::Skills.new(lesson: 'Home Introduction')
end

def positive_events
  @positive_events ||= Participants::PracticeModules::PositiveEvents.new(
    description: 'test'
  )
end

def activation
  @activation ||= Participants::PracticeModules::Activation.new(
    activity_type: 'test'
  )
end