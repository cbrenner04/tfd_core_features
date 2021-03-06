# frozen_string_literal: true
# page object for Users
class User
  include Capybara::DSL

  def initialize(users)
    @user ||= users[:user]
    @password ||= users[:password]
  end

  def login_page
    "#{ENV['Base_URL']}/users/sign_in"
  end

  def fill_in_login_form
    within('#new_user') do
      fill_in 'user_email', with: @user
      fill_in 'user_password', with: @password
    end
  end

  def submit_login
    click_on 'Sign in'
  end

  def select_forgot_password
    click_on 'Forgot your password?'
  end

  def submit_forgot_password
    find('h2', text: 'Forgot your password?')
    within('#new_user') { fill_in 'user_email', with: @user }
    click_on 'Send me reset password instructions'
  end

  def sign_in
    visit login_page
    sign_out unless has_css?('#new_user')
    if has_css?('#new_user')
      fill_in_login_form
      submit_login
      find('h1', text: 'Home')
    end
  end

  def sign_out
    tries ||= 2
    within('.navbar-collapse') do
      all('.dropdown-toggle').last.click unless has_text?('Sign Out')
      click_on 'Sign Out'
    end
    find('#new_user')
  rescue Capybara::ElementNotFound
    retry unless (tries -= 1).zero?
  end
end
