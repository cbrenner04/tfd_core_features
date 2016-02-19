# filename: ./spec/features/participant/social_networking/shared_items_spec.rb

feature 'Shared items, Social arm',
        :social_networking, :marigold, sauce: sauce_labs do
  feature 'THINK tool,' do
    if ENV['safari']
      background(:all) do
        sign_in_pt(ENV['Participant_Email'], 'mobilecompleter',
                   ENV['Participant_Password'])
      end
    end

    background do
      unless ENV['safari']
        sign_in_pt(ENV['Participant_Email'], 'mobilecompleter',
                   ENV['Participant_Password'])
      end

      visit "#{ENV['Base_URL']}/navigator/contexts/THINK"
    end

    scenario 'Participant shares THINK > Identifying responses' do
      click_on '#1 Identifying'
      click_on 'Skip'
      fill_in 'thought_content', with: 'Public thought 1'
      accept_social
      find('.alert-success', text: 'Thought saved')
      find('h2', text: 'Now list another harmful thought...')
      fill_in 'thought_content', with: 'Private thought 1'
      choose 'No'
      click_on 'Next'
      find('.alert-success', text: 'Thought saved')
      visit ENV['Base_URL']
      find_feed_item('Public thought 1')
      expect(page).to_not have_content 'Private thought'

      expect(page).to have_content 'Public thought 1'

      within('.list-group-item.ng-scope', text: 'Public thought 1') do
        expect(page).to have_content "Today at #{Time.now.strftime('%l')}"
      end
    end

    scenario 'Participant shares Add a New Harmful Thought responses' do
      click_on 'Add a New Harmful Thought'
      fill_in 'thought_content', with: 'Public thought 3'
      select 'Magnification or Catastrophizing', from: 'thought_pattern_id'
      fill_in 'thought_challenging_thought', with: 'Testing challenge thought'
      fill_in 'thought_act_as_if', with: 'Testing act-as-if action'
      page.execute_script('window.scrollTo(0,5000)')
      accept_social
      find('.alert-success', text: 'Thought saved')
      page.execute_script('window.scrollTo(0,5000)')
      find('.btn.btn-primary.pull-right').click
      find('.list-group-item', text: 'Add a New Harmful Thought')
      visit ENV['Base_URL']
      find_feed_item('Public thought 3')
      expect(page).to have_content 'Public thought 3'

      within('.list-group-item.ng-scope', text: 'Public thought 3') do
        expect(page).to have_content "Today at #{Time.now.strftime('%l')}"
      end
    end

    scenario 'Participant does not share Add a New Harmful Thought response' do
      click_on 'Add a New Harmful Thought'
      fill_in 'thought_content', with: 'Private thought 2'
      select 'Magnification or Catastrophizing', from: 'thought_pattern_id'
      fill_in 'thought_challenging_thought', with: 'Testing challenge thought'
      fill_in 'thought_act_as_if', with: 'Testing act-as-if action'
      choose 'No'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Next'
      find('.alert-success', text: 'Thought saved')
      page.execute_script('window.scrollTo(0,5000)')
      find('.btn.btn-primary.pull-right').click
      find('.list-group-item', text: 'Add a New Harmful Thought')
      visit ENV['Base_URL']
      find_feed_item('Public thought 1')
      expect(page).to_not have_content 'Private thought 2'

      expect(page).to have_content 'Public thought 1'
    end
  end

  feature 'DO tool,' do
    background do
      unless ENV['safari']
        sign_in_pt(ENV['Participant_Email'], 'participant1',
                   ENV['Participant_Password'])
      end

      visit "#{ENV['Base_URL']}/navigator/contexts/DO"
    end

    scenario 'Participant shares DO > Planning responses' do
      click_on '#2 Planning'
      click_on 'Next'
      plan_activity('New public activity', 6, 3)
      page.execute_script('window.scrollTo(0,5000)')
      find('#new_activity_radio').click
      fill_in 'activity_activity_type_new_title', with: 'New private activity'
      page.execute_script('window.scrollTo(0,5000)')
      find('.fa.fa-calendar').click
      pick_tomorrow
      choose_rating('pleasure_0', 4)
      choose_rating('accomplishment_0', 8)
      choose 'No'
      click_on 'Next'
      find('.alert-success', text: 'Activity saved')
      find('h1', text: 'OK...')
      click_on 'Next'
      find('h2', text: 'Your Planned Activities')
      page.execute_script('window.scrollBy(0,500)')
      click_on 'Next'
      find('h1', text: 'Do Landing')
      visit ENV['Base_URL']
      find_feed_item('New public activity')
      expect(page).to_not have_content 'New private activity'

      expect(page).to have_content 'New public activity'

      within('.list-group-item.ng-scope', text: 'New public activity') do
        expect(page).to have_content "Today at #{Time.now.strftime('%l')}"
      end
    end

    scenario 'Participant shares Add a New Activity responses' do
      click_on 'Add a New Activity'
      plan_activity('New public activity 2', 4, 3)
      find('h1', text: 'Do Landing')
      visit ENV['Base_URL']
      find_feed_item('New public activity 2')
      expect(page).to have_content 'New public activity 2'

      within('.list-group-item.ng-scope', text: 'New public activity 2') do
        expect(page).to have_content "Today at #{Time.now.strftime('%l')}"
      end
    end

    scenario 'Participant does not share Add a New Activity responses' do
      click_on 'Add a New Activity'
      find('#new_activity_radio')
      page.execute_script('window.scrollBy(0,500)')
      find('#new_activity_radio').click
      fill_in 'activity_activity_type_new_title', with: 'New private activity 2'
      page.execute_script('window.scrollTo(0,5000)')
      find('.fa.fa-calendar').click
      pick_tomorrow
      choose_rating('pleasure_0', 4)
      choose_rating('accomplishment_0', 3)
      choose 'No'
      click_on 'Next'
      find('.alert-success', text: 'Activity saved')
      visit ENV['Base_URL']
      find_feed_item('New public activity 2')
      expect(page).to_not have_content 'New private activity 2'

      expect(page).to have_content 'New public activity 2'
    end
  end
end

feature 'Shared items, Mobile arm',
        :social_networking, :marigold, sauce: sauce_labs do
  feature 'THINK tool' do
    if ENV['safari']
      background(:all) do
        sign_in_pt(ENV['NS_Participant_Email'], 'participant1',
                   ENV['NS_Participant_Password'])
      end
    end

    background do
      unless ENV['safari']
        sign_in_pt(ENV['NS_Participant_Email'], 'participant1',
                   ENV['NS_Participant_Password'])
      end

      visit "#{ENV['Base_URL']}/navigator/contexts/THINK"
    end

    scenario 'Participant cannot create a shared item in Identifying' do
      click_on '#1 Identifying'
      find('h1', text: 'You are what you think')
      ['Helpful thoughts are...', 'Harmful thoughts are:',
       'Some quick examples...'].each do |s|
        page.execute_script('window.scrollTo(0,5000)')
        click_on 'Next'
        find('h1', text: s)
      end

      click_on 'Next'
      expect(page).to_not have_content 'Share the content of this thought?'

      fill_in 'thought_content', with: 'Test thought 1'
      click_on 'Next'
      expect(page).to have_content 'Now list another harmful thought...'
    end

    scenario 'Participant cannot create in Add a New Harmful Thought' do
      click_on 'Add a New Harmful Thought'
      expect(page).to have_content 'Add A New Harmful Thought'

      expect(page).to_not have_content 'Share the content of this thought?'
    end
  end

  feature 'DO tool' do
    background do
      unless ENV['safari']
        sign_in_pt(ENV['NS_Participant_Email'], 'nonsocialpt',
                   ENV['NS_Participant_Password'])
      end

      visit "#{ENV['Base_URL']}/navigator/contexts/DO"
    end

    scenario 'Participant cannot create a shared item in Awareness' do
      click_on '#1 Awareness'
      click_on 'Next'
      select "#{Date.today.strftime('%a')} 4 AM",
             from: 'awake_period_start_time'
      select "#{Date.today.strftime('%a')} 7 AM", from: 'awake_period_end_time'
      click_on 'Create'
      expect(page).to_not have_content 'Share the content of this activity?'
    end

    scenario 'Participant cannot create a shared item in Planning' do
      click_on '#2 Planning'
      click_on 'Next'
      expect(page).to have_content 'We want you to plan one fun thing'

      expect(page).to_not have_content 'Share the content of this activity?'
    end

    scenario 'Participant cannot create shared item in Plan a New Activity' do
      click_on 'Add a New Activity'
      expect(page).to have_content "But you don't have to start from scratch,"

      expect(page).to_not have_content 'Share the content of this activity?'
    end
  end
end

feature 'Shared items, Social arm',
        :social_networking, :marigold, sauce: sauce_labs do
  if ENV['safari']
    background(:all) do
      sign_in_pt(ENV['Participant_5_Email'], 'nonsocialpt',
                 ENV['Participant_5_Password'])
    end
  end

  background do
    unless ENV['safari']
      sign_in_pt(ENV['Participant_5_Email'], 'nonsocialpt',
                 ENV['Participant_5_Password'])
    end
  end

  scenario 'Participant shared DO > Reviewing responses' do
    visit "#{ENV['Base_URL']}/navigator/contexts/DO"
    click_on '#3 Doing'
    click_on 'Next'
    find('h1', text: "Let's do this...")
    click_on 'Next'
    find('.btn.btn-success').click
    select '7', from: 'activity[actual_pleasure_intensity]'
    select '5', from: 'activity[actual_accomplishment_intensity]'
    page.execute_script('window.scrollBy(0,500)')
    accept_social
    find('.alert-success', text: 'Activity saved')
    find('.btn.btn-danger').click
    fill_in 'activity[noncompliance_reason]', with: "I didn't have time"
    within('.form-group', text: 'Share the content of this activity?') do
      choose 'No'
    end

    click_on 'Next'
    find('.alert-success', text: 'Activity saved')

    visit ENV['Base_URL']
    find_feed_item('Reviewed & Completed an Activity: Parkour')
    within('.list-group-item.ng-scope',
           text: 'Reviewed & Completed an Activity: Parkour') do
      page.execute_script('window.scrollBy(0,1000)')
      click_on 'More'
      time1 = Time.now - (60 * 60 * 24)
      time2 = Time.now - (60 * 60 * 23)
      expect(page)
        .to have_content "start: #{time1.strftime('%b. %-d, %Y at %-l')}"

      expect(page)
        .to have_content "end: #{time2.strftime('%b. %-d, %Y at %-l')}"

      expect(page)
        .to have_content "predicted accomplishment: 4\npredicted pleasure: " \
                         "9\nactual accomplishment: 5\nactual pleasure: 7"
    end

    expect(page).to_not have_content 'Reviewed & Completed an Activity: Loving'
  end

  scenario 'Participant reads Lesson 1 and finds the related feed item' do
    visit "#{ENV['Base_URL']}/navigator/contexts/LEARN"
    click_on 'Do - Awareness Introduction'
    expect(page).to have_content 'This is just the beginning...'
    click_on 'Next'
    click_on 'Finish'
    find('.list-group-item', text: "Read on #{Date.today.strftime('%b %d %Y')}")

    visit ENV['Base_URL']
    find_feed_item('Read a Lesson: Do - Awareness Introduction')
    expect(page).to have_content 'Read a Lesson: Do - Awareness Introduction'
  end

  scenario 'Participant listens to a relax exercise & the related feed item' do
    visit "#{ENV['Base_URL']}/navigator/contexts/RELAX"
    click_on 'Autogenic Exercises'
    within('.jp-controls') do
      find('.jp-play').click
    end

    click_on 'Next'
    find('h1', text: 'Home')

    visit ENV['Base_URL']
    find_feed_item('Listened to a Relaxation Exercise: Audio!')
    expect(page).to have_content 'Listened to a Relaxation Exercise: Audio!'
  end

  scenario 'Participant shares THINK > Patterns responses' do
    visit "#{ENV['Base_URL']}/navigator/contexts/THINK"
    click_on '#2 Patterns'
    click_on 'Next'
    find('p', text: "Let's start by")
    unless page.has_text?("You haven't listed any negative thoughts")
      thought_value = find('.panel-body.adjusted-list-group-item').text
      select 'Personalization', from: 'thought_pattern_id'
      compare_thought(thought_value)
      select 'Magnification or Catastrophizing', from: 'thought_pattern_id'
      page.execute_script('window.scrollBy(0,500)')
      accept_social
      find('.alert-success', text: 'Thought saved')
    end

    visit ENV['Base_URL']
    find_feed_item('Assigned a pattern to a Thought: ARG!')
    within first('.list-group-item.ng-scope',
                 text: 'Assigned a pattern to a Thought: ARG!') do
      page.execute_script('window.scrollBy(0,1000)')
      click_on 'More'

      expect(page).to have_content "this thought is: ARG!\nthought pattern:" \
                                   ' Personalization'
    end
  end

  scenario 'Participant completes Reshape module responses' do
    visit "#{ENV['Base_URL']}/navigator/contexts/THINK"
    click_on '#3 Reshape'
    click_on 'Next'
    find('h2', text: 'You said you had the following unhelpful thoughts:')
    click_on 'Next'
    find('p', text: 'Challenging a thought means')

    begin
      tries ||= 3
      click_on 'Next'
    rescue Selenium::WebDriver::Error::UnknownError
      page.execute_script('window.scrollBy(0,1000)')
      retry unless (tries -= 1).zero?
    end

    reshape('Example challenge', 'Example act-as-if')

    visit ENV['Base_URL']
    find_feed_item('Reshaped a Thought: I am useless')
    within('.list-group-item.ng-scope',
           text: 'Reshaped a Thought: I am useless') do
      page.execute_script('window.scrollBy(0,1000)')
      click_on 'More'

      expect(page).to have_content 'this thought is: I am useless' \
                                   "\nthought pattern: Labeling and" \
                                   " Mislabeling\nchallenging thought:" \
                                   ' Example challenge' \
                                   " \nas if action: Example act-as-if"
    end
    sign_out('participant5')
  end
end
