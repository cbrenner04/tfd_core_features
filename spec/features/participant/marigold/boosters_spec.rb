# frozen_string_literal: true
# filename: ./spec/features/participant/marigold/boosters_spec.rb

require './lib/pages/participants'
require './lib/pages/participants/boosters.rb'
require './lib/pages/participants/navigation.rb'

def boosters
  @boosters ||= Participants::Boosters.new
end

def navigation
  @navigation ||= Participants::Navigation.new
end

feature 'Boosters', :marigold, sauce: sauce_labs do
  background do
    participant_marigold_4.sign_in
  end

  scenario 'invite link takes participant to boosters' do
    visit "#{ENV['Base_URL']}/booster_session"

    expect(boosters).to have_thank_you_visible

    navigation.alt_next

    expect(boosters).to be_visible
  end

  scenario 'is navigable after sign in' do
    boosters.click

    expect(boosters).to be_visible
  end
end
