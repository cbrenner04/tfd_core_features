# frozen_string_literal: true
# filename: ./spec/features/user/core/content_author_lessons_spec.rb

require './spec/support/users/lessons_helper'

feature 'Content Author, Lessons', :superfluous, :core, :marigold,
        sauce: sauce_labs do
  background(:all) { content_author.sign_in } if ENV['safari']

  background do
    content_author.sign_in unless ENV['safari']
    visit user_navigation.arms_page
    lessons.navigate_to_lessons
  end

  scenario 'Content Author creates a new lesson' do
    lessons.create

    expect(lessons).to be_created_successfully
  end

  scenario 'Content Author updates title of a lesson' do
    lessons_2.update

    expect(lessons_2).to be_updated_successfully
  end

  scenario 'Content Author destroys lesson' do
    user_navigation.scroll_to_bottom
    lessons_3.destory

    expect(lessons_3).to be_destroyed_successfully
  end

  scenario 'Content Author uses breadcrumbs to return home' do
    user_navigation.return_to_arm
    user_navigation.go_back_to_arms_page
    user_navigation.go_back_to_home_page

    expect(user_navigation).to have_home_visible
  end
end
