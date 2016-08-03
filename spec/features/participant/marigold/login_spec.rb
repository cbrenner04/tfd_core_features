# frozen_string_literal: true
# filename: ./spec/features/participants/marigold/login_spec.rb

require './lib/pages/shared/navigation'
require './lib/pages/participants/incentives'
require './lib/pages/participants/social_networking_modules/profile'

# def navigation
#   @navigation ||= SharedNavigation.new
# end

def profile_login
  @profile ||= Participants::SocialNetworkingModules::Profile.new(
    display_name: 'marigold_2'
  )
end

def profile_login2
  @profile ||= Participants::SocialNetworkingModules::Profile.new(
    display_name: 'marigold_5'
  )
end

def incentives_login
  @incentives ||= Participants::Incentives.new(
    plot: 'individual',
    image: 'flower6',
    pt_list_item: 0,
    date: Date.today.strftime('%b %d %Y'),
    incentive: 'login for 7 days in a row',
    completed: 1,
    total: 1
  )
end

feature 'Participant login', :marigold, sauce: sauce_labs do
  scenario 'completes 7 day in a row incentive' do
    marigold_3.sign_in

    profile_login.visit_profile

    expect(incentives_login).to have_image_in_plot

    incentives_login.open_incentives_list

    expect(incentives_login).to be_complete
  end

  scenario 'to non-incentive group' do
    marigold_5.sign_in

    expect(incentives_login).to_not have_home_plot

    profile_login2.visit_profile

    expect(incentives_login).to_not have_profile_plot
  end
end
