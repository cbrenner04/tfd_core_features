# filename: ./spec/features/participant/core/do_spec.rb

describe 'Active participant in group 1 signs in, navigates to DO tool,',
         :core, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_pt(ENV['Participant_Email'], 'participant1',
                 ENV['Participant_Password'])
    end
  end

  before do
    unless ENV['safari']
      sign_in_pt(ENV['Participant_Email'], 'participant1',
                 ENV['Participant_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/DO"
  end

  it 'completes Awareness' do
    click_on '#1 Awareness'
    click_on 'Next'
    find('h1', text: 'Just a slide')
    click_on 'Next'
    select "#{Date.today.prev_day.strftime('%a')} 7 AM",
           from: 'awake_period_start_time'
    select "#{Date.today.prev_day.strftime('%a')} 10 PM",
           from: 'awake_period_end_time'
    click_on 'Create'
    expect(page).to have_content 'Awake Period saved'

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

    table = ['recent', 'fun', 'accomplished']
    row = ['17', '5', '5']

    table.zip(row) do |x, y|
      within("##{x}_activities") do
        expect(page).to have_css('tr', count: y)
      end

      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Next'
    end

    find('h1', text: 'Do Landing')
  end

  it 'cannot complete Awareness for a time period already completed' do
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

  it 'completes Awareness for different time on same day that overlaps days' do
    click_on '#1 Awareness'
    click_on 'Next'
    find('h1', text: 'Just a slide')
    click_on 'Next'
    select "#{Date.today.prev_day.strftime('%a')} 11 PM",
           from: 'awake_period_start_time'
    select "#{Date.today.strftime('%a')} 1 AM", from: 'awake_period_end_time'
    click_on 'Create'
    expect(page).to have_content 'Awake Period saved'

    fill_in 'activity_type_0', with: 'Sleep'
    choose_rating('pleasure_0', 6)
    choose_rating('accomplishment_0', 1)
    page.execute_script('window.scrollBy(0,500)')
    click_on 'copy_1'
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Next'

    ['recent', 'fun', 'accomplished'].each do |x|
      find("##{x}_activities")
      click_on 'Next'
    end

    find('h1', text: 'Do Landing')
  end

  it 'completes Planning' do
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

  it 'completes Reviewing' do
    click_on '#3 Doing'
    click_on 'Next'
    expect(page).to have_content "Let's do this..."

    click_on 'Next'
    find('.btn.btn-success').click
    select '7', from: 'activity[actual_pleasure_intensity]'
    select '5', from: 'activity[actual_accomplishment_intensity]'
    page.execute_script('window.scrollBy(0,500)')
    accept_social
    expect(page).to have_content 'Activity saved'

    if page.has_text?('You said you were going to')
      find('.btn.btn-danger').click
      fill_in 'activity[noncompliance_reason]', with: "I didn't have time"
      accept_social
      expect(page).to have_content 'Activity saved'
    end
  end

  it 'completes Plan a New Activity' do
    click_on 'Add a New Activity'
    plan_activity('New planned activity', 4, 3)
  end

  it 'uses Your Activities viz' do
    click_on 'Your Activities'
    expect(page).to have_content 'Daily Averages for ' \
                                 "#{Date.today.strftime('%b %d %Y')}"

    expect(page).to have_content 'Average Accomplishment Discrepancy'

    click_on 'Daily Summaries'
    expect(page).to_not have_content 'Average Accomplishment Discrepancy'

    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Previous Day'
    expect(page).to have_content 'Daily Averages for ' \
                                 "#{Date.today.prev_day.strftime('%b %d %Y')}"

    page.execute_script('window.scrollTo(0,5000)')
    endtime = Time.now + (60 * 60)
    within('.panel.panel-default',
           text: "#{Time.now.strftime('%-l %P')} - " \
           "#{endtime.strftime('%-l %P')}: Parkour") do
      click_on "#{Time.now.strftime('%-l %P')} - " \
               "#{endtime.strftime('%-l %P')}: Parkour"
      expect(page).to have_content 'Predicted  Average Importance: 4 Really ' \
                                   'fun: 9'

      within('.collapse.in') do
        click_on 'Edit'
        expect(page).to have_css('#activity_actual_accomplishment_intensity')
      end
    end

    page.execute_script('window.scrollTo(0,100000)')
    click_on 'Next Day'
    expect(page).to have_content 'Daily Averages for ' \
                                 "#{Date.today.strftime('%b %d %Y')}"

    click_on 'Visualize'
    click_on 'Last 3 Days'
    date1 = Date.today - 2
    expect(page).to have_content date1.strftime('%A, %m/%d')

    click_on 'Day'
    expect(page).to have_css('#datepicker')
  end

  it 'visits View Planned Activities' do
    click_on 'View Planned Activities'
    find('.text-capitalize', text: 'View Planned Activities')
    expect(page).to have_content 'Speech'
  end

  it 'uses navbar functionality for all of DO' do
    visit "#{ENV['Base_URL']}/navigator/modules/339588004"
    expect(page).to have_content 'This is just the beginning...'

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

  it 'uses skip functionality in all of DO slideshows' do
    click_on '#1 Awareness'
    expect(page).to have_content 'This is just the beginning...'

    click_on 'Skip'
    expect(page).to have_content "OK, let's talk about yesterday."

    click_on 'DO'
    click_on '#2 Planning'
    expect(page).to have_content 'The last few times you were here...'

    click_on 'Skip'
    expect(page).to have_content 'We want you to plan one fun thing'

    click_on 'DO'
    click_on '#3 Doing'
    expect(page).to have_content 'Welcome back!'

    click_on 'Skip'
    unless page.has_text?('You said you were going to')
      expect(page).to have_content "It doesn't look like there are any " \
                                   'activities for you to review at this time'
    end
  end

  it 'sees Upcoming Activities on DO > Landing' do
    expect(page).to have_content 'Activities in your near future'
  end
end

describe 'Active participant in group 3 signs in, navigates to DO tool,',
         :core, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_pt(ENV['Alt_Participant_Email'], 'participant1',
                 ENV['Alt_Participant_Password'])
    end
  end

  before do
    unless ENV['safari']
      sign_in_pt(ENV['Alt_Participant_Email'], 'participant1',
                 ENV['Alt_Participant_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/DO"
  end

  it 'completes Awareness w/ already entered but not completed awake period' do
    click_on '#1 Awareness'
    click_on 'Next'
    find('h1', text: 'Just a slide')
    click_on 'Next'
    click_on 'Complete'

    activity = ['Get ready for work', 'Travel to work', 'Work']
    pleasure = [6, 2, 8]
    accomplishment = [7, 3, 9]

    (0..2).zip(activity, pleasure, accomplishment) do |a, b, c, d|
      fill_in "activity_type_#{a}", with: b
      choose_rating("pleasure_#{a}", c)
      choose_rating("accomplishment_#{a}", d)
      page.execute_script('window.scrollBy(0,500)')
    end

    click_on 'Next'

    ['recent', 'fun', 'accomplished'].each do |x|
      find("##{x}_activities")
      click_on 'Next'
    end

    find('h1', text: 'Do Landing')
  end

  it 'visits Reviewing from viz at bottom of DO > Landing' do
    expect(page).to have_content 'Recent Past Activities'

    click_on 'Edit'
    expect(page).to have_content 'You said you were going to'
  end
end
