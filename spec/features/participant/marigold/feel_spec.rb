# frozen_string_literal: true
# filename: ./spec/features/participants/marigold/feel_spec.rb

require './lib/pages/participants/feel'
require './lib/pages/participants/feel_modules/emotion_tracking'
require './lib/pages/participants/incentives'
require './lib/pages/participants/social_networking_modules/profile'

def feel
  @feel ||= Participants::Feel.new
end

def emotions
  @emotions ||= Participants::FeelModules::EmotionsTracking.new
end

def profile
  @profile ||= Participants::SocialNetworkingModules::Profile.new(
    display_name: 'marigold_2'
  )
end

def incentives
  @incentives ||= Participants::Incentives.new(
    plot: 'individual',
    image: 'flower3',
    pt_list_item: 0,
    date: Date.today.strftime('%b %d %Y'),
    incentive: 'emotion tracking 4 days in a row',
    completed: 1,
    total: 1
  )
end

feature 'FEEL tool', :marigold, sauce: sauce_labs do
  scenario 'Participant tracks their emotions for the day' do
    marigold_participant.sign_in
    visit feel.landing_page
    emotions.open

    expect(emotions).to have_emotions

    emotions.rate

    expect(emotions).to be_saved

    sleep(1) # throws an error alert, another expect does not work
    visit feel.landing_page
    emotions.open

    expect(emotions).to be_previously_completed_today
  end

  scenario 'participant receives incentive for completing 4 days in a row' do
    marigold_2.sign_in
    visit feel.landing_page
    emotions.open
    emotions.rate

    expect(emotions).to be_saved

    sleep(2)
    profile.visit_profile

    expect(incentives).to have_image_in_plot

    incentives.open_incentives_list

    expect(incentives).to be_complete
  end
end
