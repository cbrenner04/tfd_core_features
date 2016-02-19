# filename: ./spec/features/participant/core/do_spec.rb

feature 'DO tool', :core, sauce: sauce_labs do
  if ENV['safari']
    background(:all) do
      sign_in_pt(ENV['Participant_Email'], 'participant1',
                 ENV['Participant_Password'])
    end
  end

  background do
    unless ENV['safari']
      sign_in_pt(ENV['Participant_Email'], 'participant1',
                 ENV['Participant_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/DO"
  end

  scenario 'A participant completes the Awareness module' do
    click_on '#1 Awareness'
    click_on 'Next'
    find('h1', text: 'Just a slide')
    click_on 'Next'
    select "#{Date.today.prev_day.strftime('%a')} 7 AM",
           from: 'awake_period_start_time'
    select "#{Date.today.prev_day.strftime('%a')} 10 PM",
           from: 'awake_period_end_time'
    click_on 'Create'
    find('.alert-success', text: 'Awake Period saved')

    activity = ['Get ready for work', 'Travel to work', 'Work', 'Work', 'Work',
                'Work', 'Work', 'Work', 'Work', 'Work', 'Travel from work',
                'Eat dinner', 'Watch TV', 'read', 'Get ready for bed']
    pleasure = [6, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 8, 9, 9, 2]
    accomplishment = [7, 5, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 3, 3, 3]

    (0..14).zip(activity, pleasure, accomplishment) do |a, b, c, d|
      fill_in "activity_type_#{a}", with: b
      choose_rating("pleasure_#{a}", c)
      choose_rating("accomplishment_#{a}", d)
      page.execute_script('window.scrollBy(0,500)')
    end

    click_on 'Next'

    %w(recent fun accomplished).zip([17, 5, 5]) do |x, y|
      within("##{x}_activities") do
        expect(page).to have_css('tr', count: y)
      end

      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Next'
    end

    find('h1', text: 'Do Landing')
  end

  scenario 'Participant cannot complete for time period already completed' do
    click_on '#1 Awareness'
    click_on 'Next'
    find('h1', text: 'Just a slide')
    click_on 'Next'
    within('#awake_period_start_time') do
      expect(page).to_not have_content "#{Date.today.prev_day.strftime('%a')}" \
                                       ' 7 AM'
    end

    within('#awake_period_end_time') do
      expect(page).to_not have_content "#{Date.today.prev_day.strftime('%a')}" \
                                       ' 10 PM'
    end
  end

  scenario 'Participant completes for time that overlaps days' do
    click_on '#1 Awareness'
    click_on 'Next'
    find('h1', text: 'Just a slide')
    click_on 'Next'
    select "#{Date.today.prev_day.strftime('%a')} 11 PM",
           from: 'awake_period_start_time'
    select "#{Date.today.strftime('%a')} 1 AM", from: 'awake_period_end_time'
    click_on 'Create'
    find('.alert-success', text: 'Awake Period saved')

    fill_in 'activity_type_0', with: 'Sleep'
    choose_rating('pleasure_0', 6)
    choose_rating('accomplishment_0', 1)
    page.execute_script('window.scrollBy(0,500)')
    click_on 'copy_1'
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Next'

    %w(recent fun accomplished).zip([3, 2, 1]) do |x, y|
      within("##{x}_activities") do
        expect(page).to have_css('tr', count: y)
      end

      click_on 'Next'
    end

    find('h1', text: 'Do Landing')
  end

  scenario 'Participant completes Planning module' do
    click_on '#2 Planning'
    click_on 'Next'
    plan_activity('New planned activity', 6, 3)
    page.execute_script('window.scrollBy(0,500)')
    plan_activity('Another planned activity', 4, 8)
    find('h1', text: 'OK...')
    click_on 'Next'
    within('#previous_activities') do
      expect(page).to have_css('tr', count: '6')
    end

    click_on 'Next'
    find('h1', text: 'Do Landing')
  end

  scenario 'Participant completes Reviewing module' do
    click_on '#3 Doing'
    click_on 'Next'
    find('h1', text: "Let's do this...")

    click_on 'Next'
    find('.btn.btn-success').click
    select '7', from: 'activity[actual_pleasure_intensity]'
    select '5', from: 'activity[actual_accomplishment_intensity]'
    page.execute_script('window.scrollBy(0,500)')
    accept_social
    expect(page).to have_content 'Activity saved'

    unless page.has_no_text?('You said you were going to')
      find('.btn.btn-danger').click
      fill_in 'activity[noncompliance_reason]', with: "I didn't have time"
      accept_social
      expect(page).to have_content 'Activity saved'
    end
  end

  scenario 'Participant completes Plan a New Activity module' do
    click_on 'Add a New Activity'
    plan_activity('New planned activity', 4, 3)
    expect(page).to have_content 'New planned activity'
  end

  scenario 'Participant navigates to Your Activities viz' do
    click_on 'Your Activities'
    expect(page)
      .to have_content "Daily Averages for #{Date.today.strftime('%b %d %Y')}"
  end

  scenario 'Participant collapses Daily Summaries in Your Activities viz' do
    click_on 'Your Activities'
    find('p', text: 'Average Accomplishment Discrepancy')
    click_on 'Daily Summaries'
    expect(page).to_not have_content 'Average Accomplishment Discrepancy'
  end

  scenario 'Participant navigates to previous day in Your Activities viz' do
    click_on 'Your Activities'
    find('h3', text: 'Daily Averages')
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Previous Day'
    prev_day = Date.today - 1
    expect(page)
      .to have_content "Daily Averages for #{prev_day.strftime('%b %d %Y')}"
  end

  scenario 'Participant views ratings of an activity in Your Activities viz' do
    click_on 'Your Activities'
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
    click_on 'Your Activities'
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
    click_on 'Your Activities'
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
