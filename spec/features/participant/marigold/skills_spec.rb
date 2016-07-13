# frozen_string_literal: true
# filename: ./spec/features/participant/marigold/skills_spec.rb

require './lib/pages/participants/skills'
require './lib/pages/participants/incentives'
require './lib/pages/participants/social_networking_modules/profile'

def profile
  @profile ||= Participants::SocialNetworkingModules::Profile.new(
    display_name: 'marigold_2'
  )
end

def incentives
  @incentives ||= Participants::Incentives.new(
    plot: 'individual',
    image: 'flower5-3bf874367425ba7f88a74bdf18c0fdff' \
           '2a2ad7bd10eadf9317b274e675e28d4b',
    pt_list_item: 0,
    date: Date.today.strftime('%b %d %Y'),
    incentive: 'complete all skills',
    completed: 1,
    total: 1
  )
end

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

  scenario 'Participant completes all available skills' do
    marigold_2.sign_in
    visit skills.landing_page

    expect(skills_2).to be_available

    skills_2.open_lesson
    7.times do
      participant_navigation.scroll_to_bottom
      participant_navigation.next
      sleep(0.5) # pause so next is not clicked before next page loads
    end
    skills_2.finish

    sleep(1) # pause so skills page can load before profile page

    profile.visit_profile

    expect(incentives).to have_image_in_plot

    incentives.open_incentives_list

    expect(incentives).to be_complete
  end
end
