# frozen_string_literal: true
feature 'ACHIEVE tool', :social_networking, sauce: sauce_labs do
  background(:all) { participant_1.sign_in if ENV['safari'] }

  background do
    participant_1.sign_in unless ENV['safari']
    visit achieve.landing_page
  end

  scenario 'Participant reads goal help text' do
    achieve.open_help

    expect(achieve).to have_help_text
  end

  scenario 'Participant creates a goal' do
    eat_pizza_goal.add

    expect(goal_due_yesterday).to be_visible
    expect(eat_pizza_goal).to be_visible

    visit ENV['Base_URL']
    eat_pizza_goal.find_in_feed

    expect(eat_pizza_goal).to have_details
  end

  scenario 'Participant completes a goal' do
    goal_p1_alpha.complete

    expect(goal_p1_gamma).to_not be_visible
    expect(goal_p1_alpha).to be_visible

    visit ENV['Base_URL']
    goal_p1_alpha.find_in_feed

    expect(goal_p1_alpha).to be_visible_in_feed
  end

  scenario 'Participant deletes a goal' do
    goal_p1_gamma.delete

    expect(goal_p1_gamma).to_not be_visible

    goal_p1_gamma.view_deleted

    expect(goal_p1_alpha).to_not be_visible
    expect(goal_p1_gamma).to be_visible
  end
end

feature 'ACHIEVE tool create options', :social_networking, sauce: sauce_labs do
  scenario 'Participant has more than 4 weeks remaining, sees all options' do
    goal_participant_1.sign_in
    visit achieve.landing_page
    achieve.open_new

    expect(achieve).to have_no_specific_date_option
    expect(achieve).to have_one_week_option
    expect(achieve).to have_two_week_option
    expect(achieve).to have_four_week_option
    expect(achieve).to have_end_of_study_option
  end

  scenario 'Participant has 2+ weeks remaining, sees correct options' do
    goal_participant_2.sign_in
    visit achieve.landing_page
    achieve.open_new

    expect(achieve).to have_no_specific_date_option
    expect(achieve).to have_one_week_option
    expect(achieve).to have_two_week_option
    expect(achieve).to have_end_of_study_option
  end

  scenario 'Participant has 1+ weeks remaining, sees correct options' do
    goal_participant_3.sign_in
    visit achieve.landing_page
    achieve.open_new

    expect(achieve).to have_no_specific_date_option
    expect(achieve).to have_one_week_option
    expect(achieve).to_not have_two_week_option
    expect(achieve).to have_end_of_study_option
  end

  scenario 'Participant has < 1 weeks remaining, sees correct options' do
    goal_participant_4.sign_in
    visit achieve.landing_page
    achieve.open_new

    expect(achieve).to have_no_specific_date_option
    expect(achieve).to_not have_one_week_option
    expect(achieve).to_not have_two_week_option
    expect(achieve).to have_end_of_study_option
  end

  scenario 'Completed participant sees correct options' do
    completer_participant.sign_in
    visit achieve.landing_page
    achieve.open_new

    expect(achieve).to have_no_specific_date_option
    expect(achieve).to_not have_one_week_option
    expect(achieve).to_not have_two_week_option
    expect(achieve).to_not have_end_of_study_option

    completer_participant.sign_out # necessary?
  end
end
