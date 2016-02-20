# filename: ./spec/features/participant/core/do_spec.rb

require './spec/support/do_helper'

feature 'DO tool', :core, sauce: sauce_labs do
  background(:all) { participant_1.sign_in if ENV['safari'] }

  background do
    participant_1.sign_in unless ENV['safari']

    visit do_tool.landing
  end

  scenario 'A participant completes the Awareness module' do
    awareness.open
    awareness.move_to_time_period_selection
    awareness_7a_to_10p.create_time_period
    awareness_7a_to_10p.complete_multiple_hour_review

    expect(awareness_7a_to_10p).to have_entries

    awareness.finish
  end

  # this is dependent on the previous example, need to update
  scenario 'Participant cannot complete for time period already completed' do
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
    navigation.scroll_to_bottom
    navigation.next

    expect(awareness_11p_to_1a).to have_entries

    awareness.finish
  end

  scenario 'Participant completes Planning module' do
    planning.open
    navigation.next
    planning.plan_first_activity
    navigation.scroll_down
    planning.plan_second_activity
    planning.move_to_review

    expect(planning).to have_entries

    planning.finish
  end

  scenario 'Participant completes Reviewing module' do
    reviewing.open
    reviewing.move_to_review
    reviewing.review_completed_activity

    # this is due to a dependency issue, need to update
    unless reviewing.has_another_activity_to_review?
      reviewing.review_incomplete_activity
    end
  end

  scenario 'Participant completes Plan a New Activity module' do
    plan_new_activity.open
    plan_new_activity.plan_activity

    expect(plan_new_activity).to have_activity
  end

  scenario 'Participant navigates to Your Activities viz' do
    activity_viz.open

    expect(activity_viz).to be_visible
  end

  scenario 'Participant collapses Daily Summaries in Your Activities viz' do
    activity_viz.open
    find('p', text: 'Average Accomplishment Discrepancy')
    click_on 'Daily Summaries'
    expect(page).to_not have_content 'Average Accomplishment Discrepancy'
  end

  scenario 'Participant navigates to previous day in Your Activities viz' do
    activity_viz.open
    find('h3', text: 'Daily Averages')
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Previous Day'
    prev_day = Date.today - 1
    expect(page)
      .to have_content "Daily Averages for #{prev_day.strftime('%b %d %Y')}"
  end

  scenario 'Participant views ratings of an activity in Your Activities viz' do
    activity_viz.open
    find('h3', text: 'Daily Averages')
    page.execute_script('window.scrollTo(0,5000)')
    prev_day = Date.today - 1
    click_on 'Previous Day'
    find('h3', text: "Daily Averages for #{prev_day.strftime('%b %d %Y')}")
    page.execute_script('window.scrollTo(0,5000)')
    endtime = Time.now + (60 * 60)
    within('.panel.panel-default',
           text: "#{Time.now.strftime('%-l %P')} - " \
                 "#{endtime.strftime('%-l %P')}: Parkour") do
      click_on "#{Time.now.strftime('%-l %P')} - " \
               "#{endtime.strftime('%-l %P')}: Parkour"
      expect(page)
        .to have_content 'Predicted  Average Importance: 4 Really fun: 9'
    end
  end

  scenario 'Participant edits ratings of an activity in Your Activities viz' do
    activity_viz.open
    find('h3', text: 'Daily Averages')
    page.execute_script('window.scrollTo(0,5000)')
    prev_day = Date.today - 1
    click_on 'Previous Day'
    find('h3', text: "Daily Averages for #{prev_day.strftime('%b %d %Y')}")
    page.execute_script('window.scrollTo(0,5000)')
    endtime = Time.now + (60 * 60)
    within('.panel.panel-default',
           text: "#{Time.now.strftime('%-l %P')} - " \
           "#{endtime.strftime('%-l %P')}: Parkour") do
      click_on "#{Time.now.strftime('%-l %P')} - " \
               "#{endtime.strftime('%-l %P')}: Parkour"
      within('.collapse.in') do
        click_on 'Edit'
        select '6', from: 'activity[actual_pleasure_intensity]'
        select '7', from: 'activity[actual_accomplishment_intensity]'
        click_on 'Update'
      end
      expect(page)
        .to have_content 'Accomplishment: 7 · Pleasure: 6'
    end
  end

  scenario 'Participant uses the visualization in Your Activities viz' do
    activity_viz.open
    find('h3', text: 'Daily Averages')
    click_on 'Visualize'
    click_on 'Last 3 Days'
    date1 = Date.today - 2
    expect(page).to have_content date1.strftime('%A, %m/%d')

    click_on 'Day'
    expect(page).to have_css('#datepicker')
  end

  scenario 'Participant visits View Planned Activities module' do
    click_on 'View Planned Activities'
    find('.text-capitalize', text: 'View Planned Activities')
    expect(page).to have_content 'Speech'
  end

  scenario 'Participant uses navbar functionality for all of DO' do
    visit "#{ENV['Base_URL']}/navigator/modules/339588004"
    find('h1', text: 'This is just the beginning...')

    tool = ['#2 Planning', '#1 Awareness', '#3 Doing', 'Add a New Activity',
            'Your Activities', 'View Planned Activities', 'DO Home']
    content = ['The last few times you were here...',
               'This is just the beginning...', 'Welcome back!',
               "But you don't have to start from scratch", 'Daily Averages',
               'Speech', 'Add a New Activity']

    tool.zip(content) do |t, c|
      click_on 'DO'
      click_on t
      expect(page).to have_content c
    end
  end

  scenario 'Participant uses skip functionality in Awareness' do
    click_on '#1 Awareness'
    find('h1', text: 'This is just the beginning...')
    click_on 'Skip'
    expect(page).to have_content "OK, let's talk about yesterday."
  end

  scenario 'Participant uses skip functionality in Planning' do
    click_on 'DO'
    first('a', text: '#2 Planning').click
    find('h1', text: 'The last few times you were here...')
    click_on 'Skip'
    expect(page).to have_content 'We want you to plan one fun thing'
  end

  scenario 'Participant uses skip functionality in Doing' do
    click_on 'DO'
    first('a', text: '#3 Doing').click
    find('h1', text: 'Welcome back!')
    click_on 'Skip'
    unless page.has_text?('You said you were going to')
      expect(page).to have_content "It doesn't look like there are any " \
                                   'activities for you to review at this time'
    end
  end

  scenario 'Participant sees Upcoming Activities on DO > Landing' do
    expect(page).to have_content 'Activities in your near future'
  end
end

feature 'DO Tool, Participant 3', :core, sauce: sauce_labs do
  if ENV['safari']
    background(:all) do
      sign_in_pt(ENV['Alt_Participant_Email'], 'participant1',
                 ENV['Alt_Participant_Password'])
    end
  end

  background do
    unless ENV['safari']
      sign_in_pt(ENV['Alt_Participant_Email'], 'participant1',
                 ENV['Alt_Participant_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/DO"
  end

  scenario 'Participant completes Awareness w/ already entered awake period' do
    click_on '#1 Awareness'
    click_on 'Next'
    find('h1', text: 'Just a slide')
    click_on 'Next'
    click_on 'Complete'

    activity = ['Get ready for work', 'Travel to work', 'Work']

    (0..2).zip(activity, [6, 2, 8], [7, 3, 9]) do |a, b, c, d|
      fill_in "activity_type_#{a}", with: b
      choose_rating("pleasure_#{a}", c)
      choose_rating("accomplishment_#{a}", d)
      page.execute_script('window.scrollBy(0,500)')
    end

    click_on 'Next'

    %w(recent fun accomplished).zip([4, 3, 3]) do |x, y|
      find("##{x}_activities")
      click_on 'Next'
      expect(page).to have_css('tr', count: y)
    end

    find('h1', text: 'Do Landing')
  end

  scenario 'Participant visits Reviewing from viz at bottom of DO > Landing' do
    find('.Recent_Past_Activities')
    click_on 'Review'
    expect(page).to have_content 'You said you were going to'
  end
end
