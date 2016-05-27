# filename: ./spec/features/user/core/content_author_modules_spec.rb

require './spec/support/users/content_modules_helper'

feature 'Content Author, Content Modules',
        :superfluous, :core, sauce: sauce_labs do
  background(:all) { content_author.sign_in } if ENV['safari']

  background do
    content_author.sign_in unless ENV['safari']
    visit user_navigation.arms_page
    content_modules.navigate_to_content_modules
  end

  scenario 'Content Author creates a new module' do
    new_content_module.create

    expect(new_content_module).to be_created_successfully
  end

  scenario 'Content Author edits a module' do
    test_content_module.update

    expect(test_content_module).to be_updated_successfully
  end

  scenario 'Content Author destroys a module' do
    another_content_module.open_module
    user_navigation.destroy

    expect(another_content_module).to be_destroyed_successfully
  end

  scenario 'Content Author creates a provider' do
    home_intro_content_module.open_module
    new_content_provider.create

    expect(new_content_provider).to be_created_successfully
  end

  scenario 'Content Author updates a provider' do
    home_intro_content_module.open_module
    slideshow_content_provider.update

    expect(slideshow_content_provider).to be_updated_successfully
  end

  scenario 'Content Author destroys a provider' do
    final_content_module.open_module
    slideshow_content_provider.open_provider
    user_navigation.destroy

    expect(slideshow_content_provider).to be_destroyed_successfully
  end

  scenario 'Content Author uses breadcrumbs to return home' do
    user_navigation.return_to_arm
    user_navigation.go_back_to_arms_page
    user_navigation.go_back_to_home_page

    expect(user_navigation).to have_home_visible
  end
end
