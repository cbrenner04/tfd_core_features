# page object for Users
class Users
  include Capybara::DSL

  def sign_in_user(user, old_user, password)
    visit "#{ENV['Base_URL']}/users/sign_in"
    unless page.has_css?('#new_user')
      sign_out(old_user)
    end
    if has_css?('#new_user')
      within('#new_user') do
        fill_in 'user_email', with: user
        fill_in 'user_password', with: password
      end
      click_on 'Sign in'
      has_text? 'Home'
    end
  end

  def sign_in_pt(participant, old_participant, password)
    visit login_page
    unless page.has_css?('#new_participant')
      private_sign_out(old_participant)
    end
    if page.has_css?('#new_participant')
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

  def sign_out(display_name)
    tries ||= 2
    within('.navbar-collapse') do
      unless has_text?('Sign Out')
        if has_css?('a', text: display_name)
          find('a', text: display_name).click
        else
          find('.fa.fa-user.fa-lg').click
        end
      end
      click_on 'Sign Out'
    end
    find('#participant_email')
  rescue Capybara::ElementNotFound
    retry unless (tries -= 1).zero?
  end

  def select_patient(patient)
    within('#patients', text: patient) do
      click_on patient
    end
  end

  def check_data(item, data)
    within(item) do
      expect(page).to have_content data
    end
  end

  def go_to_next_page(module_text)
    unless has_text? module_text
      execute_script('window.scrollTo(0,5000)')
      within('.pagination') do
        click_on 'Next'
      end
    end
  end

  def moderator
    'participant2'
  end

  def host_app
    if ENV['tfd'] || ENV['tfdso']
      'ThinkFeelDo'
    elsif ENV['sunnyside']
      'Sunnyside'
    elsif ENV['marigold']
      'Marigold'
    end
  end
end
