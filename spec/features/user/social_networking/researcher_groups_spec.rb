# frozen_string_literal: true
# filename: ./spec/features/user/social_networking/researcher_groups_spec.rb

require './spec/support/users/social_researcher_groups_helper'

feature 'Researcher, Groups,',
        :superfluous, :social_networking, :marigold, sauce: sauce_labs do
  background(:all) { researcher.sign_in } if ENV['safari']

  background do
    researcher.sign_in unless ENV['safari']
    visit user_navigation.groups_page
  end

  scenario 'Researcher creates a group' do
    new_group.create

    expect(new_group).to be_created_successfully
  end

  scenario 'Researcher updates a group' do
    user_navigation.scroll_down
    group_8.open
    group_8.update_title

    expect(group_8).to be_updated_successfully
    expect(group_8).to have_updated_group_title
  end

  scenario 'Researcher updates moderator for Group 9' do
    expect(group_9).to be_visible_in_listing
    user_navigation.scroll_to_bottom
    group_9.open
    group_9.update_moderator

    expect(group_9).to be_updated_successfully
    expect(group_9).to have_updated_moderator
  end

  scenario 'Researcher destroys a group' do
    expect(group_10).to be_visible_in_listing
    user_navigation.scroll_to_bottom
    group_10.open
    user_navigation.destroy

    expect(group_10).to be_destroyed_successfully
    expect(group_10).to_not be_visible_in_listing
  end

  scenario 'Researcher assigns a task within a group' do
    expect(group_11).to be_visible_in_listing
    user_navigation.scroll_to_bottom
    group_11.open
    group_11.assign_task

    expect(group_11).to have_task_assigned_successfully
  end

  scenario 'Researcher cannot unassign a task when data exists' do
    expect(group_1_b).to be_visible_in_listing
    user_navigation.scroll_to_bottom
    group_1_b.open
    group_1_b.unassign_task

    expect(group_1_b).to have_failed_to_unassign_alert
    expect(group_1_b).to have_task
  end

  scenario 'Researcher unassigns a task within a group' do
    expect(group_11_a).to be_visible_in_listing
    user_navigation.scroll_to_bottom
    group_11_a.open
    group_11_a.unassign_task

    expect(group_11_a).to_not have_task
  end

  scenario 'Researcher uses breadcrumbs to return to home' do
    user_navigation.go_back_to_home_page

    expect(user_navigation).to have_home_visible
  end
end
