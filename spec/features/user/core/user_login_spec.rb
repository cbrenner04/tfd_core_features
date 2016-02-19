# filename: ./spec/features/user/core/user_login_spec.rb

require './lib/content/clinician_dash_buttons'
require './lib/content/researcher_dash_buttons'
require './lib/content/super_user_dash_buttons'

feature 'User login', :core, sauce: sauce_labs do
  scenario 'User signs in' do
    sign_in_user(ENV['User_Email'], "#{moderator}", ENV['User_Password'])
    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'Visitor with bad creds fails to sign in' do
    visit "#{ENV['Base_URL']}/users/sign_in"

    if ENV['safari']
      sign_out("#{moderator}")
    end

    within('#new_user') do
      fill_in 'user_email', with: 'asdf@example.com'
      fill_in 'user_password', with: 'asdf'
    end

    click_on 'Sign in'
    expect(page).to have_content 'Invalid email address or password'
  end

  scenario 'Visitor visits a specific page' do
    visit ENV['Base_URL'] + '/think_feel_do_dashboard'
    expect(page).to have_content 'You need to sign in or sign up before ' \
                                 'continuing'
  end

  scenario 'Visitor views the intro slideshow' do
    visit "#{ENV['Base_URL']}/users/sign_in"
    click_on "Introduction to #{host_app}"
    click_on 'Done'
    expect(page).to have_content 'You need to sign in or sign up before ' \
                                 'continuing.'
  end

  scenario 'User uses the forgot password functionality' do
    visit "#{ENV['Base_URL']}/users/sign_in"
    click_on 'Forgot your password?'
    find('h2', text: 'Forgot your password?')

    within('#new_user') do
      fill_in 'user_email', with: ENV['User_Email']
    end

    click_on 'Send me reset password instructions'
    expect(page).to have_content 'You will receive an email with ' \
                                 'instructions on how to reset your ' \
                                 'password in a few minutes.'
  end

  scenario 'Super user uses brand link to return to home page' do
    if ENV['safari']
      visit "#{ENV['Base_URL']}/users/sign_in"
    else
      sign_in_user(ENV['User_Email'], "#{moderator}",
                   ENV['User_Password'])
    end

    click_on 'Arms'
    click_on 'Arm 1'
    click_on 'Manage Content'
    click_on 'Lesson Modules'
    expect(page).to have_content 'Listing'

    find('.navbar-brand').click
    expect(page).to have_content 'Arms'
  end
end

feature 'Authorization', :core, sauce: sauce_labs do
  feature 'Clinician' do
    if ENV['safari']
      background(:all) do
        sign_in_user(ENV['Clinician_Email'], "#{moderator}",
                     ENV['Clinician_Password'])
      end
    end

    background do
      unless ENV['safari']
        sign_in_user(ENV['Clinician_Email'], "#{moderator}",
                     ENV['Clinician_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard"
    end

    scenario 'Clinician sees correct landing page' do
      find('.list-group-item', text: 'Arms')
      expect(page)
        .to_not have_content "Groups\nCreate, update, delete, and associate " \
                             'groups with arms along with set moderators.' \
                             "\nParticipants\nCreate, update, and delete " \
                             'participants along with assigning them to ' \
                             "groups.\nUsers\nCreate and view super users, " \
                             'clinicians, researchers, and content authors.' \
                             "\nCSV Reports\nDownload data via csv."
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
      button_names = all('.btn').map(&:text)
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
    if ENV['safari']
      background(:all) do
        sign_in_user(ENV['Researcher_Email'], "#{moderator}",
                     ENV['Researcher_Password'])
      end
    end

    background do
      unless ENV['safari']
        sign_in_user(ENV['Researcher_Email'], "#{moderator}",
                     ENV['Researcher_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard"
    end

    scenario 'Researcher sees correct landing page' do
      expect(page)
        .to have_content "Arms\nNavigate to groups and participants " \
                         "through arms.\nGroups\nCreate, update, " \
                         'delete, and associate groups with arms ' \
                         "along with set moderators.\nParticipants" \
                         "\nCreate, update, and delete participants " \
                         "along with assigning them to groups.\nUsers" \
                         "\nCreate and view super users, clinicians, " \
                         "researchers, and content authors.\nCSV " \
                         "Reports\nDownload data via csv."
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
      button_names = all('.btn').map(&:text)
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
    if ENV['safari']
      background(:all) do
        sign_in_user(ENV['Content_Author_Email'], "#{moderator}",
                     ENV['Content_Author_Password'])
      end
    end

    background do
      unless ENV['safari']
        sign_in_user(ENV['Content_Author_Email'], "#{moderator}",
                     ENV['Content_Author_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard"
    end

    scenario 'Content Author sees correct landing page' do
      expect(page)
        .to_not have_content "Groups\nCreate, update, delete, and " \
                             'associate groups with arms along with ' \
                             "set moderators.\nParticipants\nCreate, " \
                             'update, and delete participants along ' \
                             "with assigning them to groups.\nUsers" \
                             "\nCreate and view super users, " \
                             'clinicians, researchers, and content ' \
                             "authors.\nCSV Reports\nDownload data " \
                             'via csv.'
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
    if ENV['safari']
      background(:all) do
        sign_in_user(ENV['User_Email'], "#{moderator}",
                     ENV['User_Password'])
      end
    end

    background do
      unless ENV['safari']
        sign_in_user(ENV['User_Email'], "#{moderator}",
                     ENV['User_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard"
    end

    scenario 'Super User sees correct landing page' do
      expect(page)
        .to have_content "Arms\nNavigate to groups and participants " \
                         "through arms.\nGroups\nCreate, update, " \
                         'delete, and associate groups with arms ' \
                         "along with set moderators.\nParticipants" \
                         "\nCreate, update, and delete participants " \
                         "along with assigning them to groups.\nUsers" \
                         "\nCreate and view super users, clinicians, " \
                         "researchers, and content authors.\nCSV " \
                         "Reports\nDownload data via csv."
    end

    scenario 'Super User can add arms' do
      click_on 'Arms'
      find('.list-group-item', text: 'Arm 1')
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
      button_names = all('.btn').map(&:text)
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
      button_names =  all('.btn').map(&:text)
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
