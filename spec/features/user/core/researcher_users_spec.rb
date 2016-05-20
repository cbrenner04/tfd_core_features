# filename: ./spec/features/user/core/researcher_users_spec.rb

require './spec/support/users/researcher_users_helper'

feature 'Researcher, Users', :superfluous, :core, sauce: sauce_labs do
  background do
    researcher.sign_in unless ENV['safari']
    visit researcher_users.landing_page
  end

  scenario 'Researcher creates a researcher' do
    new_researcher.create_researcher

    expect(new_researcher).to be_created_successfully
  end

  scenario 'Researcher adds a clinician role to a researcher' do
    test_1_user.open
    test_1_user.edit
    test_1_user.add_clinician_role

    expect(test_1_user).to have_clinician_and_researcher_role
  end

  scenario 'Researcher destroys a researcher' do
    test_2_user.open
    test_2_user.destroy

    expect(test_2_user).to be_destroyed_successfully
  end

  scenario 'Researcher creates a clinician' do
    new_clinician.create_clinician

    expect(new_clinician).to be_created_successfully
  end

  scenario 'Researcher adds a content author role to a clinician' do
    test_3_user.open
    test_3_user.edit
    test_3_user.add_content_author_role

    expect(test_3_user).to have_clinician_and_content_author_role
  end

  scenario 'Researcher destroys a clinician' do
    test_4_user.open
    test_4_user.destroy

    expect(test_4_user).to be_destroyed_successfully
  end

  scenario 'Researcher creates a content author' do
    new_content_author.create_content_author

    expect(new_content_author).to be_created_successfully
  end

  scenario 'Researcher adds a clinician role to a content author' do
    test_5_user.open
    test_5_user.edit
    test_5_user.add_clinician_role

    expect(test_5_user).to have_clinician_and_content_author_role
  end

  scenario 'Researcher destroys a content author' do
    test_6_user.open
    test_6_user.destroy

    expect(test_6_user).to be_destroyed_successfully
  end

  scenario 'Researcher uses breadcrumbs to return to home' do
    test_1_user.open
    user_navigation.go_back_to_users_page
    user_navigation.go_back_to_home_page

    expect(user_navigation).to have_home_visible
  end
end
