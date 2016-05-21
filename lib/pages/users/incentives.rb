module Users
  # page object for incentives
  class Incentives
    include RSpec::Matchers
    include Capybara::DSL

    def initialize(incentives)
      @group ||= incentives[:group]
    end

    def manage
      click_on 'Manage Incentives'
      find('h1', text: "#{@group} Incentives")
    end

    def create_individual_incentive
      click_new
      fill_in_description('complete a goal')
      select_image(11)
      submit_create
    end

    def submit_create
      if driver == :firefox
        click_on 'Create'
        accept_alert 'Please note that you will not be able to change SCOPE ' \
                     'and REPEATABLE. Please review and make sure everything ' \
                     'is correct. If you\'d like to proceed, hit OKAY. If ' \
                     'you\'d like review/edit before proceeding, hit CANCEL.'
      else
        user_navigation.confirm_with_js
        click_on 'Create'
      end
    end

    def has_created_individual_incentive?
      incentive_created_succesfully?('complete a goal', 11, 'Individual', 'No')
    end

    def edit_individual_incentive
      open_existing_incentive('like')
      click_on 'Edit'
    end

    def unable_to_edit_repeatable_scope?
      unable_to_edit_scope?('Repeatable')
    end

    def unable_to_edit_group_scope?
      unable_to_edit_scope?('Scope')
    end

    def check_repeatable
      check "#{app}_incentive[is_repeatable]"
    end

    def select_group_incentive
      select 'Group', from: "#{app}_incentive[scope]"
    end

    def add_like_behavior
      open_existing_incentive('Individual', 'like 3 feed items')
      add_behavior('Like an Item')
    end

    def has_added_like_behavior_successfully?
      behavior_created_succesfully?('SocialNetworking::Like', 'create')
    end

    def create_repeatable_individual_incentive
      click_new
      fill_in_description('comment on a post')
      check_repeatable
      select_image(10)
      submit_create
    end

    def has_created_repeatable_individual_incentive_successfully?
      incentive_created_succesfully?('comment on a post', 10, 'Individual',
                                     'Yes')
    end

    def add_comment_behavior
      open_existing_incentive('Individual', 'comment on 3 feed items')
      add_behavior('Comment on an Item')
    end

    def has_added_comment_behavior_successfully?
      behavior_created_successfully?('SocialNetworking::Comment', 'create')
    end

    def add_group_incentive
      click_new
      fill_in_description('read something')
      select_group_incentive
      select_image(9)
      group_9_incentives.submit_create
    end

    def has_created_group_incentive_successfully?
      incentive_created_succesfully?('read something', 9, 'Group', 'No')
    end

    def add_lesson_behavior
      open_existing_incentive('Group', 'read a lesson')
      add_behavior('Complete a Lesson')
    end

    def has_added_lesson_behavior_successfully?
      behavior_created_successfully?('TaskStatus', 'complete')
    end

    def destroy
      user_navigation.confirm_with_js
      click_on 'Destroy'
    end

    def open_individual_goal_incentive
      find('.list-group-item', text: 'Individual, create a goal').click
      find('h1', text: 'Group 9 Incentive - create a goal')
    end

    def has_unable_to_delete_incentive_alert?
      has_text? 'Behaviors exist. You can delete this ' \
                'incentive if all associated behaviors are removed.'
    end

    private

    def app
      if ENV['sunnyside']
        'sunnyside'
      elsif ENV['marigold']
        'marigold'
      end
    end

    def click_new
      click_on 'New'
    end

    def fill_in_description(description)
      fill_in "#{app}_incentive[description]", with: description
    end

    def select_image(image_number)
      within(".col-md-2:nth-child(#{image_number})") do
        choose("#{app}_incentive[image_url]")
      end
    end

    def incentive_created_succesfully?(incentive, img_number, scope, repeatable)
      has_css?('.alert-success', text: 'Incentive was successfully created.') &&
        has_css?('h1', text: "#{@group} Incentive - #{incentive}") &&
        has_xpath?("//img[@src='/assets/flower#{img_number}.png']") &&
        has_text?("Description: #{incentive}\nScope: #{scope}" \
                  "\nRepeatable: #{repeatable}")
    end

    def open_existing_incentive(scope, incentive)
      find('.list-group-item',
           text: "#{scope}, #{incentive}").click
    end

    def unable_to_edit_scope?(scope)
      find('.form-group', text: scope)
        .has_text?('this field is no longer editable')
    end

    def add_behavior(behavior)
      within('.well') { click_new }
      select behavior, from: 'Action Behavior and Condition'
      click_on 'Create'
    end

    def behavior_created_successfully?(behavior, condition)
      has_css?('.alert-success', text: 'Behavior was successfully created.') &&
        has_text?("Action: #{behavior}\nCondition: #{condition}")
    end
  end
end
