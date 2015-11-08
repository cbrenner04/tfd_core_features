# filename: ./spec/features/user/sunnyside/researcher_groups_spec.rb

describe 'Researcher signs in, navigates to Groups,',
         :sunnyside, type: :feature, sauce: sauce_labs do
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

  it 'adds an individual incentive' do
    find('h1', text: 'Groups')
    page.execute_script('window.scrollBy(0,500)')
    click_on 'Group 1'
    click_on 'Manage Incentives'
    expect(page).to have_content 'Group 1 Incentives'

    click_on 'New'
    fill_in "#{app}_incentive[description]", with: 'complete a goal'
    within('.col-md-2:nth-child(11)') do
      choose("#{app}_incentive[image_url]")
    end

    click_on 'Create'
    expect(page).to have_content 'Incentive was successfully created.'

    expect(page).to have_css('h1', text: 'Group 1 Incentive - complete a goal')

    expect(page).to have_xpath("//img[@src='/assets/flower11.png']")

    expect(page).to have_content "Description: complete a goal\nScope: " \
                                 "Individual\nRepeatable: No"

    within('.well') do
      click_on 'New'
    end

    select 'Complete', from: "#{app}_behavior[condition]"
    click_on 'Create'
    expect(page).to have_content 'Behavior was successfully created.'

    click_on 'Incentives - complete a goal'
    within('.well') do
      expect(page).to have_css('.list-group-item', text: 'Complete a goal')
    end

    click_on 'Group 1 Incentives'
    expect(page).to have_css('.list-group-item',
                             text: 'Individual, complete a goal')

    expect(page).to have_xpath("//img[@src='/assets/flower11.png']")
  end

  it 'adds a repeatable individual incentive' do
    find('h1', text: 'Groups')
    page.execute_script('window.scrollBy(0,500)')
    click_on 'Group 1'
    click_on 'Manage Incentives'
    expect(page).to have_content 'Group 1 Incentives'

    click_on 'New'
    fill_in "#{app}_incentive[description]", with: 'comment on a post'
    check "#{app}_incentive[is_repeatable]"
    within('.col-md-2:nth-child(10)') do
      choose("#{app}_incentive[image_url]")
    end

    click_on 'Create'
    expect(page).to have_content 'Incentive was successfully created.'

    expect(page).to have_css('h1',
                             text: 'Group 1 Incentive - comment on a post')

    expect(page).to have_xpath("//img[@src='/assets/flower10.png']")

    expect(page).to have_content "Description: comment on a post\nScope: " \
                                 "Individual\nRepeatable: Yes"

    within('.well') do
      click_on 'New'
    end

    select 'Comment', from: "#{app}_behavior[action_type]"
    click_on 'Create'
    expect(page).to have_content 'Behavior was successfully created.'

    click_on 'Incentives - comment on a post'
    within('.well') do
      expect(page).to have_css('.list-group-item',
                               text: "Comment on a person's shared content")
    end

    click_on 'Group 1 Incentives'
    expect(page).to have_css('.list-group-item',
                             text: 'Repeatable Individual, comment on a post')

    expect(page).to have_xpath("//img[@src='/assets/flower10.png']")
  end

  it 'adds a group incentive' do
    find('h1', text: 'Groups')
    page.execute_script('window.scrollBy(0,500)')
    click_on 'Group 1'
    click_on 'Manage Incentives'
    expect(page).to have_content 'Group 1 Incentives'

    click_on 'New'
    fill_in "#{app}_incentive[description]", with: 'read a lesson'
    select 'Group', from: "#{app}_incentive[scope]"
    within('.col-md-2:nth-child(9)') do
      choose("#{app}_incentive[image_url]")
    end

    click_on 'Create'
    expect(page).to have_content 'Incentive was successfully created.'

    expect(page).to have_css('h1',
                             text: 'Group 1 Incentive - read a lesson')

    expect(page).to have_xpath("//img[@src='/assets/flower9.png']")

    expect(page).to have_content "Description: read a lesson\nScope: " \
                                 "Group\nRepeatable: No"

    within('.well') do
      click_on 'New'
    end

    select 'Lesson', from: "#{app}_behavior[action_type]"
    select 'Complete', from: "#{app}_behavior[condition]"
    click_on 'Create'
    expect(page).to have_content 'Behavior was successfully created.'

    click_on 'Incentives - read a lesson'
    within('.well') do
      expect(page).to have_css('.list-group-item', text: 'Complete a lesson')
    end

    click_on 'Group 1 Incentives'
    expect(page).to have_css('.list-group-item', text: 'Group, read a lesson')

    expect(page).to have_xpath("//img[@src='/assets/flower9.png']")
  end

  it 'is unable to destroy incentive w/o first destroying related behaviors' do
    find('h1', text: 'Groups')
    page.execute_script('window.scrollBy(0,500)')
    click_on 'Group 1'
    click_on 'Manage Incentives'
    expect(page).to have_content 'Group 1 Incentives'

    find('.list-group-item', text: 'Individual, like 3 feed items').click
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    expect(page)
      .to have_content 'Behaviors exist. You can delete this ' \
                       'incentive if all associated behaviors are removed.'
  end

  it 'is unable to destroy behaviors that already have data' do
    find('h1', text: 'Groups')
    page.execute_script('window.scrollBy(0,500)')
    click_on 'Group 1'
    click_on 'Manage Incentives'
    expect(page).to have_content 'Group 1 Incentives'

    find('.list-group-item', text: 'Individual, like 3 feed items').click
    find('h1', text: 'Group 1 Incentive - like 3 feed items')
    first('.list-group-item').click
    expect(page).to have_content 'Action: SocialNetworking::Like'

    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    expect(page)
      .to have_content "Can't be destroyed because participant behaviors exist."
  end

  it 'is able to destroy behaviors and incentives' do
    find('h1', text: 'Groups')
    page.execute_script('window.scrollBy(0,500)')
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

def app
  if ENV['sunnyside']
    'sunnyside'
  elsif ENV['marigold']
    'marigold'
  end
end
