# frozen_string_literal: true
# filename: ./spec/features/participant/incentives/background_spec.rb

require './spec/support/participants/background_helper'

feature 'Background image', :incentives, :browser, sauce: sauce_labs do
  background(:all) { background_participant.sign_in if ENV['safari'] }

  background do
    background_participant.sign_in unless ENV['safari']
    visit ENV['Base_URL']
  end

  scenario 'Participant selects a background image' do
    app_background_1.choose_image

    expect(participant_navigation).to_not have_modal

    visit think.landing_page

    expect(app_background_1).to be_visible
  end

  scenario 'Participant updates the background image from profile page' do
    app_background_1.choose_image if participant_navigation.has_modal?
    bkgd_pt_profile.visit_profile
    app_background_1.change
    app_background_2.choose_image
    visit think.landing_page

    expect(app_background_2).to be_visible
  end
end
