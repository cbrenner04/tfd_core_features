# frozen_string_literal: true
feature 'User login', :core, :marigold, sauce: sauce_labs do
  scenario 'User signs in' do
    super_user.sign_in
    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'Visitor with bad creds fails to sign in' do
    visit super_user.login_page
    super_user.sign_out if ENV['safari']
    fake_user.fill_in_login_form
    fake_user.submit_login

    expect(user_navigation).to have_invalid_login
  end

  scenario 'Visitor visits a specific page' do
    visit user_navigation.dashboard

    expect(user_navigation).to have_sign_in_needed_alert
  end

  scenario 'Visitor views the intro slideshow' do
    visit super_user.login_page
    user_navigation.click_on_login_page_slideshow
    user_navigation.done

    expect(user_navigation).to have_sign_in_needed_alert
  end

  scenario 'User uses the forgot password functionality' do
    visit super_user.login_page
    super_user.select_forgot_password
    super_user.submit_forgot_password

    expect(user_navigation).to have_password_reset_alert
  end

  scenario 'Super user uses brand link to return to home page' do
    super_user.sign_in
    visit user_navigation.arms_page
    login_lesson.navigate_to_lessons

    expect(login_lesson).to be_visible

    user_navigation.click_brand

    expect(user_navigation).to have_home_visible
  end
end

feature 'Authorization', :core, sauce: sauce_labs do
  feature 'Clinician' do
    background(:all) { clinician.sign_in } if ENV['safari']

    background do
      clinician.sign_in unless ENV['safari']
      visit user_navigation.dashboard
    end

    scenario 'Clinician sees correct landing page' do
      expect(user_navigation).to have_home_visible
      expect(user_navigation).to_not have_all_home_navigation_options
    end

    scenario 'Clinician cannot manage content' do
      visit user_navigation.arms_page
      arm_1.open

      expect(arm_1).to be_visible
      expect(user_navigation).to_not have_manage_content_button
    end

    scenario 'Clinician can access correct portions of group page' do
      visit user_navigation.arms_page
      if ENV['tfd']
        arm_3.open
        group_5.open
      else
        arm_1.open
        group_1.open
      end

      expect(user_navigation).to have_clinician_dashboard_buttons
    end
  end

  feature 'Researcher' do
    background(:all) { researcher.sign_in } if ENV['safari']

    background do
      researcher.sign_in unless ENV['safari']
      visit user_navigation.dashboard
    end

    scenario 'Researcher sees correct landing page' do
      expect(user_navigation).to have_all_home_navigation_options
    end

    scenario 'Researcher cannot manage content' do
      visit user_navigation.arms_page
      arm_1.open

      expect(arm_1).to be_visible
      expect(user_navigation).to_not have_manage_content_button
    end

    scenario 'Researcher can access correct portions of group page' do
      visit user_navigation.groups_page
      ENV['tfd'] ? group_5.open : group_1.open

      expect(user_navigation).to have_researcher_dashboard_buttons
    end
  end

  feature 'Content Author' do
    background(:all) { content_author.sign_in } if ENV['safari']

    background do
      content_author.sign_in unless ENV['safari']
      visit user_navigation.dashboard
    end

    scenario 'Content Author sees correct landing page' do
      expect(user_navigation).to have_home_visible
      expect(user_navigation).to_not have_all_home_navigation_options
    end

    scenario 'Content Author can manage content' do
      visit user_navigation.arms_page
      arm_1.open

      expect(arm_1).to be_visible
      expect(user_navigation).to have_manage_content_button
      expect(group_1).to_not be_visible_in_listing
    end
  end

  feature 'Super User' do
    background(:all) { super_user.sign_in } if ENV['safari']

    background do
      super_user.sign_in unless ENV['safari']
      visit user_navigation.dashboard
    end

    scenario 'Super User sees correct landing page' do
      expect(user_navigation).to have_all_home_navigation_options
    end

    scenario 'Super User can add arms' do
      visit user_navigation.arms_page

      expect(user_navigation).to have_arm_creation_button
    end

    scenario 'Super User has access all portions of Arm page' do
      visit user_navigation.arms_page
      arm_1.open

      expect(arm_1).to be_visible
      expect(user_navigation).to have_super_user_arms_buttons
    end

    scenario 'Super User has access all portions of Group page' do
      visit user_navigation.groups_page
      ENV['tfd'] ? group_5.open : group_1.open

      expect(user_navigation).to have_super_user_groups_buttons
    end
  end
end
