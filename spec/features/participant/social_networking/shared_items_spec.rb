# frozen_string_literal: true
feature 'Shared items, Social arm', :social_networking, sauce: sauce_labs do
  feature 'THINK tool' do
    background(:all) { participant_1.sign_in if ENV['safari'] }

    background do
      participant_1.sign_in unless ENV['safari']
      visit think.landing_page
    end

    scenario 'Participant shares THINK > Identifying responses' do
      identifying.open
      participant_navigation.skip
      identifying.enter_thought('Now, your turn...', 'Public thought 1')
      social_networking.accept_social

      expect(think).to have_success_alert

      identifying.enter_thought('Now list another harmful thought...',
                                'Private thought 1')
      social_networking.decline_social

      expect(think).to have_success_alert

      visit ENV['Base_URL']
      identifying.find_in_feed 'Public thought 1'

      expect(identifying).to_not have_thought_visible 'Private thought 1'
      expect(identifying).to have_thought_visible 'Public thought 1'
      expect(identifying).to have_timestamp(
        thought: 'Public thought 1',
        timestamp: "Today at #{Time.now.strftime('%l')}"
      )
    end

    scenario 'Participant shares Add a New Harmful Thought responses' do
      add_new_thought.open
      add_new_thought.complete(
        thought: 'Public thought 3',
        pattern: 'Magnification or Catastrophizing',
        challenge: 'Testing challenge thought',
        action: 'Testing act-as-if action'
      )
      sleep(1)
      visit ENV['Base_URL']
      add_new_thought.find_in_feed

      expect(add_new_thought)
        .to have_timestamp(timestamp: "Today at #{Time.now.strftime('%-l')}")

      # check not sharing
      visit think.landing_page
      add_new_thought.open
      add_new_thought.enter_thought(
        thought: 'Private thought 2',
        pattern: 'Magnification or Catastrophizing',
        challenge: 'Testing challenge thought',
        action: 'Testing act-as-if action'
      )
      social_networking.decline_social
      participant_navigation.alt_next
      sleep(1)
      visit ENV['Base_URL']
      add_new_thought.find_in_feed 'Public thought 3'

      expect(add_new_thought).to_not have_thought_visible 'Private thought 2'
      expect(add_new_thought).to have_thought_visible 'Public thought 3'
    end
  end

  feature 'DO tool' do
    background(:all) { participant_1.sign_in if ENV['safari'] }

    background do
      participant_1.sign_in unless ENV['safari']
      visit do_tool.landing_page
    end

    scenario 'Participant shares DO > Planning responses' do
      planning.open
      participant_navigation.next
      planning.plan(
        activity: 'New public activity',
        pleasure: 6,
        accomplishment: 3
      )
      social_networking.accept_social

      expect(do_tool).to have_success_alert

      participant_navigation.scroll_to_bottom
      planning.plan(
        activity: 'New private activity',
        pleasure: 4,
        accomplishment: 8
      )
      social_networking.decline_social

      expect(do_tool).to have_success_alert

      planning.move_to_review

      expect(planning).to have_review_page_visible

      participant_navigation.scroll_down
      planning.finish
      visit ENV['Base_URL']
      planning.find_in_feed 'New public activity'

      expect(planning).to_not have_activity_visible 'New private activity'
      expect(planning).to have_activity_visible 'New public activity'
      expect(planning).to have_timestamp(
        activity: 'New public activity',
        timestamp: "Today at #{Time.now.strftime('%l')}"
      )
    end

    scenario 'Participant shares Add a New Activity responses' do
      plan_new_activity.open
      planning.plan(
        activity: 'New public activity 2',
        pleasure: 4,
        accomplishment: 3
      )
      social_networking.accept_social

      expect(do_tool).to have_success_alert
      expect(do_tool).to have_landing_visible

      visit ENV['Base_URL']
      plan_new_activity.find_in_feed('New public activity 2')

      expect(planning).to have_activity_visible 'New public activity 2'
      expect(planning).to have_timestamp(
        activity: 'New public activity 2',
        timestamp: "Today at #{Time.now.strftime('%l')}"
      )
    end

    scenario 'Participant does not share Add a New Activity responses' do
      plan_new_activity.open
      planning.plan(
        activity: 'New private activity 2',
        pleasure: 4,
        accomplishment: 3
      )
      social_networking.decline_social

      expect(do_tool).to have_success_alert

      visit ENV['Base_URL']
      plan_new_activity.find_in_feed('New public activity 2')

      expect(planning).to_not have_activity_visible 'New private activity 2'
      expect(planning).to have_activity_visible 'New public activity 2'
    end
  end
end

feature 'Shared items, Mobile arm', :social_networking, sauce: sauce_labs do
  feature 'THINK tool' do
    background(:all) { nonsocial_pt.sign_in if ENV['safari'] }

    background do
      nonsocial_pt.sign_in unless ENV['safari']
      visit think.landing_page
    end

    scenario 'Participant cannot create a shared item in Identifying' do
      identifying.open
      identifying.move_to_thought_input
      participant_navigation.next

      expect(social_networking).to_not have_share_options
    end

    scenario 'Participant cannot create in Add a New Harmful Thought' do
      identifying.open

      expect(social_networking).to_not have_share_options
    end
  end

  feature 'DO tool' do
    background(:all) { nonsocial_pt.sign_in if ENV['safari'] }

    background do
      nonsocial_pt.sign_in unless ENV['safari']
      visit do_tool.landing_page
    end

    scenario 'Participant cannot create a shared item in Awareness' do
      awareness.open
      participant_navigation.next

      start_time = "#{week_day(today)} 4 AM"
      end_time = "#{week_day(today)} 7 AM"

      awareness.create_time_period(start_time: start_time, end_time: end_time)

      expect(social_networking).to_not have_share_options
    end

    scenario 'Participant cannot create a shared item in Planning' do
      planning.open
      participant_navigation.next

      expect(planning).to have_planning_form_visible
      expect(social_networking).to_not have_share_options
    end

    scenario 'Participant cannot create shared item in Plan a New Activity' do
      plan_new_activity.open

      expect(plan_new_activity).to be_on_form
      expect(social_networking).to_not have_share_options
    end
  end
end

feature 'Shared items, Social arm', :social_networking, sauce: sauce_labs do
  background(:all) { participant_5.sign_in if ENV['safari'] }
  background { participant_5.sign_in unless ENV['safari'] }

  # TODO: this fails when run alone and if test suite overlaps an hour change
  scenario 'Participant shared DO > Reviewing responses' do
    visit do_tool.landing_page
    reviewing.open
    reviewing.move_to_review
    reviewing.review_completed_activity(pleasure: 7, accomplishment: 5)
    social_networking.accept_social

    expect(do_tool).to have_success_alert

    reviewing.review_incomplete_activity('I didn\'t have time')
    social_networking.decline_social

    expect(do_tool).to have_success_alert

    visit ENV['Base_URL']
    reviewing.find_in_feed 'Parkour'

    feed_item_details = {
      activity: 'Parkour',
      start_time: Time.now - (60 * 60 * 24),
      end_time: Time.now - (60 * 60 * 23),
      pleasure: 7,
      accomplishment: 5,
      predicted_pleasure: 9,
      predicted_accomplishment: 4
    }

    expect(reviewing).to have_feed_item_detail(feed_item_details)
    expect(reviewing).to have_nonsocial_incomplete_item
  end

  scenario 'Participant reads Lesson 1 and finds the related feed item' do
    visit learn_2.landing_page
    pt_5_lesson.read_lesson

    expect(pt_5_lesson).to have_read_record

    visit ENV['Base_URL']
    pt_5_lesson.find_in_feed
  end

  scenario 'Participant listens to a relax exercise & the related feed item' do
    visit relax.landing_page
    relax.open_autogenic_exercises
    relax.play_audio
    relax.finish
    visit ENV['Base_URL']
    relax.find_in_feed
  end

  scenario 'Participant shares THINK > Patterns responses' do
    visit think.landing_page
    patterns.open
    patterns.move_to_pattern_entry_form
    unless patterns.has_nothing_to_do?
      patterns.complete_two_thoughts
      visit ENV['Base_URL']
      social_networking.find_feed_item('Assigned a pattern to a Thought: ARG!')

      expect(patterns).to have_feed_detail(
        thought: 'ARG!',
        pattern: 'Personalization'
      )
    end
  end

  scenario 'Participant completes Reshape module responses' do
    visit "#{ENV['Base_URL']}/navigator/contexts/THINK"
    pt_5_reshape.open
    pt_5_reshape.move_to_reshape_form
    pt_5_reshape.reshape
    visit ENV['Base_URL']
    pt_5_reshape.find_in_feed

    expect(pt_5_reshape).to have_feed_details
  end
end
