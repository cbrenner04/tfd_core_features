# filename: participant_login_spec.rb

describe 'A visitor to the site,', type: :feature, sauce: sauce_labs do
  it 'is an active participant, signs in' do
    sign_in_pt(ENV['Participant_Email'], ENV['Participant_Password'])
    expect(page).to have_content 'Signed in successfully.'
  end

  it 'is an active participant, signs in, visits another page, uses ' \
     'brand link to get to home page' do
    unless ENV['Safari']
      sign_in_pt(ENV['Participant_Email'], ENV['Participant_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/LEARN"
    expect(page).to have_content 'Lessons'

    find(:css, '.navbar-brand').click
    expect(page).to have_content 'HOME'
  end

  it 'is an active participant, signs in, signs out' do
    if ENV['safari']
      visit ENV['Base_URL']
    else
      sign_in_pt(ENV['Participant_Email'], ENV['Participant_Password'])
    end

    sign_out
    expect(page).to have_content 'You need to sign in or sign up before ' \
                                 'continuing.'
  end

  it 'is not able to log in' do
    visit "#{ENV['Base_URL']}/participants/sign_in"
    within('#new_participant') do
      fill_in 'participant_email', with: 'asdf@example.com'
      fill_in 'participant_password', with: 'asdf'
    end

    click_on 'Sign in'
    expect(page).to have_content 'Invalid email address or password'
  end

  it 'was an active participant who has completed' do
    sign_in_pt(ENV['Completed_Pt_Email'], ENV['Completed_Pt_Password'])
    find('h1', text: 'HOME')
    visit "#{ENV['Base_URL']}/navigator/contexts/MESSAGES"
    expect(page).to have_content 'Inbox'
    expect(page).to_not have_content 'Compose'
  end

  it 'was an active participant who has withdrawn' do
    visit "#{ENV['Base_URL']}/participants/sign_in"
    if ENV['safari']
      sign_out
    end

    within('#new_participant') do
      fill_in 'participant_email', with: ENV['Old_Participant_Email']
      fill_in 'participant_password', with: ENV['Old_Participant_Password']
    end

    click_on 'Sign in'
    expect(page).to have_content "We're sorry, but you can't sign in yet " \
                                 'because you are not assigned to an active ' \
                                 'group'
  end

  it 'tries to visit a specific page, is redirected to log in page' do
    visit "#{ENV['Base_URL']}"
    if page.has_css?('.navbar-collapse', text: 'Sign Out')
      sign_out
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/THINK"
    expect(page).to have_content 'You need to sign in or sign up before ' \
                                 'continuing'
  end

  it 'views the intro slideshow' do
    visit "#{ENV['Base_URL']}"
    if page.has_css?('.navbar-collapse', text: 'Sign Out')
      sign_out
    end

    visit ENV['Base_URL']
    click_on 'Introduction to ThinkFeelDo'
    click_on 'Done'
    expect(page).to have_content 'You need to sign in or sign up before ' \
                                 'continuing.'
  end

  it 'is an active participant, uses the forgot password functionality' do
    visit "#{ENV['Base_URL']}"
    if page.has_css?('.navbar-collapse', text: 'Sign Out')
      sign_out
    end

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
