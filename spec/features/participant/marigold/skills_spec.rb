# filename: ./spec/features/participant/marigold/skills_spec.rb

require './lib/pages/participants/skills'

def skills
  @skills ||= Participants::Skills.new(lesson: 'Home Introduction')
end

def skills_2
  @skills_2 ||= Participants::Skills.new(
    lesson: 'Testing adding/updating slides/lessons'
  )
end

feature 'SKILLS tool', :marigold, sauce: sauce_labs do
  scenario 'Participant reads a lesson, completes the feedback at the end' do
    marigold_participant.sign_in
    visit skills.landing_page

    # second lesson should not be available to read until after first is read
    expect(skills_2).to be_unavailable

    skills.open_lesson
    7.times { participant_navigation.next }
    skills.finish

    expect(skills).to be_on_feedback_slide

    skills.rate
    skills.enter_feedback
    participant_navigation.next

    expect(skills).to have_feedback_saved
    expect(skills_2).to be_available
  end
end
