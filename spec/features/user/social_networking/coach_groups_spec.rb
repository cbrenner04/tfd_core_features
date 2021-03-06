# frozen_string_literal: true
# filename: ./spec/features/user/social_networking/coach_groups_spec.rb

require './lib/pages/users/group_dashboard'

def group_6_dashboard
  @group_6_dashboard ||= Users::GroupDashboard.new
end

feature 'Coach, Group Dashboard', :social_networking, :marigold,
        sauce: sauce_labs do
  background(:all) { clinician.sign_in } if ENV['safari']

  background do
    clinician.sign_in unless ENV['safari']
    visit user_navigation.arms_page
    arm_1.open
    group_6.open
    group_6_dashboard.open

    expect(group_6_dashboard).to be_visible
  end

  scenario 'Coach views Group Summary' do
    # implicitly checks that moderator participant's data is not displayed
    # moderator participant's data are written in the fixtures

    # also implicitly checks the data is in the correct week
    # previously the data would shift weeks due to moderator
    # membership starting earlier
    expect(group_6_dashboard).to have_group_summary_data
  end

  scenario 'Coach uses the links within Group Summary' do
    group_6_dashboard.click_each_link
  end

  scenario 'Coach views Logins by Week' do
    expect(group_6_dashboard).to have_logins_by_week
  end

  # hidden dependency somewhere - fails when run full suite
  # somehow "Do - Awareness Introduction" no longer exists in full suite
  scenario 'Coach views Lesson View Summary' do
    # implicitly checks that moderator participant does not count toward counts
    expect(group_6_dashboard).to have_lesson_summary_data
    # explicitly confirms moderator participant is not shown
    # in "View Incomplete Participants"
    # app env variable NEEDS to be set or you will get a false positive
    expect(group_6_dashboard).to have_no_moderator_in_incomplete_lessons
  end

  scenario 'Coach views Thoughts' do
    expect(group_6_dashboard).to have_thoughts_data
  end

  scenario 'Coach views Activities Past' do
    expect(group_6_dashboard).to have_activities_past_data
  end

  scenario 'Coach views Activities Future' do
    expect(group_6_dashboard).to have_activities_future_data
  end

  scenario 'Coach views On-My-Mind Statements' do
    expect(group_6_dashboard).to have_on_the_mind_data
  end

  scenario 'Coach views Comments' do
    expect(group_6_dashboard).to have_comments_data
  end

  scenario 'Coach views Goals' do
    user_navigation.scroll_down
    expect(group_6_dashboard).to have_goal_data
  end

  scenario 'Coach views Likes' do
    expect(group_6_dashboard).to have_like_data
  end

  scenario 'Coach uses breadcrumbs to return to home' do
    group_6.go_back_to_group_page
    user_navigation.go_back_to_home_page

    expect(user_navigation).to have_home_visible
  end
end
