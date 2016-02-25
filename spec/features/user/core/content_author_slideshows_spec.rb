# filename: ./spec/features/user/core/content_author_slideshows_spec.rb

feature 'Content Author, Slideshows',
        :superfluous, :core, sauce: sauce_labs do
  background do
    unless ENV['safari']
      users.sign_in_user(ENV['Content_Author_Email'], "#{moderator}",
                   ENV['Content_Author_Password'])
    end

    visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
    click_on 'Arm 1'
    click_on 'Manage Content'
    click_on 'Slideshows'
  end

  scenario 'Content Author creates a slideshow' do
    click_on 'New'
    fill_in 'slideshow_title', with: 'Test slideshow'
    click_on 'Create'
    find('.alert-success', text: 'Successfully created slideshow')
    expect(page).to have_content 'Test slideshow'
  end

  scenario 'Content Author updates slideshow' do
    find('h1', text: 'Listing Slideshows')
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Another testing slideshow'
    page.all('.btn.btn-default')[5].click
    fill_in 'slideshow_title', with: 'Holy cow!'
    click_on 'Update'
    find('.alert-success', text: 'Successfully updated slideshow')
    expect(page).to have_css('a', text: 'Holy cow!')
  end

  scenario 'Content Author destroys slideshow' do
    find('h1', text: 'Listing Slideshows')
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Is this overkill?'
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Delete'
    find('.alert-success', text: 'Slideshow deleted')
    expect(page).to_not have_content 'Is this overkill?'
  end

  scenario 'Content Author uses breadcrumbs to return home' do
    find('h1', text: 'Listing Slideshows')
    click_on 'Arm'
    within('.breadcrumb') do
      click_on 'Arms'
    end

    find('.list-group-item', text: 'Arm 3')
    within('.breadcrumb') do
      click_on 'Home'
    end

    expect(page).to have_content "Arms\nNavigate to groups and participants " \
                                 'through arms.'
  end
end
