# filename: ./spec/features/user/social_networking/coach_groups_spec.rb

require './lib/pages/users/arms'
require './lib/pages/users/groups'
require './lib/pages/users/group_dashboard'

def arm_1
  @arm_1 ||= Users::Arms.new(title: 'Arm 1')
end

def group_6
  @group_6 ||= Users::Groups.new(title: 'Group 6')
end

def group_6_dashboard
  @group_6_dashboard ||= Users::GroupDashboard.new
end

feature 'Coach, Group Dashboard', :social_networking, sauce: sauce_labs do
  background(:all) { clinician.sign_in } if ENV['safari']

  background do
    clinician.sign_in unless ENV['safari']
    visit user_navigation.arms_page
    arm_1.open
    group_6.open
    group_6_dashboard.open
  end

  scenario 'Coach views Group Summary' do
    expect(group_6_dashboard).to have_group_summary_data
  end

  scenario 'Coach uses the links within Group Summary' do
    group_6_dashboard.click_each_link
  end

  scenario 'Coach views Logins by Week' do
    expect(group_6_dashboard).to have_logins_by_week
  end

  scenario 'Coach views Lesson View Summary' do
    expect(group_6_dashboard).to have_lesson_summary_data
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
