# frozen_string_literal: true
# filename: ./spec/features/participant/social_networking/shared_items_spec.rb

require './spec/support/participants/shared_items_helper'

feature 'Shared items, Social arm',
        :social_networking, :marigold, sauce: sauce_labs do
  feature 'THINK tool' do
    background(:all) { participant_1.sign_in if ENV['safari'] }

    background do
      participant_1.sign_in unless ENV['safari']
      visit think.landing_page
    end

    scenario 'Participant shares THINK > Identifying responses' do
      pt_1_identify_thought_1.open
      participant_navigation.skip
      pt_1_identify_thought_1
        .enter_thought('Now, your turn...', 'Public thought 1')
      social_networking.accept_social

      expect(think).to have_success_alert

      pt_1_identify_thought_2
        .enter_thought('Now list another harmful thought...',
                       'Private thought 1')
      social_networking.decline_social

      expect(think).to have_success_alert

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
      pt_1_add_new_thought_1.find_in_feed

      expect(pt_1_add_new_thought_1).to have_timestamp
    end

    # dependent on previous spec, need to update
    scenario 'Participant does not share Add a New Harmful Thought response' do
      pt_1_add_new_thought_2.open
      pt_1_add_new_thought_2.enter_thought
      social_networking.decline_social
      participant_navigation.alt_next

      expect(think).to have_success_alert

      visit ENV['Base_URL']
      pt_1_add_new_thought_1.find_in_feed

      expect(pt_1_add_new_thought_2).to_not be_visible
      expect(pt_1_add_new_thought_1).to be_visible
    end
  end

  feature 'DO tool' do
    background(:all) { participant_1.sign_in if ENV['safari'] }

    background do
      participant_1.sign_in unless ENV['safari']
      visit do_tool.landing_page
    end

    scenario 'Participant shares DO > Planning responses' do
      pt_1_planning_1.open
      participant_navigation.next
      pt_1_planning_1.plan
      social_networking.accept_social

      expect(do_tool).to have_success_alert

      participant_navigation.scroll_to_bottom
      pt_1_planning_2.plan
      social_networking.decline_social

      expect(do_tool).to have_success_alert

      pt_1_planning_2.move_to_review

      expect(pt_1_planning_2).to have_review_page_visible

      participant_navigation.scroll_down
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
      pt_1_plan_new_2.open
      pt_1_plan_new_2.plan_activity
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
      participant_navigation.next

      expect(social_networking).to_not have_share_options

      ns_pt_identifying.enter_thought('Now list another', 'Test thought 1')
      participant_navigation.next

      expect(ns_pt_identifying).to have_final_slide
    end

    scenario 'Participant cannot create in Add a New Harmful Thought' do
      ns_pt_add_new_thought.open

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
      ns_pt_awareness.open
      participant_navigation.next
      ns_pt_awareness.create_time_period

      expect(social_networking).to_not have_share_options
    end

    scenario 'Participant cannot create a shared item in Planning' do
      ns_pt_planning.open
      participant_navigation.next

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
  background(:all) { participant_5.sign_in if ENV['safari'] }
  background { participant_5.sign_in unless ENV['safari'] }

  scenario 'Participant shared DO > Reviewing responses' do
    visit do_tool.landing_page
    pt_5_reviewing_1.open
    pt_5_reviewing_1.move_to_review
    pt_5_reviewing_1.review_completed_activity
    social_networking.accept_social

    expect(do_tool).to have_success_alert

    pt_5_reviewing_1.review_incomplete_activity
    social_networking.decline_social

    expect(do_tool).to have_success_alert

    visit ENV['Base_URL']
    pt_5_reviewing_1.find_in_feed

    # this fails in marigold
    expect(pt_5_reviewing_1).to have_feed_item_detail
    expect(pt_5_reviewing_2).to have_nonsocial_incomplete_item
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
    pt_5_pattern.open
    pt_5_pattern.move_to_pattern_entry_form
    unless pt_5_pattern.has_nothing_to_do?
      pt_5_pattern.complete_two_thoughts
      visit ENV['Base_URL']
      social_networking.find_feed_item('Assigned a pattern to a Thought: ARG!')

      expect(pt_5_pattern).to have_feed_detail
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
