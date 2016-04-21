# page object for Participants
class Participants
  include Capybara::DSL

  def initialize(pt)
    @participant ||= pt[:participant]
    @password ||= pt[:password]
  end

  def login_page
    "#{ENV['Base_URL']}/participants/sign_in"
  end

  def fill_in_login_form
    within('#new_participant') do
      fill_in 'participant_email', with: @participant
      fill_in 'participant_password', with: @password
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
    within('#new_participant') do
      fill_in 'participant_email', with: @participant
    end
    click_on 'Send me reset password instructions'
  end

  def sign_in
    visit login_page
    sign_out unless has_css?('#new_participant')
    if has_css?('#new_participant')
      fill_in_login_form
      submit_login
      find('h1', text: 'HOME')
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
    find('#new_participant')
  rescue Capybara::ElementNotFound
    retry unless (tries -= 1).zero?
  end

  def resize_to_mobile
    page.driver.browser.manage.window.resize_to(400, 800)
    execute_script('window.location.reload()')
  end

  def resize_to_desktop
    page.driver.browser.manage.window.resize_to(1280, 743)
  end
end
