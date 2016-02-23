# filename: ./spec/features/participant/social_networking/landing_page_spec.rb

require './spec/support/participants/social_networking_landing_helper'

feature 'SocialNetworking Landing Page',
        :social_networking, :marigold, sauce: sauce_labs do
  feature 'Social Arm' do
    background do
      participant_1_sog4.sign_in unless ENV['safari']
      visit ENV['Base_URL']
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
      expect(participant_1_to_do_list).to be_visible

      3.times { navigation.scroll_down }
      participant_1_to_do_list.select_task

      expect(thoughts).to be_visible
    end

    scenario 'Participant views another participants profile' do
      social_networking.visit_participant_5_profile

      expect(participant_5_profile).to be_visible
    end

    scenario 'Participant likes a whats on your mind post' do
      find('h1', text: 'HOME')
      find_feed_item('nudged participant1')
      navigation.scroll_to_bottom
      like("said it's always sunny in Philadelphia")
      within('.list-group-item.ng-scope',
             text: "said it's always sunny in Philadelphia") do
        find('.likes.ng-binding').click
        expect(page).to have_content 'participant1'
      end
    end

    scenario 'Participant comments on a nudge post' do
      find('h1', text: 'HOME')
      comment('nudged participant1', 'Sweet Dude!')
      within first('.list-group-item.ng-scope',
                   text: 'nudged participant1') do
        find('.comments.ng-binding').click
        expect(page).to have_content 'participant1: Sweet Dude!'
      end
    end

    scenario 'Participant checks for due date of a goal post' do
      find('h1', text: 'HOME')
      find_feed_item('nudged participant1')
      within first('.list-group-item.ng-scope', text: 'a Goal: p1 alpha') do
        navigation.scroll_to_bottom
        social_networking.open_detail
        expect(page)
          .to have_content "due #{Date.today.strftime('%b %d %Y')}"
      end
    end

    scenario 'Participant checks for an incomplete goal' do
      find('h1', text: 'HOME')
      find_feed_item('nudged participant1')
      navigation.scroll_to_bottom
      expect(page).to have_content 'Did Not Complete a Goal: due yesterday'
    end

    scenario 'Pt does not see an incomplete goal for goal due 2 days ago' do
      find('h1', text: 'HOME')
      find_feed_item('nudged participant1')
      expect(page).to_not have_content 'Did Not Complete a Goal: due two days' \
                                       ' ago'
      expect(page).to have_content 'a Goal: due two days ago'
    end
  end

  feature 'Resize window to mobile size' do
    background do
      participant_1_so1.sign_in unless ENV['safari']
      visit ENV['Base_URL']
      page.driver.browser.manage.window.resize_to(400, 800)
      page.execute_script('window.location.reload()')
    end

    after do
      page.driver.browser.manage.window.resize_to(1280, 743)
    end

    scenario 'Participant is able to scroll for more feed items' do
      find('.panel-title', text: 'To Do')
      find_feed_item('nudged participant1')

      expect(page).to have_content 'nudged participant1'
    end

    scenario 'Participant returns to the home page and still sees the feed' do
      visit "#{ENV['Base_URL']}/navigator/contexts/THINK"
      expect(page).to have_content 'Add a New Harmful Thought'

      find('#hamburger_button').click
      find('a', text: 'Home').click
      find('.panel-title', text: 'To Do')
      find_feed_item('nudged participant1')

      expect(page).to have_content 'nudged participant1'
    end
  end

  feature 'To Do list' do
    scenario 'Participant complete last To Do, sees appropriate message' do
      participant_4_so1.sign_in
      within('.panel.panel-default.ng-scope', text: 'To Do') do
        expect(page).to have_link 'Create a Profile'
        expect(page).to_not have_content 'You are all caught up! Great work!'
      end

      social_networking.visit_profile

      expect(page).to have_content 'Fill out your profile so other group ' \
                                   'members can get to know you!'

      2.times { navigation.scroll_down }
      answer_profile_question('What are your hobbies?', 'Running')

      visit ENV['Base_URL']
      navigation.confirm_with_js
      within('.panel.panel-default.ng-scope', text: 'To Do') do
        expect(page).to_not have_link 'Create a Profile'
        expect(page).to have_content 'You are all caught up! Great work!'
      end

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
    end

    scenario 'Participant does not see \'Last seen:\' for moderator' do
      find('h1', text: 'HOME')
      within('.col-xs-12.col-md-4.text-center.ng-scope', text: 'ThinkFeelDo') do
        expect('.profile-border.profile-last-seen')
          .to_not have_content 'Last seen:'
      end
    end
  end
end
