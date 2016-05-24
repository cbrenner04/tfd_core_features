# filename: ./spec/features/user/core/researcher_groups_spec.rb

feature 'Researcher, Groups', :superfluous, :tfd, sauce: sauce_labs do
  if ENV['safari']
    background(:all) do
      users.sign_in_user(ENV['Researcher_Email'], 'participant2',
                         ENV['Researcher_Password'])
    end
  end

  background do
    unless ENV['safari']
      users.sign_in_user(ENV['Researcher_Email'], 'participant2',
                         ENV['Researcher_Password'])
    end

    visit "#{ENV['Base_URL']}/think_feel_do_dashboard/groups"
  end

  scenario 'Researcher creates a group' do
    click_on 'New'
    fill_in 'group_title', with: 'Testing Group'
    select 'Arm 2', from: 'group_arm_id'
    click_on 'Create'
    expect(page).to have_content 'Group was successfully created.'
  end

  scenario 'Researcher updates a group' do
    click_on 'Group 8'
    click_on 'Edit'
    fill_in 'group_title', with: 'Updated Group 8'
    click_on 'Update'
    find('.alert-success', text: 'Group was successfully updated.')
    expect(page).to have_content 'Title: Updated Group 8'
  end

  scenario 'Researcher destroys a group' do
    click_on 'Group 9'
    find('p', text: 'Title: Group 9')
    user_navigation.destroy
    find('.alert-success', text: 'Group was successfully destroyed.')
    expect(page).to_not have_content 'Group 9'
  end

  scenario 'Researcher assigns a task within a group' do
    click_on 'Group 11'
    click_on 'Manage Tasks'
    select 'LEARN: Do - Planning Slideshow 3 of 4',
           from: 'task_bit_core_content_module_id'
    fill_in 'task_release_day', with: '1'
    click_on 'Assign'
    expect(page).to have_content 'Task assigned.'
  end

  scenario 'Researcher nassigns a task within a group' do
    click_on 'Group 11'
    click_on 'Manage Tasks'
    user_navigation.scroll_to_bottom
    within('tr', text: 'Testing adding/updating slides/lessons') do
      user_navigation.confirm_with_js
      click_on 'Unassign'
    end

    within '#tasks' do
      expect(page).to_not have_content 'Testing adding/updating slides/lessons'
    end
  end

  scenario 'Researcher uses breadcrumbs to return to home' do
    user_navigation.go_back_to_home_page

    expect(user_navigation).to have_home_visible
  end
end
