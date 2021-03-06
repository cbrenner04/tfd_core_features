# frozen_string_literal: true
# filename: ./spec/features/participant/core/do_spec.rb

require './spec/support/participants/do_helper'

feature 'DO tool', :core, sauce: sauce_labs do
  background(:all) { participant_1.sign_in if ENV['safari'] }

  background do
    participant_1.sign_in unless ENV['safari']
    visit do_tool.landing_page
  end

  scenario 'Participant cannot enter more than 255 characters' do
    awareness.open
    awareness.move_to_time_period_selection
    awareness_1a_to_2a.create_time_period
    awareness_1a_to_2a.complete_one_hour_review_with_more_than_255_characters
    participant_navigation.scroll_to_bottom
    participant_navigation.next

    expect(awareness).to have_less_than_255_characters_in_entries
  end

  scenario 'Participant completes the Awareness module' do
    awareness.open
    awareness.move_to_time_period_selection
    awareness_7a_to_10p.create_time_period
    awareness_7a_to_10p.complete_multiple_hour_review

    expect(awareness_7a_to_10p).to have_entries

    # check to confirm you cannot enter the same time period
    visit do_tool.landing_page
    awareness.open
    awareness.move_to_time_period_selection

    expect(awareness).to_not have_start_time('7 AM')
    expect(awareness).to_not have_end_time('10 PM')
  end

  scenario 'Participant completes for time that overlaps days' do
    awareness.open
    awareness.move_to_time_period_selection
    awareness_11p_to_1a.create_time_period
    awareness_11p_to_1a.complete_one_hour_review(0, 'Sleep', 6, 1)
    awareness_11p_to_1a.copy(0)
    participant_navigation.scroll_to_bottom
    participant_navigation.next

    expect(awareness_11p_to_1a).to have_entries
  end

  scenario 'Participant completes Planning module' do
    planning.open
    participant_navigation.next
    plan_activity_1.plan
    social_networking.accept_social

    expect(do_tool).to have_success_alert

    participant_navigation.scroll_down
    plan_activity_2.plan
    social_networking.accept_social

    expect(do_tool).to have_success_alert

    planning.move_to_review

    expect(planning).to have_entries

    planning.finish
  end

  scenario 'Participant completes Reviewing module' do
    reviewing.open
    reviewing.move_to_review
    reviewing.review_completed_activity
    ENV['tfd'] ? participant_navigation.next : social_networking.decline_social

    expect(do_tool).to have_success_alert

    # this is due to a dependency issue, need to update
    unless reviewing.has_another_activity_to_review?
      reviewing.review_incomplete_activity
      social_networking.decline_social

      expect(do_tool).to have_success_alert
    end
  end

  scenario 'Participant completes Plan a New Activity module' do
    plan_new_activity.open
    plan_new_activity.plan_activity
    social_networking.accept_social

    expect(do_tool).to have_success_alert
    expect(plan_new_activity).to have_activity
  end

  scenario 'Participant navigates to Your Activities viz' do
    activity_viz.open

    expect(activity_viz).to have_current_day_visible
  end

  scenario 'Participant collapses Daily Summaries in Your Activities viz' do
    activity_viz.open

    expect(activity_viz).to have_daily_summary_visible

    activity_viz.toggle_daily_summary

    expect(activity_viz).to_not have_daily_summary_visible
  end

  scenario 'Participant goes to previous day, views & edits ratings in viz' do
    edit_activity_viz.open
    participant_navigation.scroll_to_bottom
    edit_activity_viz.go_to_previous_day

    expect(edit_activity_viz).to have_previous_day_visible

    participant_navigation.scroll_to_bottom
    edit_activity_viz.view_activity_rating

    expect(edit_activity_viz).to have_activity_rating

    edit_activity_viz.edit_ratings

    expect(edit_activity_viz).to have_new_ratings
  end

  scenario 'Participant uses the visualization in Your Activities viz' do
    activity_viz.open
    activity_viz.open_visualize
    activity_viz.go_to_three_day_view

    expect(activity_viz).to have_three_day_view_visible

    activity_viz.open_date_picker

    expect(activity_viz).to have_date_picker # doesn't pick a date, update?
  end

  scenario 'Participant visits View Planned Activities module' do
    planned_activities.open

    expect(planned_activities).to be_visible
    expect(planned_activities).to have_activity
  end

  scenario 'Participant uses navbar functionality for all of DO' do
    visit do_tool.awareness

    expect(awareness).to have_first_slide_visible

    do_tool.navigate_to_all_modules_through_nav_bar
  end

  scenario 'Participant uses skip functionality in Awareness' do
    awareness.open

    expect(awareness).to have_first_slide_visible

    participant_navigation.skip

    expect(awareness).to have_time_period_selection_form_visible
  end

  scenario 'Participant uses skip functionality in Planning' do
    planning.open

    expect(planning).to have_first_slide_visible

    participant_navigation.skip

    expect(planning).to have_planning_form_visible
  end

  scenario 'Participant uses skip functionality in Doing' do
    reviewing.open
    reviewing.has_first_slide_visible?
    participant_navigation.skip

    unless reviewing.has_another_activity_to_review?
      expect(reviewing).to have_nothing_to_do_message
    end
  end

  scenario 'Participant sees Upcoming Activities on DO > Landing' do
    expect(do_tool).to have_upcoming_activities_visible
  end
end

feature 'DO Tool, Participant 3', :core, sauce: sauce_labs do
  background(:all) { participant_3.sign_in if ENV['safari'] }

  background do
    participant_3.sign_in unless ENV['safari']
    visit do_tool.landing_page
  end

  scenario 'Participant completes Awareness w/ already entered awake period' do
    awareness.open
    awareness.move_to_time_period_selection
    awareness.choose_to_complete_time_period
    awareness_complete_entry.complete_multiple_hour_review

    expect(awareness_complete_entry).to have_entries
    expect(do_tool).to have_landing_visible
  end

  scenario 'Participant visits Reviewing from viz at bottom of DO > Landing' do
    do_tool.review_activities_from_landing

    expect(reviewing).to have_another_activity_to_review
  end
end
