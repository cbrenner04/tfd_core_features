# page object for Participants
class Participants
  include Capybara::DSL

  def initialize(pt_arry)
    @participant ||= pt_arry[:participant]
    @old_participant ||= pt_arry[:old_participant]
    @password ||= pt_arry[:password]
    @display_name ||= pt_arry[:display_name]
  end

  def sign_in
    visit "#{ENV['Base_URL']}/participants/sign_in"
    unless page.has_css?('#new_participant')
      sign_out(@old_participant)
    end
    if page.has_css?('#new_participant')
      within('#new_participant') do
        fill_in 'participant_email', with: @participant
        fill_in 'participant_password', with: @password
      end
      click_on 'Sign in'
      expect(page).to have_content 'HOME'
    else
      puts 'LOGIN FAILED'
    end
  end

  def sign_out
    tries ||= 2
    within('.navbar-collapse') do
      unless has_text?('Sign Out')
        if has_css?('a', text: @display_name)
          find('a', text: @display_name).click
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
end
