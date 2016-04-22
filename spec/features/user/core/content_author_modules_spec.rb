# filename: ./spec/features/user/core/content_author_modules_spec.rb

feature 'Content Author, Content Modules',
        :superfluous, :core, sauce: sauce_labs do
  background do
    unless ENV['safari']
      users.sign_in_user(ENV['Content_Author_Email'], 'participant2',
                         ENV['Content_Author_Password'])
    end

    visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
    click_on 'Arm 1'
    click_on 'Manage Content'
    click_on 'Content Modules'
  end

  scenario 'Content Author creates a new module' do
    click_on 'New'
    fill_in 'content_module_title', with: 'Test content module'
    select 'THINK', from: 'content_module_bit_core_tool_id'
    fill_in 'content_module_position', with: '8'
    click_on 'Create'
    expect(page).to have_content 'Content module was successfully created.'
  end

  scenario 'Content Author edits a module' do
    find('h1', text: 'Listing Content Modules')
    page.execute_script('window.scrollTo(0,5000)')
    users.go_to_next_page('Testing content module')
    click_on 'Testing content module'
    find('p', text: 'DO')
    click_on 'Edit'
    select 'THINK', from: 'content_module_bit_core_tool_id'
    fill_in 'content_module_position', with: '9'
    click_on 'Update'
    find('.alert-success', text: 'Content module was successfully updated.')
    expect(page).to have_content 'Tool: THINK'
  end

  scenario 'Content Author destroys a module' do
    users.go_to_next_page('Content module for Testing')
    click_on 'Content module for Testing'
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    find('.alert-success', text: 'Content module along with any associated ' \
         'tasks were successfully destroyed.')

    expect(page).to_not have_content 'Content module for Testing'
  end

  scenario 'Content Author creates a provider' do
    find('h1', text: 'Listing Content Modules')
    page.execute_script('window.scrollTo(0,5000)')
    users.go_to_next_page('Home Introduction')
    click_on 'Home Introduction'
    click_on 'New Provider'
    find('#content_provider_bit_core_content_module_id',
         text: 'LEARN: Home Introduction')
    select 'Bit Core Content Providers Slideshow Provider',
           from: 'content_provider_type'
    select 'BitCore::Slideshow', from: 'content_provider_source_content_type'
    select 'Home Intro', from: 'content_provider_source_content_id'
    fill_in 'content_provider_position', with: '4'
    page.execute_script('window.scrollBy(0,500)')
    check 'content_provider_show_next_nav'
    check 'content_provider_is_skippable_after_first_viewing'
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Create'
    expect(page).to have_content 'ContentProvider was successfully created.'
    expect(page).to have_content "Tool: LEARN\nModule: Home Introduction" \
                                 "\nPosition: 4 / 4\nIs skippable after first" \
                                 " viewing: true\nSlideshow: Home Intro"
  end

  scenario 'Content Author updates a provider' do
    find('h1', text: 'Listing Content Modules')
    page.execute_script('window.scrollTo(0,5000)')
    users.go_to_next_page('Home Introduction')
    click_on 'Home Introduction'
    click_on '1 slideshow provider'
    find('p', text: 'Is skippable after first viewing: false')
    click_on 'Edit'
    fill_in 'content_provider[position]', with: '10'
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Update'
    find('.alert-success', text: 'ContentProvider was successfully updated.')
    expect(page).to have_content 'Position: 10 / 10'
  end

  scenario 'Content Author destroys a provider' do
    find('h1', text: 'Listing Content Modules')
    page.execute_script('window.scrollTo(0,5000)')
    users.go_to_next_page('Second test module')
    click_on 'Second test module'
    click_on '1 slideshow provider'
    find('p', text: 'Slideshow: Slideshow for tests')
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    expect(page)
      .to have_css('.alert-success',
                   text: 'Content provider was successfully destroyed')
  end

  scenario 'Content Author uses breadcrumbs to return home' do
    find('h1', text: 'Listing Content Modules')
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
