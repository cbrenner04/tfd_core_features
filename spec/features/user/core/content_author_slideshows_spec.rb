# frozen_string_literal: true
def new_slideshow
  Users::Slideshows.new(title: 'Test slideshow')
end

def test_slideshow
  Users::Slideshows.new(
    title: 'Another testing slideshow',
    new_title: 'Holy cow!'
  )
end

def overkill_slideshow
  Users::Slideshows.new(title: 'Is this overkill?')
end

feature 'Content Author, Slideshows',
        :superfluous, :core, :marigold, sauce: sauce_labs do
  background(:all) { content_author.sign_in } if ENV['safari']

  background do
    content_author.sign_in unless ENV['safari']
    visit user_navigation.arms_page
    test_slideshow.navigate_to_slideshows
  end

  scenario 'Content Author creates a slideshow' do
    new_slideshow.create

    expect(new_slideshow).to be_created_successfully
  end

  scenario 'Content Author updates slideshow' do
    test_slideshow.update

    expect(test_slideshow).to be_updated_successfully
  end

  scenario 'Content Author destroys slideshow' do
    overkill_slideshow.destroy

    expect(overkill_slideshow).to be_destroyed_successfully
  end

  scenario 'Content Author uses breadcrumbs to return home' do
    user_navigation.return_to_arm
    user_navigation.go_back_to_arms_page
    user_navigation.go_back_to_home_page

    expect(user_navigation).to have_home_visible
  end
end
