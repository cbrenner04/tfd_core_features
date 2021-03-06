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

def profile_feel
  @profile ||= Participants::SocialNetworkingModules::Profile.new(
    display_name: 'marigold_2'
  )
end

def incentives_feel
  @incentives ||= Participants::Incentives.new(
    plot: 'individual',
    image: 'flower3',
    pt_list_item: 0,
    date: Date.today.strftime('%b %d %Y'),
    incentive: 'emotion tracking 4 days in a row',
    completed: 1,
    total: 1,
    flower_count: 1
  )
end

feature 'FEEL tool', :marigold, :browser, sauce: sauce_labs do
  scenario 'Participant tracks their emotions for the day' do
    marigold_participant.sign_in
    visit feel.landing_page
    emotions.open

    expect(emotions).to have_emotions

    emotions.rate

    expect(emotions).to be_saved

    emotions.complete_dice

    expect(emotions).to have_dice_saved

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

    emotions.complete_dice

    expect(emotions).to have_dice_saved

    profile_feel.visit_profile

    expect(incentives_feel).to have_image_in_plot
    expect(incentives_feel).to have_correct_num_of_flowers_in_plot

    incentives_feel.open_incentives_list

    expect(incentives_feel).to be_complete
  end
end
