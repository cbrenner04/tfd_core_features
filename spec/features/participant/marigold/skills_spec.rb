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
    8.times do
      participant_navigation.scroll_to_bottom
      participant_navigation.next
      sleep(0.5) # pause so next is not clicked before next page loads
    end
    skills.finish

    expect(skills).to be_on_feedback_slide

    skills.rate
    skills.enter_feedback
    2.times { participant_navigation.next }

    expect(skills).to have_feedback_saved

    expect(participant_navigation).to have_home_page_visible

    visit skills.landing_page

    expect(skills_2).to be_available
  end
end
