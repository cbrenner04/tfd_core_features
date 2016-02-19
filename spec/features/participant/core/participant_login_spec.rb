# filename: ./spec/features/participant/core/participant_login_spec.rb

feature 'Login', :core, :marigold, sauce: sauce_labs do
  scenario 'Participant signs in' do
    sign_in_pt(ENV['Participant_Email'], "#{moderator}",
               ENV['Participant_Password'])
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Participant uses brand link to get to home page' do
    unless ENV['safari']
      sign_in_pt(ENV['Participant_Email'], 'participant1',
                 ENV['Participant_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/LEARN"
    find('h1', text: 'Lessons Week 1')
    find(:css, '.navbar-brand').click
    expect(page).to have_content 'HOME'
  end

  scenario 'Participant signs out' do
    if ENV['safari']
      visit ENV['Base_URL']
    else
      sign_in_pt(ENV['Participant_Email'], 'participant1',
                 ENV['Participant_Password'])
    end

    sign_out('participant1')
    expect(page).to have_content 'You need to sign in or sign up before ' \
                                 'continuing.'
  end

  scenario 'Visitor is not able to log in with invalid creds' do
    visit "#{ENV['Base_URL']}/participants/sign_in"
    within('#new_participant') do
      fill_in 'participant_email', with: 'asdf@example.com'
      fill_in 'participant_password', with: 'asdf'
    end

    click_on 'Sign in'
    expect(page).to have_content 'Invalid email address or password'
  end

  scenario 'Participant who has withdrawn cannot sign in' do
    visit "#{ENV['Base_URL']}/participants/sign_in"
    within('#new_participant') do
      fill_in 'participant_email', with: ENV['Old_Participant_Email']
      fill_in 'participant_password', with: ENV['Old_Participant_Password']
    end

    click_on 'Sign in'
    expect(page).to have_content "We're sorry, but you can't sign in yet " \
                                 'because you are not assigned to an active ' \
                                 'group'
  end

  scenario 'Visitor tries to visit a specific page, is redirected to login' do
    visit "#{ENV['Base_URL']}/navigator/contexts/THINK"
    expect(page).to have_content 'You need to sign in or sign up before ' \
                                 'continuing'
  end

  scenario 'Visitor views the intro slideshow' do
    visit ENV['Base_URL']
    click_on "Introduction to #{host_app}"
    click_on 'Done'
    expect(page).to have_content 'You need to sign in or sign up before ' \
                                 'continuing.'
  end

  scenario 'Participant uses the forgot password functionality' do
    visit ENV['Base_URL']
    click_on 'Forgot your password?'
    find('h2', text: 'Forgot your password?')
    within('#new_participant') do
      fill_in 'participant_email', with: ENV['Participant_Email']
    end

    click_on 'Send me reset password instructions'
    expect(page).to have_content 'You will receive an email with ' \
                                 'instructions on how to reset your password ' \
                                 'in a few minutes.'
  end
end

feature 'Login', :tfd, sauce: sauce_labs do
  scenario 'Participant who has completed signs in' do
    sign_in_pt(ENV['Completed_Pt_Email'], 'participant1',
               ENV['Completed_Pt_Password'])
    find('h1', text: 'HOME')
    visit "#{ENV['Base_URL']}/navigator/contexts/MESSAGES"
    expect(page).to have_content 'Inbox'
    expect(page).to_not have_content 'Compose'
  end
end
