# filename: ./spec/features/user/incentives/researcher_groups_spec.rb

require './lib/pages/users/arms'
require './lib/pages/users/groups'
require './lib/pages/users/incentives'

def arm_1
  @arm_1 ||= Users::Arms.new(title: 'Arm 1')
end

def group_1
  @group_1 ||= Users::Groups.new(title: 'Group 1')
end

def group_6
  @group_6 ||= Users::Groups.new(title: 'Group 6')
end

def group_9
  @group_9 ||= Users::Groups.new(title: 'Group 9')
end

def group_9_incentives
  @group_9_incentives ||= Users::Incentives.new(group: 'Group 9')
end

feature 'Incentive, Researcher', :superfluous, :incentives, sauce: sauce_labs do
  background(:all) { researcher.sign_in } if ENV['safari']

  background do
    researcher.sign_in unless ENV['safari']
    visit user_navigation.groups_page

    expect(group_1).to be_visible_in_listing

    user_navigation.scroll_down
  end

  scenario 'Researcher adds an individual incentive' do
    group_9.open
    group_9_incentives.manage
    group_9_incentives.create_individual_incentive

    expect(group_9_incentives).to have_created_individual_incentive
  end

  scenario 'Researcher is unable to edit scope, repeatable once its created' do
    group_9.open
    group_9_incentives.manage
    group_9_incentives.edit_individual_incentive

    expect { group_9_incentives.check_repeatable }
      .to raise_error(Capybara::ElementNotFound)
    expect { group_9_incentives.select_group_incentive }
      .to raise_error(Capybara::ElementNotFound)
    expect(group_9_incentives).to be_unable_to_edit_repeatable_scope
    expect(group_9_incentives).to be_unable_to_edit_group_scope
  end

  scenario 'Researcher can only choose valid options when creating behavior'

  scenario 'Researcher adds a behavior to an incentive' do
    group_9.open
    group_9_incentives.manage
    group_9_incentives.add_like_behavior

    expect(group_9_incentives).to have_added_like_behavior_successfully
  end

  scenario 'Researcher adds a repeatable individual incentive' do
    group_9.open
    group_9_incentives.manage
    group_9_incentives.create_repeatable_individual_incentive

    expect(group_9_incentives)
      .to have_created_repeatable_individual_incentive_successfully
  end

  scenario 'Researcher adds a behavior to a repeatable incentive' do
    group_9.open
    group_9_incentives.manage
    group_9_incentives.add_comment_behavior

    expect(group_9_incentives).to have_added_comment_behavior_successfully
  end

  scenario 'Researcher adds a group incentive' do
    group_9.open
    group_9_incentives.manage
    group_9_incentives.add_group_incentive

    expect(group_9_incentives).to have_created_group_incentive_successfully
  end

  scenario 'Researcher adds a partial group incentive'

  scenario 'Researcher adds a behavior to a group incentive' do
    group_9.open
    group_9_incentives.manage
    group_9_incentives.add_lesson_behavior

    expect(group_9_incentives).to have_added_lesson_behavior_successfully
  end

  scenario 'Researcher cannot destroy wo destroying linked behaviors' do
    group_9.open
    group_9_incentives.manage
    group_9_incentives.open_individual_goal_incentive
    group_9_incentives.destroy

    expect(group_9_incentives).to have_unable_to_delete_incentive_alert
  end

  scenario 'Researcher is unable to destroy behaviors that have data' do
    group_9.open
    group_9_incentives.manage
    group_9_incentives.open_individual_goal_incentive
    first('.list-group-item').click
    find('p', text: 'Action: SocialNetworking::Goal')
    group_9_incentives.destroy

    expect(page)
      .to have_content "Can't be destroyed because participant behaviors exist."
  end

  scenario 'Researcher is able to destroy behaviors and incentives' do
    group_6.open
    group_6_incentives.manage

    find('.list-group-item', text: 'Individual, like 3 feed items').click
    find('h1', text: 'Group 6 Incentive - like 3 feed items')
    3.times do
      2.times { user_navigation.scroll_down }
      first('.list-group-item').click

      expect(page).to have_content 'Action: SocialNetworking::Like'

      group_6_incentives.destroy

      expect(page).to have_content 'Behavior was successfully destroyed.'
    end

    group_6_incentives.destroy

    expect(page).to have_content 'Incentive was successfully removed.'
    expect(page).to_not have_css('.list-group-item',
                                 text: 'Individual, like 3 feed items')
  end
end

feature 'Incentives, Coach', :superfluous, :incentives, sauce: sauce_labs do
  background(:all) { clinician.sign_in } if ENV['safari']

  background do
    clinician.sign_in unless ENV['safari']
    visit user_navigation.arms_page
    arm_1.open
    user_navigation.scroll_down
    group_9.open
    group_9_incentives.manage
  end

  scenario 'Coach adds an individual incentive' do
    group_9_incentives.create_individual_incentive

    expect(group_9_incentives).to have_created_individual_incentive
  end

  scenario 'Coach is unable to edit scope and repeatable once its created' do
    group_9_incentives.edit_individual_incentive

    expect { group_9_incentives.check_repeatable }
      .to raise_error(Capybara::ElementNotFound)
    expect { group_9_incentives.select_group_incentive }
      .to raise_error(Capybara::ElementNotFound)
    expect(group_9_incentives).to be_unable_to_edit_repeatable_scope
    expect(group_9_incentives).to be_unable_to_edit_group_scope
  end

  scenario 'Coach adds a behavior to an incentive' do
    group_9_incentives.add_like_behavior

    expect(group_9_incentives).to have_added_like_behavior_successfully
  end

  scenario 'Coach adds a repeatable individual incentive' do
    group_9_incentives.create_repeatable_individual_incentive

    expect(group_9_incentives)
      .to have_created_repeatable_individual_incentive_successfully
  end

  scenario 'Coach adds a behavior to a repeatable incentive' do
    group_9_incentives.add_comment_behavior

    expect(group_9_incentives).to have_add_comment_behavior_successfully
  end

  scenario 'Coach adds a group incentive' do
    group_9_incentives.add_group_incentive

    expect(group_9_incentives).to have_created_group_incentive_successfully
  end

  scenario 'Coach adds a behavior to a group incentive' do
    group_9_incentives.add_lesson_behavior

    expect(group_9_incentives).to have_added_lesson_behavior_successfully
  end

  scenario 'Coach cannot destroy  w/o first destroying related behaviors' do
    group_9_incentives.open_individual_goal_incentive
    group_9_incentives.destroy

    expect(group_9_incentives).to have_unable_to_delete_incentive_alert
  end

  scenario 'Coach is unable to destroy behaviors that already have data' do
    group_9_incentives.open_individual_goal_incentive
    first('.list-group-item').click
    find('p', text: 'Action: SocialNetworking::Goal')
    group_9_incentives.destroy

    expect(page)
      .to have_content "Can't be destroyed because participant behaviors exist."
  end

  scenario 'Coach is able to destroy behaviors and incentives' do
    find('.list-group-item', text: 'Individual, like 3 feed items').click
    find('h1', text: 'Group 9 Incentive - like 3 feed items')
    2.times do
      2.times { user_navigation.scroll_down }
      first('.list-group-item').click

      expect(page).to have_content 'Action: SocialNetworking::Like'

      group_9_incentives.destroy

      expect(page).to have_content 'Behavior was successfully destroyed.'
    end

    group_9_incentives.destroy

    expect(page).to have_content 'Incentive was successfully removed.'
    expect(page).to_not have_css('.list-group-item',
                                 text: 'Individual, like 3 feed items')
  end
end
