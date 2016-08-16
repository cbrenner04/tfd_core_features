# frozen_string_literal: true

require './lib/pages/participants'
require './lib/pages/participants/commitments'
require './lib/pages/participants/incentives'
require './lib/pages/participants/skills'
Dir['./lib/pages/participants/commitments_modules/*.rb']
  .each { |file| require file }
Dir['./lib/pages/participants/practice_modules/*.rb']
  .each { |file| require file }

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

def mindfulness_commitment
  @mindfulness_commitment ||= Participants::CommitmentsModules::Mindfulness.new
end

def reappraisal_commitment
  @reappraisal_commitment ||= Participants::CommitmentsModules::Reappraisal.new
end

def kindness_commitment
  @kindness_commitment ||= Participants::CommitmentsModules::Kindness.new
end

def skills_visible
  @skills_visible ||= Participants::Skills.new(lesson: 'Home Introduction')
end

def positive_events_practice_module
  @positive_events_practice_module ||=
    Participants::PracticeModules::PositiveEvents.new(
      description: 'test'
    )
end

def activation_practice_module
  @activation_practice_module ||=
    Participants::PracticeModules::Activation.new(
      activity_type: 'test'
    )
end

def mindfulness_practice_module
  @mindfulness_practice_module ||=
    Participants::PracticeModules::Mindfulness.new(
      activity_type: 'test'
    )
end

def reappraisals_practice_module
  @reappraisals_practice_module ||=
    Participants::PracticeModules::Reappraisals.new(
      activity_type: 'test'
    )
end

def kindness_practice_module
  @kindness_practice_module ||= Participants::PracticeModules::Kindness.new(
    activity_type: 'test'
  )
end

def complete_activation_commitment
  activation_commitment.open
  activation_commitment.move_through_initial_slideshow
  participant_navigation.next

  expect(activation_commitment).to have_commitment_form_visible

  activation_commitment.set_commitment
  participant_navigation.next

  expect(commitments).to have_making_commitment_form_visible

  participant_navigation.next
  commitments_2.set_minimum_time
  commitments_2.set_frequency
  commitments_2.set_tracking
  commitments_2.enter_details
  commitments_2.enter_affirmation
  participant_navigation.next

  expect(activation_commitment).to have_commitment_summary_visible
  expect(activation_commitment).to have_commitment
  expect(commitments_2).to have_responses

  commitments.sign
  participant_navigation.next

  expect(commitments).to be_done
end
