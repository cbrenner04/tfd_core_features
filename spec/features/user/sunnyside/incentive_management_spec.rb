# filename: ./spec/features/user/sunnyside/researcher_groups_spec.rb

describe 'Researcher signs in, navigates to Groups,',
         :superfluous, :sunnyside, type: :feature, sauce: sauce_labs do
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
    find('h1', text: 'Groups')
    page.execute_script('window.scrollBy(0,500)')
  end

  it 'adds an individual incentive' do
    click_on 'Group 9'
    click_on 'Manage Incentives'
    find('h1', text: 'Group 9 Incentives')
    click_on 'New'
    fill_in "#{app}_incentive[description]", with: 'complete a goal'
    within('.col-md-2:nth-child(11)') do
      choose("#{app}_incentive[image_url]")
    end

    if driver == :firefox
      click_on 'Create'
      accept_alert 'Please note that you will not be able to change SCOPE and' \
                   ' REPEATABLE. Please review and make sure everything is ' \
                   "correct. If you'd like to proceed, hit OKAY. If you'd " \
                   'like review/edit before proceeding, hit CANCEL.'
    else
      page.driver.execute_script('window.confirm = function() {return true}')
      click_on 'Create'
    end

    find('.alert-success', text: 'Incentive was successfully created.')
    expect(page).to have_css('h1', text: 'Group 9 Incentive - complete a goal')

    expect(page).to have_xpath("//img[@src='/assets/flower11.png']")

    expect(page).to have_content "Description: complete a goal\nScope: " \
                                 "Individual\nRepeatable: No"
  end

  it 'is unable to edit scope and repeatable once its created' do
    click_on 'Group 9'
    click_on 'Manage Incentives'
    find('h1', text: 'Group 9 Incentives')
    find('.list-group-item', text: 'Individual, like 3 feed items').click
    click_on 'Edit'
    within('.form-group', text: 'Repeatable') do
      expect { check "#{app}_incentive[is_repeatable]" }.to raise_error
      expect(page).to have_content 'this field is no longer editable'
    end

    within('.form-group', text: 'Scope') do
      expect { select 'Group', from: "#{app}_incentive[scope]" }.to raise_error
      expect(page).to have_content 'this field is no longer editable'
    end
  end

  it 'adds a behavior to an incentive' do
    click_on 'Group 9'
    click_on 'Manage Incentives'
    find('h1', text: 'Group 9 Incentives')
    find('.list-group-item', text: 'Individual, like 3 feed items').click
    within('.well') do
      click_on 'New'
    end

    select 'Like', from: "#{app}_behavior[action_type]"
    select 'Complete', from: "#{app}_behavior[condition]"
    click_on 'Create'
    find('.alert-success', text: 'Behavior was successfully created.')
    expect(page).to have_content 'Action: SocialNetworking::Like' \
                                 "\nCondition: complete"
  end

  it 'adds a repeatable individual incentive' do
    click_on 'Group 9'
    click_on 'Manage Incentives'
    find('h1', text: 'Group 9 Incentives')
    click_on 'New'
    fill_in "#{app}_incentive[description]", with: 'comment on a post'
    check "#{app}_incentive[is_repeatable]"
    within('.col-md-2:nth-child(10)') do
      choose("#{app}_incentive[image_url]")
    end

    if driver == :firefox
      click_on 'Create'
      accept_alert 'Please note that you will not be able to change SCOPE and' \
                   ' REPEATABLE. Please review and make sure everything is ' \
                   "correct. If you'd like to proceed, hit OKAY. If you'd " \
                   'like review/edit before proceeding, hit CANCEL.'
    else
      page.driver.execute_script('window.confirm = function() {return true}')
      click_on 'Create'
    end

    find('.alert-success', text: 'Incentive was successfully created.')
    expect(page).to have_css('h1',
                             text: 'Group 9 Incentive - comment on a post')

    expect(page).to have_xpath("//img[@src='/assets/flower10.png']")

    expect(page).to have_content "Description: comment on a post\nScope: " \
                                 "Individual\nRepeatable: Yes"
  end

  it 'adds a behavior to a repeatable incentive' do
    click_on 'Group 9'
    click_on 'Manage Incentives'
    find('h1', text: 'Group 9 Incentives')
    find('.list-group-item', text: 'Individual, comment on 3 feed items').click
    within('.well') do
      click_on 'New'
    end

    select 'Comment', from: "#{app}_behavior[action_type]"
    click_on 'Create'
    find('.alert-success', text: 'Behavior was successfully created.')
    expect(page).to have_content 'Action: SocialNetworking::Comment' \
                                 "\nCondition: create"
  end

  it 'adds a group incentive' do
    click_on 'Group 9'
    click_on 'Manage Incentives'
    find('h1', text: 'Group 9 Incentives')
    click_on 'New'
    fill_in "#{app}_incentive[description]", with: 'read something'
    select 'Group', from: "#{app}_incentive[scope]"
    within('.col-md-2:nth-child(9)') do
      choose("#{app}_incentive[image_url]")
    end

    if driver == :firefox
      click_on 'Create'
      accept_alert 'Please note that you will not be able to change SCOPE and' \
                   ' REPEATABLE. Please review and make sure everything is ' \
                   "correct. If you'd like to proceed, hit OKAY. If you'd " \
                   'like review/edit before proceeding, hit CANCEL.'
    else
      page.driver.execute_script('window.confirm = function() {return true}')
      click_on 'Create'
    end

    find('.alert-success', text: 'Incentive was successfully created.')
    expect(page)
      .to have_css('h1', text: 'Group 9 Incentive - read something')

    expect(page).to have_xpath("//img[@src='/assets/flower9.png']")

    expect(page).to have_content "Description: read something\nScope: " \
                                 "Group\nRepeatable: No"
  end

  it 'adds a behavior to a group incentive' do
    click_on 'Group 9'
    click_on 'Manage Incentives'
    find('h1', text: 'Group 9 Incentives')
    find('.list-group-item', text: 'Group, read a lesson').click
    within('.well') do
      click_on 'New'
    end

    select 'Lesson', from: "#{app}_behavior[action_type]"
    select 'Complete', from: "#{app}_behavior[condition]"
    click_on 'Create'
    find('.alert-success', text: 'Behavior was successfully created.')
    expect(page).to have_content "Action: TaskStatus\nCondition: complete"
  end

  it 'is unable to destroy incentive w/o first destroying related behaviors' do
    click_on 'Group 9'
    click_on 'Manage Incentives'
    find('h1', text: 'Group 9 Incentives')
    find('.list-group-item', text: 'Individual, create a goal').click
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    expect(page)
      .to have_content 'Behaviors exist. You can delete this ' \
                       'incentive if all associated behaviors are removed.'
  end

  it 'is unable to destroy behaviors that already have data' do
    click_on 'Group 9'
    click_on 'Manage Incentives'
    find('h1', text: 'Group 9 Incentives')
    find('.list-group-item', text: 'Individual, create a goal').click
    find('h1', text: 'Group 9 Incentive - create a goal')
    first('.list-group-item').click
    find('p', text: 'Action: SocialNetworking::Goal')
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    expect(page)
      .to have_content "Can't be destroyed because participant behaviors exist."
  end

  it 'is able to destroy behaviors and incentives' do
    click_on 'Group 6'
    click_on 'Manage Incentives'
    expect(page).to have_content 'Group 6 Incentives'

    find('.list-group-item', text: 'Individual, like 3 feed items').click
    find('h1', text: 'Group 6 Incentive - like 3 feed items')
    3.times do
      page.execute_script('window.scrollBy(0,1000)')
      first('.list-group-item').click
      expect(page).to have_content 'Action: SocialNetworking::Like'
      page.driver.execute_script('window.confirm = function() {return true}')
      click_on 'Destroy'
      expect(page).to have_content 'Behavior was successfully destroyed.'
    end

    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    expect(page).to have_content 'Incentive was successfully removed.'
    expect(page).to_not have_css('.list-group-item',
                                 text: 'Individual, like 3 feed items')
  end
end

describe 'Clinician signs in, navigates to Groups,',
         :superfluous, :sunnyside, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_user(ENV['Clinician_Email'], "#{moderator}",
                   ENV['Clinician_Password'])
    end
  end

  before do
    unless ENV['safari']
      sign_in_user(ENV['Clinician_Email'], "#{moderator}",
                   ENV['Clinician_Password'])
    end
    visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
    click_on 'Arm 1'
    find('h1', text: 'Arm')
    page.execute_script('window.scrollBy(0,500)')
    click_on 'Group 9'
    click_on 'Manage Incentives'
    find('h1', text: 'Group 9 Incentives')
  end

  it 'adds an individual incentive' do
    click_on 'New'
    fill_in "#{app}_incentive[description]", with: 'complete a goal'
    within('.col-md-2:nth-child(11)') do
      choose("#{app}_incentive[image_url]")
    end

    if driver == :firefox
      click_on 'Create'
      accept_alert 'Please note that you will not be able to change SCOPE and' \
                   ' REPEATABLE. Please review and make sure everything is ' \
                   "correct. If you'd like to proceed, hit OKAY. If you'd " \
                   'like review/edit before proceeding, hit CANCEL.'
    else
      page.driver.execute_script('window.confirm = function() {return true}')
      click_on 'Create'
    end

    find('.alert-success', text: 'Incentive was successfully created.')
    expect(page).to have_css('h1', text: 'Group 9 Incentive - complete a goal')

    expect(page).to have_xpath("//img[@src='/assets/flower11.png']")

    expect(page).to have_content "Description: complete a goal\nScope: " \
                                 "Individual\nRepeatable: No"
  end

  it 'is unable to edit scope and repeatable once its created' do
    find('.list-group-item', text: 'Individual, like 3 feed items').click
    click_on 'Edit'
    within('.form-group', text: 'Repeatable') do
      expect { check "#{app}_incentive[is_repeatable]" }.to raise_error
      expect(page).to have_content 'this field is no longer editable'
    end

    within('.form-group', text: 'Scope') do
      expect { select 'Group', from: "#{app}_incentive[scope]" }.to raise_error
      expect(page).to have_content 'this field is no longer editable'
    end
  end

  it 'adds a behavior to an incentive' do
    find('.list-group-item', text: 'Individual, like 3 feed items').click
    within('.well') do
      click_on 'New'
    end

    select 'Like', from: "#{app}_behavior[action_type]"
    select 'Complete', from: "#{app}_behavior[condition]"
    click_on 'Create'
    find('.alert-success', text: 'Behavior was successfully created.')
    expect(page).to have_content 'Action: SocialNetworking::Like' \
                                 "\nCondition: complete"
  end

  it 'adds a repeatable individual incentive' do
    click_on 'New'
    fill_in "#{app}_incentive[description]", with: 'comment on a post'
    check "#{app}_incentive[is_repeatable]"
    within('.col-md-2:nth-child(10)') do
      choose("#{app}_incentive[image_url]")
    end

    if driver == :firefox
      click_on 'Create'
      accept_alert 'Please note that you will not be able to change SCOPE and' \
                   ' REPEATABLE. Please review and make sure everything is ' \
                   "correct. If you'd like to proceed, hit OKAY. If you'd " \
                   'like review/edit before proceeding, hit CANCEL.'
    else
      page.driver.execute_script('window.confirm = function() {return true}')
      click_on 'Create'
    end

    find('.alert-success', text: 'Incentive was successfully created.')
    expect(page).to have_css('h1',
                             text: 'Group 9 Incentive - comment on a post')

    expect(page).to have_xpath("//img[@src='/assets/flower10.png']")

    expect(page).to have_content "Description: comment on a post\nScope: " \
                                 "Individual\nRepeatable: Yes"
  end

  it 'adds a behavior to a repeatable incentive' do
    find('.list-group-item', text: 'Individual, comment on 3 feed items').click
    within('.well') do
      click_on 'New'
    end

    select 'Comment', from: "#{app}_behavior[action_type]"
    click_on 'Create'
    find('.alert-success', text: 'Behavior was successfully created.')
    expect(page).to have_content 'Action: SocialNetworking::Comment' \
                                 "\nCondition: create"
  end

  it 'adds a group incentive' do
    click_on 'New'
    fill_in "#{app}_incentive[description]", with: 'read something'
    select 'Group', from: "#{app}_incentive[scope]"
    within('.col-md-2:nth-child(9)') do
      choose("#{app}_incentive[image_url]")
    end

    if driver == :firefox
      click_on 'Create'
      accept_alert 'Please note that you will not be able to change SCOPE and' \
                   ' REPEATABLE. Please review and make sure everything is ' \
                   "correct. If you'd like to proceed, hit OKAY. If you'd " \
                   'like review/edit before proceeding, hit CANCEL.'
    else
      page.driver.execute_script('window.confirm = function() {return true}')
      click_on 'Create'
    end

    find('.alert-success', text: 'Incentive was successfully created.')
    expect(page)
      .to have_css('h1', text: 'Group 9 Incentive - read something')

    expect(page).to have_xpath("//img[@src='/assets/flower9.png']")

    expect(page).to have_content "Description: read something\nScope: " \
                                 "Group\nRepeatable: No"
  end

  it 'adds a behavior to a group incentive' do
    find('.list-group-item', text: 'Group, read a lesson').click
    within('.well') do
      click_on 'New'
    end

    select 'Lesson', from: "#{app}_behavior[action_type]"
    select 'Complete', from: "#{app}_behavior[condition]"
    click_on 'Create'
    find('.alert-success', text: 'Behavior was successfully created.')
    expect(page).to have_content "Action: TaskStatus\nCondition: complete"
  end

  it 'is unable to destroy incentive w/o first destroying related behaviors' do
    find('.list-group-item', text: 'Individual, create a goal').click
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    expect(page)
      .to have_content 'Behaviors exist. You can delete this ' \
                       'incentive if all associated behaviors are removed.'
  end

  it 'is unable to destroy behaviors that already have data' do
    find('.list-group-item', text: 'Individual, create a goal').click
    find('h1', text: 'Group 9 Incentive - create a goal')
    first('.list-group-item').click
    find('p', text: 'Action: SocialNetworking::Goal')
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    expect(page)
      .to have_content "Can't be destroyed because participant behaviors exist."
  end

  it 'is able to destroy behaviors and incentives' do
    find('.list-group-item', text: 'Individual, like 3 feed items').click
    find('h1', text: 'Group 9 Incentive - like 3 feed items')
    2.times do
      page.execute_script('window.scrollBy(0,1000)')
      first('.list-group-item').click
      expect(page).to have_content 'Action: SocialNetworking::Like'
      page.driver.execute_script('window.confirm = function() {return true}')
      click_on 'Destroy'
      expect(page).to have_content 'Behavior was successfully destroyed.'
    end

    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    expect(page).to have_content 'Incentive was successfully removed.'
    expect(page).to_not have_css('.list-group-item',
                                 text: 'Individual, like 3 feed items')
  end
end

def app
  if ENV['sunnyside']
    'sunnyside'
  elsif ENV['marigold']
    'marigold'
  end
end
