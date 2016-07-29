# frozen_string_literal: true
# filename: ./spec/features/participant/marigold/boosters_spec.rb

require './lib/pages/participants/boosters.rb'
require './lib/pages/participants/navigation.rb'

feature 'Boosters', :marigold, sauce: sauce_labs do
  scanerio 'link takes participant to boosters' do
    visit "#{ENV['Base_URL']}/booster_session"

    expect(boosters).to have_thank_you_visisble

    navigation.alt_next

    expect(boosters).to be_visible
  end

end
