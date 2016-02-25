# filename: ./spec/features/participant/incentives/communal_incentives_spec.rb

require './spec/support/participants/communal_incentives_helper'

feature 'Communal incentives', :incentives, sauce: sauce_labs do
  background(:all) { participant_3_sob if ENV['safari'] }

  background do
    participant_3_sob.sign_in unless ENV['safari']
    visit ENV['Base_URL']
  end

  scenario 'Participant views communal incentives list' do
    incomplete_communal_incentive.open

    expect(incomplete_communal_incentive).to have_incomplete_image

    navigation.scroll_down
    incomplete_communal_incentive.open_incentives_list

    expect(incomplete_communal_incentive).to have_group_incentives_listed

    expect(incomplete_communal_incentive).to be_incomplete
  end

  scenario 'Participant completes communal incentive, sees list update' do
    complete_communal_incentive.open

    expect(complete_communal_incentive).to_not have_image_in_plot

    pt_3_comment_1.comment
    pt_3_comment_2.comment
    pt_3_comment_3.comment
    navigation.reload

    complete_communal_incentive.open

    expect(complete_communal_incentive).to have_image_in_plot

    navigation.scroll_down
    complete_communal_incentive.open_incentives_list

    expect(complete_communal_incentive).to be_complete
  end
end
