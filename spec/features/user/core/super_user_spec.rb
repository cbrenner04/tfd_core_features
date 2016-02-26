# filename: ./spec/features/user/core/super_user_spec.rb

feature 'Super User', :superfluous, :core, sauce: sauce_labs do
  if ENV['safari']
    background(:all) do
      users.sign_in_user(ENV['User_Email'], 'participant2',
                   ENV['User_Password'])
    end

    background do
      visit "#{ENV['Base_URL']}/think_feel_do_dashboard"
    end

  else
    background do
      users.sign_in_user(ENV['User_Email'], 'participant2',
                   ENV['User_Password'])
    end
  end

  scenario 'Super user creates an arm' do
    click_on 'Arms'
    click_on 'New'
    fill_in 'arm_title', with: 'Test Arm'
    click_on 'Create'
    expect(page).to have_content 'Arm was successfully created.'
  end

  scenario 'Super user updates an arm' do
    click_on 'Arms'
    click_on 'Testing Arm'
    click_on 'Edit'
    fill_in 'arm_title', with: 'Updated Testing Arm'
    click_on 'Update'
    find('.alert-success', text: 'Arm was successfully updated.')
    expect(page).to have_content 'Title: Updated Testing Arm'
  end

  scenario 'Super user sees appropriate alert when trying to destroy an arm' do
    click_on 'Arms'
    click_on 'Testing Arm 2'
    find('p', text: 'Title: Testing Arm 2')
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    expect(page).to have_content 'You do not have privileges to delete an ' \
                                 'arm. Please contact the site administrator ' \
                                 'to remove this arm.'
  end

  scenario 'Super user creates a super user' do
    click_on 'Users'
    click_on 'New'
    fill_in 'user_email', with: 'superuser@test.com'
    check 'user_is_admin'
    click_on 'Create'
    find('.alert-success', text: 'User was successfully created.')
    expect(page).to have_content "Super User: Yes\nEmail: superuser@test.com"
  end

  scenario 'Super user updates a super user' do
    click_on 'Users'
    click_on 'test_7@example.com'
    click_on 'Edit'
    check 'user_user_roles_clinician'
    click_on 'Update'
    find('.alert-success', text: 'User was successfully updated.')
    expect(page).to have_content "Super User: Yes\nEmail: test_7@example.com" \
                                 "\nRoles: Clinician"
  end

  scenario 'Super user destroys a super user' do
    click_on 'Users'
    click_on 'test_8@example.com'
    find('p', text: 'Email: test_8@example.com')
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    find('.alert-success', text: 'User was successfully destroyed.')
    expect(page).to_not have_content 'test_8@example.com'

    users.sign_out('admin1')
  end
end
