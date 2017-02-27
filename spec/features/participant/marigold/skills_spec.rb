# frozen_string_literal: true
def profile_skills
  Participants::SocialNetworkingModules::Profile.new(display_name: 'marigold_2')
end

def incentives_skills
  Participants::Incentives.new(
    plot: 'individual',
    image: 'flower5',
    pt_list_item: 0,
    date: Date.today.strftime('%b %d %Y'),
    incentive: 'complete all skills',
    completed: 1,
    total: 1
  )
end

def skills
  Participants::Skills.new(lesson: 'Home Introduction')
end

def skills_2
  Participants::Skills.new(lesson: 'Testing adding/updating slides/lessons')
end

feature 'SKILLS tool', :marigold, sauce: sauce_labs do
  scenario 'Participant reads a lesson, completes the feedback at the end' do
    marigold_participant.sign_in
    visit skills.landing_page

    # second lesson should not be available to read until after first is read
    expect(skills_2).to be_unavailable

    skills.open_lesson
    7.times do
      participant_navigation.scroll_to_bottom
      participant_navigation.next
      sleep(0.5) # pause so next is not clicked before next page loads
    end

    skills.finish

    expect(skills).to be_on_feedback_slide

    skills.rate
    skills.enter_feedback
    participant_navigation.next

    expect(skills).to have_feedback_saved

    participant_navigation.next

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
      # need to close incentive notifications if they exist
      incentives_skills.close_incentive_alerts

      # navigate to next slide
      participant_navigation.scroll_to_bottom
      participant_navigation.next
      sleep(0.5) # pause so next is not clicked before next page loads
    end

    skills_2.finish
    sleep(1) # pause so skills page can load before profile page
    profile_skills.visit_profile

    expect(incentives_skills).to have_image_in_plot

    incentives_skills.open_incentives_list

    expect(incentives_skills).to be_complete
  end
end
