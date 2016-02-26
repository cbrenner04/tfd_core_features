# filename: ./spec/features/user/core/researcher_users_spec.rb

feature 'Researcher, Users', :superfluous, :core, sauce: sauce_labs do
  background do
    unless ENV['safari']
      users.sign_in_user(ENV['Researcher_Email'], 'participant2',
                   ENV['Researcher_Password'])
    end

    visit "#{ENV['Base_URL']}/think_feel_do_dashboard/users"
  end

  scenario 'Researcher creates a researcher' do
    click_on 'New'
    fill_in 'user_email', with: 'researcher@test.com'
    check 'user_user_roles_researcher'
    click_on 'Create'
    find('.alert-success', text: 'User was successfully created.')
    expect(page).to have_content "Super User: No\nEmail: researcher@test.com" \
                                 "\nRoles: Researcher"
  end

  scenario 'Researcher adds a clinician role to a researcher' do
    click_on 'test_1@example.com'
    click_on 'Edit'
    check 'user_user_roles_clinician'
    click_on 'Update'
    find('.alert-success', text: 'User was successfully updated.')
    unless page.has_text?('Roles: Researcher and Clinician')
      expect(page).to have_content 'Roles: Clinician and Researcher'
    end
  end

  scenario 'Researcher destroys a researcher' do
    click_on 'test_2@example.com'
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    find('.alert-success', text: 'User was successfully destroyed.')
    expect(page).to_not have_content 'test_2@example.com'
  end

  scenario 'Researcher creates a clinician' do
    click_on 'New'
    fill_in 'user_email', with: 'clinician@test.com'
    check 'user_user_roles_clinician'
    click_on 'Create'
    find('.alert-success', text: 'User was successfully created.')
    expect(page).to have_content "Super User: No\nEmail: clinician@test.com" \
                                 "\nRoles: Clinician"
  end

  scenario 'Researcher adds a content author role to a clinician' do
    click_on 'test_3@example.com'
    click_on 'Edit'
    check 'user_user_roles_content_author'
    click_on 'Update'
    find('.alert-success', text: 'User was successfully updated.')
    unless page.has_text?('Roles: Content Author and Clinician')
      expect(page).to have_content 'Roles: Clinician and Content Author'
    end
  end

  scenario 'Researcher destroys a clinician' do
    click_on 'test_4@example.com'
    find('p', text: 'Email: test_4@example.com')
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    find('.alert-success', text: 'User was successfully destroyed.')
    expect(page).to_not have_content 'test_4@example.com'
  end

  scenario 'Researcher creates a content author' do
    click_on 'New'
    fill_in 'user_email', with: 'contentauthor@test.com'
    check 'user_user_roles_content_author'
    click_on 'Create'
    find('.alert-success', text: 'User was successfully created.')
    expect(page).to have_content 'Super User: No' \
                                 "\nEmail: contentauthor@test.com" \
                                 "\nRoles: Content Author"
  end

  scenario 'Researcher adds a clinician role to a content author' do
    click_on 'test_5@example.com'
    click_on 'Edit'
    check 'user_user_roles_clinician'
    click_on 'Update'
    find('.alert-success', text: 'User was successfully updated.')
    unless page.has_text?('Roles: Content Author and Clinician')
      expect(page).to have_content 'Roles: Clinician and Content Author'
    end
  end

  scenario 'Researcher destroys a content author' do
    click_on 'test_6@example.com'
    find('p', text: 'Email: test_6@example.com')
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    find('.alert-success', text: 'User was successfully destroyed.')
    expect(page).to_not have_content 'test_6@example.com'
  end

  scenario 'Researcher uses breadcrumbs to return to home' do
    first('.list-group-item').click
    find('p', text: 'Super User:')
    click_on 'Users'
    within('.breadcrumb') do
      click_on 'Users'
    end

    find('.list-group-item', text: 'admin1@example.com')
    within('.breadcrumb') do
      click_on 'Home'
    end

    expect(page).to have_content 'Arms'

    sign_out('participant2')
  end
end
