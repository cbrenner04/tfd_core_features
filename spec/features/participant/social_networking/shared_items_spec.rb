# filename: ./spec/features/participant/social_networking/shared_items_spec.rb

feature 'Shared items, Social arm',
        :social_networking, :marigold, sauce: sauce_labs do
  feature 'THINK tool' do
    background(:all) { participant_1_somc.sign_in if ENV['safari'] }

    background do
      participant_1_somc.sign_in unless ENV['safari']
      visit think.landing_page
    end

    scenario 'Participant shares THINK > Identifying responses' do
      pt_1_identify_thought_1.open
      navigation.skip
      pt_1_identify_thought_1
        .enter_thought('Now, your turn...', 'Public thought 1')
      social_networking.accept_social

      expect(think).to has_success_alert

      pt_1_identify_thought_2
        .enter_thought('Now list another harmful thought...',
                       'Private thought 1')
      social_networking.decline_social

      expect(think).to has_success_alert

      visit ENV['Base_URL']
      pt_1_identify_thought_1.find_in_feed

      expect(pt_1_identify_thought_2).to_not be_visible

      expect(pt_1_identify_thought_1).to be_visible

      expect(pt_1_identify_thought_1).to have_timestamp
    end

    scenario 'Participant shares Add a New Harmful Thought responses' do
      pt_1_add_new_thought_1.open
      pt_1_add_new_thought_1.complete
      visit ENV['Base_URL']

      expect(pt_1_add_new_thought_1).to be_visible

      pt_1_add_new_thought_1.find_in_feed

      expect(pt_1_add_new_thought_1).to have_timestamp
    end

    scenario 'Participant does not share Add a New Harmful Thought response' do
      pt_1_add_new_thought_2.open
      pt_1_add_new_thought_2.enter_thought
      social_networking.decline_social
      navigation.next

      expect(think).to have_success_alert

      navigation.scroll_to_bottom
      navigation.next

      expect(think).to be_visible

      visit ENV['Base_URL']
      pt_1_add_new_thought_1.find_in_feed

      expect(pt_1_add_new_thought_2).to_not be_visible

      expect(pt_1_add_new_thought_1).to be_visible
    end
  end

  feature 'DO tool' do
    background do
      participant_1_so1.sign_in unless ENV['safari']
      visit do_tool.landing_page
    end

    scenario 'Participant shares DO > Planning responses' do
      pt_1_planning_1.open
      navigation.next
      pt_1_planning_1.plan
      social_networking.accept_social

      expect(do_tool).to have_success_alert

      navigation.scroll_to_bottom
      pt_1_planning_2.plan
      social_networking.decline_social

      expect(do_tool).to have_success_alert

      pt_1_planning_2.move_to_review

      expect(pt_1_planning_2).to have_review_page_visible

      navigation.scroll_down
      pt_1_planning_2.finish

      visit ENV['Base_URL']
      pt_1_planning_1.find_in_feed

      expect(pt_1_planning_2).to_not be_visible

      expect(pt_1_planning_1).to be_visible

      expect(pt_1_planning_1).to have_timestamp
    end

    scenario 'Participant shares Add a New Activity responses' do
      pt_1_plan_new_1.open
      pt_1_plan_new_1.plan_activity
      social_networking.accept_social

      expect(do_tool).to have_success_alert

      expect(do_tool).to have_landing_visible

      visit ENV['Base_URL']
      pt_1_plan_new_1.find_in_feed

      expect(pt_1_plan_new_1).to be_visible

      expect(pt_1_plan_new_1).to have_timestamp
    end

    scenario 'Participant does not share Add a New Activity responses' do
      pt_1_plan_2.open
      pt_1_plan_2.plan_activity
      social_networking.decline_social

      expect(do_tool).to have_success_alert
      visit ENV['Base_URL']
      pt_1_plan_new_1.find_in_feed

      expect(pt_1_plan_new_2).to_not be_visible

      expect(pt_1_plan_new_1).to be_visible
    end
  end
end

feature 'Shared items, Mobile arm',
        :social_networking, :marigold, sauce: sauce_labs do
  feature 'THINK tool' do
    background(:all) { nonsocial_pt.sign_in if ENV['safari'] }

    background do
      nonsocial_pt.sign_in unless ENV['safari']
      visit think.landing_page
    end

    scenario 'Participant cannot create a shared item in Identifying' do
      ns_pt_identifying.open
      ns_pt_identifying.move_to_thought_input
      navgiation.next

      expect(social_networking).to_not have_share_options

      ns_pt_identifying.enter_thought('Now your turn...', 'Test thought 1')
      navigation.next

      expect(nw_pt_identifying).to have_second_thought_entry_form
    end

    scenario 'Participant cannot create in Add a New Harmful Thought' do
      ns_pt_add_new_thought.open

      expect(social_networking).to_not have_share_options
    end
  end

  feature 'DO tool' do
    background do
      nonsocial_pt_sons.sign_in unless ENV['safari']
      visit do_tool.landing_page
    end

    scenario 'Participant cannot create a shared item in Awareness' do
      ns_pt_awareness.open
      navigation.next
      ns_pt_awarens.create_time_period

      expect(social_networking).to_not have_share_options
    end

    scenario 'Participant cannot create a shared item in Planning' do
      ns_pt_planning.open
      navigation.next

      expect(ns_pt_planning).to have_planning_form_visible

      expect(social_networking).to_not have_share_options
    end

    scenario 'Participant cannot create shared item in Plan a New Activity' do
      ns_pt_add_new_activity.open

      expect(ns_pt_add_new_activity).to be_on_form

      expect(social_networking).to_not have_share_options
    end
  end
end

feature 'Shared items, Social arm',
        :social_networking, :marigold, sauce: sauce_labs do
  background(:all) { participant_5_sons.sign_in if ENV['safari'] }
  background { participant_5_sons.sign_in unless ENV['safari'] }

  scenario 'Participant shared DO > Reviewing responses' do
    visit do_tool.landing_page
    pt_5_reviewing_1.open
    pt_5_reviewing_1.move_to_review
    pt_5_reviewing_1.review_complete_activity
    social_networking.accept_social

    expect(do_tool).to have_success_alert

    pt_5_reviewing_1.review_incomplete_activity
    social_networking.decline_social

    expect(do_tool).to have_success_alert

    visit ENV['Base_URL']
    pt_5_reviewing_1.find_in_feed
    expect(pt_5_reviewing_1).to have_feed_item_detail

    expect(pt_5_reviewing_2).to_not be_visible
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
