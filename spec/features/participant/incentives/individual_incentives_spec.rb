# filename: ./spec/features/participant/incentives/individual_incentives_spec.rb

require './spec/support/participants/individual_incentives_helper'

feature 'Individual incentives', :incentives, sauce: sauce_labs do
  background do
    participant_3.sign_in unless ENV['safari']
    visit ENV['Base_URL']
  end

  scenario 'Participant views list of incentives & related behaviors' do
    participant_3_profile.visit_profile

    expect(pt_3_incentive_1).to have_incomplete_image

    navigation.scroll_down
    pt_3_incentive_1.open_incentives_list

    expect(pt_3_incentive_1).to have_incentives_listed
  end

  scenario 'Participant completes a behavior, sees incentive list update' do
    pt_3_like_1.like
    participant_3_profile.visit_profile

    expect(pt_3_incentive_2).to be_visible

    navigation.scroll_down
    pt_3_incentive_2.open_incentives_list
    navigation.scroll_down

    expect(pt_3_behavior_1).to be_complete
  end

  scenario 'Participant completes all behaviors, sees incentive list update' do
    pt_3_like_2.like
    pt_3_like_3.like
    participant_3_profile.visit_profile
    expect(pt_3_incentive_3).to be_visible

    expect(pt_3_incentive_3).to have_image_in_plot

    navigation.scroll_down
    pt_3_incentive_3.open_incentives_list

    expect(pt_3_behavior_2).to be_complete

    expect(pt_3_behavior_3).to be_complete
  end

  scenario 'Participant completes a repeatable incentive for a second time' do
    participant_3_profile.visit_profile

    expect(pt_3_repeatable_incentive_1).to have_image_in_plot

    expect(pt_3_repeatable_incentive_1).to have_num_completed

    visit pt_3_goal.landing_page
    pt_3_goal.add

    expect(pt_3_goal).to be_visible

    visit ENV['Base_URL']
    participant_3_profile.visit_profile

    expect(pt_3_repeatable_incentive_2).to have_correct_num_of_flowers_in_plot

    expect(pt_3_repeatable_incentive_2).to have_num_completed
  end

  scenario 'Participant checks completed incentives of another participant' do
    expect(participant_2_incentive).to have_image_in_home_plot

    participant_2_incentive.visit_another_pt_incentives

    expect(participant_2_incentive).to be_visible

    expect(participant_2_incentive).to have_image_in_plot

    navigation.scroll_down
    participant_2_incentive.open_incentives_list

    expect(pt_2_behavior_1).to be_complete

    expect(pt_2_behavior_2).to be_complete

    expect(pt_2_behavior_2).to be_complete

    participant_2_incentive.close_incentive_alerts
    visit ENV['Base_URL']
    participant_3.sign_out
  end
end
