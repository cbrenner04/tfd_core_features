# filename: ./spec/features/user/core/content_author_slideshows_spec.rb

require './lib/pages/users/slideshows'

def new_slideshow
  @new_slideshow ||= Users::Slideshows.new(title: 'Test slideshow')
end

def test_slideshow
  @test_slideshow ||= Users::Slideshows.new(
    title: 'Another testing slideshow',
    new_title: 'Holy cow!'
  )
end

def overkill_slideshow
  @overkill_slideshow ||= Users::Slideshows.new(title: 'Is this overkill?')
end

feature 'Content Author, Slideshows',
        :superfluous, :core, sauce: sauce_labs do
  background do
    content_author.sign_in unless ENV['safari']
    visit navigation.arms_page
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
    navigation.return_to_arm
    navigation.go_back_to_arms_page
    navigation.go_back_to_home_page

    expect(navigation).to have_home_visible
  end
end
