# filename: ./spec/features/user/social_networking/researcher_groups_spec.rb

describe 'Researcher signs in, navigates to Groups,',
         :superfluous, :social_networking, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_user(ENV['Researcher_Email'], "#{moderator}",
                   ENV['Researcher_Password'])
    end
  end

  before do
    unless ENV['safari']
      sign_in_user(ENV['Researcher_Email'], "#{moderator}",
                   ENV['Researcher_Password'])
    end

    visit "#{ENV['Base_URL']}/think_feel_do_dashboard/groups"
  end

  it 'creates a group' do
    click_on 'New'
    fill_in 'group_title', with: 'Testing Group'
    select 'Arm 1', from: 'group_arm_id'
    select ENV['User_Email'], from: 'group_moderator_id'
    click_on 'Create'
    expect(page).to have_content 'Group was successfully created.'
  end

  it 'updates a group' do
    click_on 'Group 8'
    click_on 'Edit'
    fill_in 'group_title', with: 'Updated Group 8'
    click_on 'Update'
    find('.alert-success', text: 'Group was successfully updated.')
    expect(page).to have_content 'Title: Updated Group 8'
  end

  it 'updates moderator for Group 9' do
    find('h1', text: 'Groups')
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Group 9'
    click_on 'Edit'
    select ENV['User_Email'], from: 'group_moderator_id'
    click_on 'Update'
    find('.alert-success', text: 'Group was successfully updated.')
    expect(page).to have_content "Coach/Moderator: #{ENV['User_Email']}"
  end

  it 'destroys a group' do
    find('h1', text: 'Groups')
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Group 10'
    find('p', text: 'Title: Group 10')
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    find('.alert-success', text: 'Group was successfully destroyed.')
    expect(page).to_not have_content 'Group 10'
  end

  it 'assigns a task within a group' do
    find('h1', text: 'Groups')
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Group 11'
    click_on 'Manage Tasks'
    select 'LEARN: Do - Planning Slideshow 3 of 4',
           from: 'task_bit_core_content_module_id'
    fill_in 'task_release_day', with: '1'
    click_on 'Assign'
    expect(page).to have_content 'Task assigned.'
  end

  it 'unassigns a task within a group' do
    find('h1', text: 'Groups')
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Group 11'
    click_on 'Manage Tasks'
    page.execute_script('window.scrollTo(0,5000)')
    within('tr', text: 'Testing adding/updating slides/lessons') do
      page.driver.execute_script('window.confirm = function() {return true}')
      click_on 'Unassign'
    end

    within '#tasks' do
      expect(page).to_not have_content 'Testing adding/updating slides/lesson'
    end
  end

  it 'uses breadcrumbs to return to home' do
    within('.breadcrumb') do
      click_on 'Home'
    end

    expect(page).to have_content 'Arms'
  end
end
