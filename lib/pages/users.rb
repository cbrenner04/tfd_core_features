# page object for Users
class User
  include Capybara::DSL

  def initialize(users)
    @user ||= users[:user]
    @password ||= users[:password]
  end

  def sign_in
    visit "#{ENV['Base_URL']}/users/sign_in"
    sign_out unless has_css?('#new_user')
    if has_css?('#new_user')
      within('#new_user') do
        fill_in 'user_email', with: @user
        fill_in 'user_password', with: @password
      end
      click_on 'Sign in'
      find('h1', text: 'Home')
    end
  end

  # this needs to be removed and anything that references it needs to be
  # updated to use the Participants object
  def sign_in_pt(participant, password)
    visit "#{ENV['Base_URL']}/participants/sign_in"
    sign_out unless has_css?('#new_participant')
    if has_css?('#new_participant')
      within('#new_participant') do
        fill_in 'participant_email', with: participant
        fill_in 'participant_password', with: password
      end
      click_on 'Sign in'
      has_text? 'HOME'
    else
      puts 'LOGIN FAILED'
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

  def check_data(item, data)
    within(item) { has_text? data }
  end
end
