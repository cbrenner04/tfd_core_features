# frozen_string_literal: true
# filename: ./spec/features/participant/incentives/communal_incentives_spec.rb

require './spec/support/participants/communal_incentives_helper'

feature 'Communal incentives', :incentives, :marigold, sauce: sauce_labs do
  background(:all) { participant_3.sign_in if ENV['safari'] }

  background do
    participant_3.sign_in unless ENV['safari']
    visit ENV['Base_URL']
  end

  scenario 'Participant views communal incentives list' do
    incomplete_communal_incentive.open_communal_plot

    expect(incomplete_communal_incentive).to have_incomplete_image

    participant_navigation.scroll_down
    incomplete_communal_incentive.open_incentives_list

    expect(incomplete_communal_incentive).to have_incentives_listed
    expect(incomplete_communal_incentive).to be_incomplete
  end

  scenario 'Participant completes communal incentive, sees list update' do
    complete_communal_incentive.open_communal_plot

    expect(complete_communal_incentive).to_not have_image_in_plot

    pt_3_comment_1.comment
    pt_3_comment_2.comment
    pt_3_comment_3.comment
    participant_navigation.reload
    sleep(1)
    complete_communal_incentive.open_communal_plot

    expect(complete_communal_incentive).to have_image_in_plot

    participant_navigation.scroll_down
    complete_communal_incentive.open_incentives_list

    expect(complete_communal_incentive).to be_complete
  end
end

feature 'Communal incentives', :incentives, :marigold, sauce: sauce_labs do
  scenario 'Participant completes partial community incentive' do
    participant_1.sign_in
    partial_communal_incentive_1.open_communal_plot

    expect(partial_communal_incentive_1).to have_total_needed_to_complete
    expect(partial_communal_incentive_1).to_not have_image_in_plot

    pt_1_comment_1.comment
    participant_navigation.reload
    sleep(1)
    partial_communal_incentive_2.open_communal_plot

    participant_navigation.scroll_down
    partial_communal_incentive_2.open_incentives_list

    expect(partial_communal_incentive_2).to be_complete
  end
end
