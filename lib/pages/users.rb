# page object for Users
class Users
  include Capybara::DSL

  def sign_in_user(user, old_user, password)
    visit "#{ENV['Base_URL']}/users/sign_in"
    unless page.has_css?('#new_user')
      sign_out(old_user)
    end
    if page.has_css?('#new_user')
      within('#new_user') do
        fill_in 'user_email', with: user
        fill_in 'user_password', with: password
      end
      click_on 'Sign in'
      expect(page).to have_content 'Home'
    end
  end

  def sign_out(display_name)
    tries ||= 2
    within('.navbar-collapse') do
      unless page.has_text?('Sign Out')
        if page.has_css?('a', text: display_name)
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
    unless page.has_text? module_text
      page.execute_script('window.scrollTo(0,5000)')
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
