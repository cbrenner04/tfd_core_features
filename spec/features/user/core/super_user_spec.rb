# frozen_string_literal: true
# filename: ./spec/features/user/core/super_user_spec.rb

require './spec/support/users/super_user_helper'

feature 'Super User', :superfluous, :core, :marigold, sauce: sauce_labs do
  background(:all) { super_user.sign_in } if ENV['safari']

  background do
    super_user.sign_in
    visit user_navigation.dashboard
  end

  scenario 'Super user creates an arm' do
    visit user_navigation.arms_page
    new_arm.create

    expect(new_arm).to be_created_successfully
  end

  scenario 'Super user updates an arm' do
    visit user_navigation.arms_page
    update_arm.open
    update_arm.update

    expect(update_arm).to be_updated_successfully
  end

  scenario 'Super user sees appropriate alert when trying to destroy an arm' do
    visit user_navigation.arms_page
    test_2_arm.open
    user_navigation.destroy

    expect(test_2_arm).to have_incorrect_privileges_alert
  end

  scenario 'Super user creates a super user' do
    visit users.landing_page
    new_super_user.create_super_user

    expect(new_super_user).to have_successfully_created_super_user
  end

  scenario 'Super user updates a super user' do
    visit users.landing_page
    update_super_user.open
    update_super_user.edit
    update_super_user.add_clinician_role

    expect(update_super_user).to be_super_user_with_clinician_role
  end

  scenario 'Super user destroys a super user' do
    visit users.landing_page
    destroy_super_user.open
    user_navigation.destroy

    expect(destroy_super_user).to be_destroyed_successfully
  end
end
