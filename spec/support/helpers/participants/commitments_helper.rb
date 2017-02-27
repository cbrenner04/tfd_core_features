# frozen_string_literal: true
def commitments
  Participants::Commitments.new
end

def commitments_1
  Participants::Commitments.new
end

def commitments_2
  Participants::Commitments.new
end

def positive_events_and_gratitude
  Participants::CommitmentsModules::PositiveEventsAndGratitude.new
end

def activation_commitment
  Participants::CommitmentsModules::Activation.new
end

def mindfulness_commitment
  Participants::CommitmentsModules::Mindfulness.new
end

def reappraisal_commitment
  Participants::CommitmentsModules::Reappraisal.new
end

def kindness_commitment
  Participants::CommitmentsModules::Kindness.new
end

def skills_visible
  Participants::Skills.new(lesson: 'Home Introduction')
end

def marigold_6_navigation
  Participants::SocialNetworkingModules::Profile.new(display_name: 'marigold_6')
end

def marigold_7_navigation
  Participants::SocialNetworkingModules::Profile.new(display_name: 'marigold_7')
end

def marigold_8_navigation
  Participants::SocialNetworkingModules::Profile.new(display_name: 'marigold_8')
end

def commitment_incentive
  Participants::Incentives.new(total: 1)
end

def incentive_1
  Participants::Incentives.new(
    plot: 'individual',
    image: 'flower6'
  )
end

def incentive_2
  Participants::Incentives.new(
    plot: 'individual',
    image: 'flower5'
  )
end

def incentive_3
  Participants::Incentives.new(
    plot: 'individual',
    image: 'flower4'
  )
end

def positive_events_practice_module
  Participants::PracticeModules::PositiveEvents.new(description: 'test')
end

def activation_practice_module
  Participants::PracticeModules::Activation.new(activity_type: 'test')
end

def mindfulness_practice_module
  Participants::PracticeModules::Mindfulness.new(activity_type: 'test')
end

def reappraisals_practice_module
  Participants::PracticeModules::Reappraisals.new(activity_type: 'test')
end

def kindness_practice_module
  Participants::PracticeModules::Kindness.new(activity_type: 'test')
end

def complete_activation_commitment
  activation_commitment.open
  activation_commitment.move_through_initial_slideshow
  participant_navigation.next
  activation_commitment.set_commitment
  participant_navigation.next
  participant_navigation.next
  commitments_2.set_minimum_time
  commitments_2.set_frequency
  commitments_2.set_tracking
  commitments_2.enter_details
  commitments_2.enter_affirmation
  participant_navigation.next
  commitments.sign
  participant_navigation.next
end
