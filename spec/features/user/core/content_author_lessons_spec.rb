# filename: ./spec/features/user/core/content_author_lessons_spec.rb

feature 'Content Author, Lessons', :superfluous, :core, sauce: sauce_labs do
  if ENV['safari']
    background(:all) do
      users.sign_in_user(ENV['Content_Author_Email'], 'participant2',
                         ENV['Content_Author_Password'])
    end
  end

  background do
    unless ENV['safari']
      users.sign_in_user(ENV['Content_Author_Email'], 'participant2',
                         ENV['Content_Author_Password'])
    end

    visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
    click_on 'Arm 1'
    click_on 'Manage Content'
    click_on 'Lesson Modules'
  end

  scenario 'Content Author creates a new lesson' do
    click_on 'New'
    fill_in 'lesson_title', with: 'Test lesson'
    click_on 'Create'
    expect(page).to have_content 'Successfully created lesson'
  end

  scenario 'Content Author updates title of a lesson' do
    click_on 'Do - Doing Introduction'
    find('a', text: 'Welcome back!')
    page.all('.btn.btn-default')[1].click
    fill_in 'lesson_title', with: 'Do - Doing Introduction 123'
    click_on 'Update'
    find('.alert-success', text: 'Successfully updated lesson')
    expect(page).to have_content 'Do - Doing Introduction 123'
  end

  # this example is commented out as it fails most runs
  # drag_to doesn't play nice with sortable list
  #
  # scenario 'Content author updates lessons position by drag/drop sorting' do
  #   lesson_value = find('tr:nth-child(11)').text
  #   lesson = page.all('.fa.fa-sort.fa-lg')
  #   lesson[11].drag_to(lesson[3])

  #   within('tr:nth-child(3)') do
  #     expect(page).to have_content lesson_value
  #   end
  # end

  scenario 'Content Author destroys lesson' do
    find('h1', text: 'Listing Lesson Modules')
    page.execute_script('window.scrollTo(0,5000)')
    within('tr', text: 'Lesson for tests') do
      page.driver.execute_script('window.confirm = function() {return true}')
      find('.btn.btn-danger').click
    end

    find('.alert-success', text: 'Lesson deleted.')
    expect(page).to_not have_content 'Lessons for tests'
  end

  scenario 'Content Author uses breadcrumbs to return home' do
    find('h1', text: 'Listing Lesson Modules')
    click_on 'Arm'
    within('.breadcrumb') do
      click_on 'Arms'
    end

    find('.list-group-item', text: 'Arm 3')
    within('.breadcrumb') do
      click_on 'Home'
    end

    expect(page)
      .to have_content "Arms\nNavigate to groups and participants through arms."
  end
end
