# filename: ./spec/features/user/core/user_login_spec.rb

require './lib/content/clinician_dash_buttons'
require './lib/content/researcher_dash_buttons'
require './lib/content/super_user_dash_buttons'
require './lib/pages/users'
require './lib/pages/users/lessons'

def fake_user
  @fake_user ||= User.new(
    user: 'asdf@example.com',
    password: 'asdf'
  )
end

def login_lesson
  @login_lesson ||= Users::Lessons.new(lesson: 'fake')
end

def button_names
  all('.btn').map(&:text)
end

feature 'User login', :core, sauce: sauce_labs do
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

    expect(super_user).to have_password_reset_alert
  end

  scenario 'Super user uses brand link to return to home page' do
    if ENV['safari']
      visit super_user.login_page
    else
      super_user.sign_in
    end

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
      click_on 'Arms'
      click_on 'Arm 1'
      find('p', text: 'Title: Arm 1')
      if ENV['tfd'] || ENV['tfdso']
        expect(page).to_not have_content 'Manage Content'
      elsif ENV['sunnyside'] || ENV['marigold']
        expect(page).to_not have_content 'MANAGE CONTENT'
      end
    end

    scenario 'Clinician can access correct portions of group page' do
      click_on 'Arms'
      arm = ENV['tfd'] ? 3 : 1
      click_on "Arm #{arm}"
      num = ENV['tfd'] ? 5 : 1
      click_on "Group #{num}"
      find('p', text: "Title: Group #{num}")
      if ENV['tfd']
        expect(button_names).to match_array(ClinicianDashButtons::TFDGROUP)
      elsif ENV['tfdso']
        expect(button_names).to match_array(ClinicianDashButtons::TFDSOGROUP)
      elsif ENV['sunnyside'] || ENV['marigold']
        expect(button_names).to match_array(ClinicianDashButtons::SSGROUP)
      end

      if ENV['tfd'] || ENV['tfdso']
        expect(button_names).to_not match_array(ClinicianDashButtons::NOGROUP)
      elsif ENV['sunnyside'] || ENV['marigold']
        expect(button_names).to_not match_array(ClinicianDashButtons::SSNOGROUP)
      end
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
      click_on 'Arms'
      click_on 'Arm 1'
      find('p', text: 'Title: Arm 1')
      if ENV['tfd'] || ENV['tfdso']
        expect(page).to_not have_content 'Manage Content'
      elsif ENV['sunnyside'] || ENV['marigold']
        expect(page).to_not have_content 'MANAGE CONTENT'
      end
    end

    scenario 'Researcher can access correct portions of group page' do
      click_on 'Groups'
      num = ENV['tfd'] ? 5 : 1
      click_on "Group #{num}"
      find('p', text: "Title: Group #{num}")
      if ENV['tfd']
        expect(button_names).to_not match_array(ResearcherDashButtons::TFDGROUP)
      elsif ENV['tfdso']
        expect(button_names)
          .to_not match_array(ResearcherDashButtons::TFDSOGROUP)
      elsif ENV['sunnyside'] || ENV['marigold']
        expect(button_names).to_not match_array(ResearcherDashButtons::SSGROUP)
      end

      if ENV['tfd']
        expect(button_names).to match_array(ResearcherDashButtons::TFDGROUP2)
      elsif ENV['tfdso']
        expect(button_names).to match_array(ResearcherDashButtons::TFDSOGROUP2)
      elsif ENV['sunnyside'] || ENV['marigold']
        expect(button_names).to match_array(ResearcherDashButtons::SSGROUP2)
      end
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
      click_on 'Arms'
      click_on 'Arm 1'
      find('p', text: 'Title: Arm 1')
      if ENV['tfd'] || ENV['tfdso']
        expect(page).to have_content 'Manage Content'
      elsif ENV['sunnyside'] || ENV['marigold']
        expect(page).to have_content 'MANAGE CONTENT'
      end

      expect(page).to_not have_content 'Group 1'
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
      click_on 'Arms'
      find('h1', text: 'Arms')
      if ENV['tfd'] || ENV['tfdso']
        expect(page).to have_css('.btn.btn-primary', text: 'New')
      elsif ENV['sunnyside'] || ENV['marigold']
        expect(page).to have_css('.btn.btn-primary', text: 'NEW')
      end
    end

    scenario 'Super User has access all portions of Arm page' do
      click_on 'Arms'
      click_on 'Arm 1'
      find('p', text: 'Arm 1')
      if ENV['tfd'] || ENV['tfdso']
        expect(button_names).to match_array(SuperUserDashButtons::ARM)
      elsif ENV['sunnyside'] || ENV['marigold']
        expect(button_names).to match_array(SuperUserDashButtons::SSARM)
      end
    end

    scenario 'Super User has access all portions of Group page' do
      click_on 'Groups'
      num = ENV['tfd'] ? 5 : 1
      click_on "Group #{num}"
      find('p', text: "Title: Group #{num}")
      if ENV['tfd']
        expect(button_names).to match_array(SuperUserDashButtons::TFDGROUP)
      elsif ENV['tfdso']
        expect(button_names).to match_array(SuperUserDashButtons::TFDSOGROUP)
      elsif ENV['sunnyside'] || ENV['marigold']
        expect(button_names).to match_array(SuperUserDashButtons::SSGROUP)
      end
    end
  end
end
