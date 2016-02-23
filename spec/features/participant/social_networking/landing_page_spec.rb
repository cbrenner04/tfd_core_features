# filename: ./spec/features/participant/social_networking/landing_page_spec.rb

require './spec/support/participants/social_networking_landing_helper'

feature 'SocialNetworking Landing Page',
        :social_networking, :marigold, sauce: sauce_labs do
  feature 'Social Arm' do
    background do
      participant_1_sog4.sign_in unless ENV['safari']
      visit ENV['Base_URL']

      expect(navigation).to have_home_page_visible
    end

    scenario 'Participant creates a profile' do
      navigation.scroll_down

      expect(participant_1_to_do_list).to have_profile_task

      participant_1_profile.create

      expect(participant_1_profile).to be_able_to_edit_question

      visit ENV['Base_URL']
      participant_1_profile.find_in_feed

      expect(participant_1_to_do_list).to_not have_profile_task
    end

    scenario 'Participant navigates to the profile page from not home' do
      visit do_tool.landing_page
      participant_1_profile.navigate_to_profile

      expect(participant_1_profile).to be_visible
    end

    scenario 'Participant creates a whats on your mind post' do
      navigation.scroll_down
      pt_1_on_the_mind.create

      expect(pt_1_on_the_mind).to be_in_feed
    end

    scenario 'Participant selects link in TODO list' do
      3.times { navigation.scroll_down }
      participant_1_to_do_list.select_task

      expect(thoughts).to be_visible
    end

    scenario 'Participant views another participants profile' do
      participant_1_profile.visit_another_participants_profile

      expect(participant_5_profile).to be_visible
    end

    scenario 'Participant likes a whats on your mind post' do
      social_networking.scroll_to_bottom_of_feed
      navigation.scroll_to_bottom
      philly_feed_item.like

      expect(philly_feed_item).to have_like_detail
    end

    scenario 'Participant comments on a nudge post' do
      nudge_feed_item.comment

      expect(nudge_feed_item).to have_comment_detail
    end

    scenario 'Participant checks for due date of a goal post' do
      social_networking.scroll_to_bottom_of_feed

      expect(goal_p1_alpha).to have_due_date
    end

    scenario 'Participant checks for an incomplete goal' do
      social_networking.scroll_to_bottom_of_feed
      navigation.scroll_to_bottom

      expect(incomplete_goal).to be_visible_in_feed
    end

    scenario 'Pt does not see an incomplete goal for goal due 2 days ago' do
      social_networking.scroll_to_bottom_of_feed

      expect(two_day_old_incomplete_goal).to_not be_visible_in_feed

      expect(goal_due_two_days_ago).to be_visible_in_feed
    end
  end

  feature 'Resize window to mobile size' do
    background do
      participant_1_so1.sign_in unless ENV['safari']
      visit ENV['Base_URL']
      participant_1_so1.resize_to_mobile

      expect(to_do_list).to be_visible
    end

    after do
      participant_1_so1.resize_to_desktop
    end

    scenario 'Participant is able to scroll for more feed items' do
      social_networking.scroll_to_bottom_of_feed

      expect(social_networking).to have_last_feed_item
    end

    scenario 'Participant returns to the home page and still sees the feed' do
      visit think.landing_page

      expect(think).to be_visible

      navigation.open_mobile_menu
      navigation.navigate_home

      expect(to_do_list).to be_visible
      social_networking.scroll_to_bottom_of_feed

      expect(social_networking).to have_last_feed_item
    end
  end

  feature 'To Do list' do
    scenario 'Participant complete last To Do, sees appropriate message' do
      participant_4_so1.sign_in

      expect(participant_4_to_do_list).to have_profile_task

      expect(participant_4_to_do_list).to_not be_complete

      participant_4_profile.create_group_3_profile

      visit ENV['Base_URL']
      social_networking.confirm_with_js

      expect(participant_4_to_do_list).to_not have_profile_task

      expect(participant_4_to_do_list).to be_complete

      participant_4_so1.sign_out
    end
  end
end

feature 'SocialNetworking Landing Page', :tfdso, sauce: sauce_labs do
  feature 'Checks moderator' do
    background(:all) { participant_1_so4.sign_in if ENV['safari'] }

    background do
      participant_1_so4.sign_in unless ENV['safari']
      visit ENV['Base_URL']

      expect(navigation).to have_home_page_visible
    end

    scenario 'Participant does not see \'Last seen:\' for moderator' do
      expect(moderator_profile).to_not have_last_seen
    end
  end
end
