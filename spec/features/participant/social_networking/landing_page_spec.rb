# frozen_string_literal: true
# filename: ./spec/features/participant/social_networking/landing_page_spec.rb

require './spec/support/participants/social_networking_landing_helper'

feature 'SocialNetworking Landing Page',
        :social_networking, :marigold, sauce: sauce_labs do
  feature 'Social Arm' do
    background(:all) { participant_1.sign_in } if ENV['safari']

    background do
      participant_1.sign_in unless ENV['safari']
      visit ENV['Base_URL']

      expect(participant_navigation).to have_home_page_visible
    end

    scenario 'Participant creates a profile' do
      participant_navigation.scroll_down

      expect(participant_1_to_do_list).to have_profile_task

      participant_1_profile_1.visit_profile

      expect(participant_1_profile_1).to be_incomplete

      # check for character count when responding to profile question
      participant_1_profile_1.check_for_character_count
      participant_1_profile_1.check_for_updated_character_count

      # create profile
      participant_1_profile_1.create

      expect(participant_1_profile_1).to be_able_to_edit_question

      visit ENV['Base_URL']
      participant_1_profile_1.find_in_feed

      expect(participant_1_to_do_list).to_not have_profile_task
    end

    scenario 'Participant navigates to the profile page from not home' do
      visit do_tool.landing_page
      # close incentive notifications if they are there
      sn_landing_page_incentives.close_incentive_alerts
      participant_1_profile_2.navigate_to_profile

      expect(participant_1_profile_2).to be_visible
    end

    scenario 'Participant creates a whats on your mind post' do
      participant_navigation.scroll_down
      pt_1_on_the_mind.create

      expect(pt_1_on_the_mind).to be_in_feed
    end

    scenario 'Participant selects link in TODO list' do
      3.times { participant_navigation.scroll_down }
      participant_1_to_do_list.select_task

      expect(thought_viz).to be_visible
    end

    scenario 'Participant views another participants profile' do
      participant_1_profile_3.visit_another_participants_profile

      expect(participant_5_profile).to be_visible
    end

    scenario 'Participant likes a whats on your mind post' do
      philly_feed_item.like

      expect(philly_feed_item).to have_like_detail
    end

    scenario 'Participant comments on a nudge post' do
      nudge_feed_item.comment_and_check_for_character_count

      expect(nudge_feed_item).to have_comment_detail
    end

    scenario 'Participant checks for due date of a goal post' do
      social_networking.scroll_to_bottom_of_feed

      expect(goal_p2_alpha).to have_due_date
    end

    scenario 'Participant checks for an incomplete goal' do
      social_networking.scroll_to_bottom_of_feed
      participant_navigation.scroll_to_bottom

      expect(incomplete_goal).to be_visible_in_feed
    end

    scenario 'Pt does not see an incomplete goal for goal due 2 days ago' do
      social_networking.scroll_to_bottom_of_feed

      expect(two_day_old_incomplete_goal).to_not be_visible_in_feed
      expect(goal_due_two_days_ago).to be_visible_in_feed
    end
  end

  feature 'Resize window to mobile size', :browser do
    background(:all) { participant_1.sign_in if ENV['safari'] }

    background do
      participant_1.sign_in unless ENV['safari']
      visit ENV['Base_URL']
      participant_1.resize_to_mobile
      sleep(1)

      expect(to_do_list).to be_visible
    end

    after do
      participant_1.resize_to_desktop
    end

    scenario 'Participant is able to scroll for more feed items' do
      social_networking.scroll_to_bottom_of_feed

      expect(social_networking).to have_last_feed_item
    end

    scenario 'Participant returns to the home page and still sees the feed' do
      visit think.landing_page

      expect(think).to be_visible

      participant_navigation.open_mobile_menu
      participant_navigation.navigate_home

      expect(to_do_list).to be_visible

      social_networking.scroll_to_bottom_of_feed

      expect(social_networking).to have_last_feed_item
    end
  end

  feature 'To Do list' do
    scenario 'Participant complete last To Do, sees appropriate message' do
      participant_4.sign_in

      expect(participant_4_to_do_list).to have_profile_task
      expect(participant_4_to_do_list).to_not be_complete

      participant_4_profile.create_group_3_profile
      visit ENV['Base_URL']

      expect(participant_4_to_do_list).to_not have_profile_task
      expect(participant_4_to_do_list).to be_complete
    end
  end
end

feature 'SocialNetworking Landing Page', :tfdso, :browser, sauce: sauce_labs do
  feature 'Checks moderator' do
    scenario 'Participant does not see \'Last seen:\' for moderator' do
      participant_1.sign_in
      visit ENV['Base_URL']

      expect(participant_navigation).to have_home_page_visible
      expect(moderator_profile).to_not have_last_seen
    end
  end
end
