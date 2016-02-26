# filename: researcher_participants_spec.rb

feature 'Researcher, Participants', :core, sauce: sauce_labs do
  if ENV['safari']
    background(:all) do
      users.sign_in_user(ENV['Researcher_Email'], 'participant2',
                   ENV['Researcher_Password'])
    end
  end

  background do
    unless ENV['safari']
      users.sign_in_user(ENV['Researcher_Email'], 'participant2',
                   ENV['Researcher_Password'])
    end

    visit "#{ENV['Base_URL']}/think_feel_do_dashboard/participants"
  end

  scenario 'Researcher creates a participant' do
    click_on 'New'
    fill_in 'participant_study_id', with: 'Tests'
    fill_in 'participant_email', with: 'test@test.com'
    fill_in 'participant_phone_number', with: ENV['Participant_Phone_Number']
    select 'Email', from: 'participant_contact_preference'
    click_on 'Create'
    find('.alert-success', text: 'Participant was successfully created.')
    expect(page).to have_content "Study Id: Tests\nEmail: test@test.com" \
                                 "\nPhone Number: " \
                                 "#{ENV['Participant_Phone_Number_1']}" \
                                 "\nContact Preference: Email"
  end

  scenario 'Researcher updates a participant' do
    find('h1', text: 'Participants')
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'test_1'
    click_on 'Edit'
    fill_in 'participant_study_id', with: 'Updated test_1'
    fill_in 'participant_email', with: 'updated_test_1@test.com'
    fill_in 'participant_phone_number', with: ENV['Participant_Phone_Number']
    click_on 'Update'
    find('.alert-success', text: 'Participant was successfully updated.')
    expect(page).to have_content 'Study Id: Updated test_1' \
                                 "\nEmail: updated_test_1@test.com" \
                                 "\nPhone Number: " \
                                 "#{ENV['Participant_Phone_Number_1']}" \
                                 "\nContact Preference: Email"
  end

  scenario 'Researcher cannot assign a coach without a group membership' do
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'test_2'
    expect(page).to have_content 'Current Coach/Moderator: None'

    expect { click_on 'Assign Coach/Moderator' }.to raise_error

    expect(page).to have_content '* Please assign Group first'
  end

  scenario 'Researcher cannot assign a membership with invalid start date' do
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'test_3'
    click_on 'Assign New Group'
    num = ENV['tfd'] ? 5 : 1
    select "Group #{num}", from: 'membership_group_id'
    unless ENV['tfd']
      fill_in 'membership_display_name', with: 'Tester'
    end

    fill_in 'membership_start_date', with: 'mm/dd/yyyy'
    next_year = Date.today + 365
    fill_in 'membership_end_date', with: next_year.strftime('%Y-%m-%d')
    click_on 'Assign'
    expect(page).to have_content "Start date can't be blank"
    expect(page).to have_content 'Memberships is invalid'
  end

  unless ENV['chrome']
    scenario 'Researcher cannot assign membership with a blank end date' do
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'test_3'
      click_on 'Assign New Group'
      num = ENV['tfd'] ? 5 : 1
      select "Group #{num}", from: 'membership_group_id'
      unless ENV['tfd']
        fill_in 'membership_display_name', with: 'Tester'
      end

      fill_in 'membership_start_date',
              with: Date.today.prev_day.strftime('%Y-%m-%d')
      fill_in 'membership_end_date', with: 'mm/dd/yyyy'
      click_on 'Assign'
      expect(page).to have_content "End date can't be blank"
      expect(page).to have_content 'Memberships is invalid'
    end

    scenario 'Researcher cannot assign membership with invalid start date' do
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'test_3'
      click_on 'Assign New Group'
      num = ENV['tfd'] ? 5 : 1
      select "Group #{num}", from: 'membership_group_id'
      unless ENV['tfd']
        fill_in 'membership_display_name', with: 'Tester'
      end

      fill_in 'membership_start_date',
              with: Date.today.prev_day.strftime('%Y-%m-%d')
      past_date = Date.today - 5
      fill_in 'membership_end_date', with: past_date.strftime('%Y-%m-%d')
      click_on 'Assign'
      expect(page).to have_content 'End date must not be in the past'
      expect(page).to have_content 'Memberships is invalid'
    end
  end

  scenario 'Researcher assigns a group membership' do
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'test_4'
    click_on 'Assign New Group'
    num = ENV['tfd'] ? 5 : 1
    select "Group #{num}", from: 'membership_group_id'
    unless ENV['chrome']
      fill_in 'membership_start_date',
              with: Date.today.prev_day.strftime('%Y-%m-%d')
      next_year = Date.today + 365
      fill_in 'membership_end_date', with: next_year.strftime('%Y-%m-%d')
    end

    if ENV['tfd']
      weeks_later = Date.today + 20 * 7
      week_num = 20
    else
      weeks_later = Date.today + 56
      week_num = 8
    end

    expect(page)
      .to have_content "Standard number of weeks: #{week_num}, Projected" \
                       ' End Date from today: ' \
                       "#{weeks_later.strftime('%m/%d/%Y')}"

    click_on 'Assign'
    expect(page).to have_content 'Group was successfully assigned'

    unless ENV['chrome']
      expect(page).to have_content "Membership Status: Active\nCurrent " \
                                   "Group: Group #{num}"
    end
  end

  scenario 'Researcher assigns a coach' do
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'test_5'
    begin
      tries ||= 3
      click_on 'Assign Coach/Moderator'
    rescue Selenium::WebDriver::Error::UnknownError
      page.execute_script('window.scrollBy(0,1000)')
      retry unless (tries -= 1).zero?
    end

    if ENV['tfd']
      select 'clinician1@example.com', from: 'coach_assignment_coach_id'
      click_on 'Assign'
    end

    find('.alert-success', text: 'Coach/Moderator was successfully assigned')
    expect(page).to have_content 'Current Coach/Moderator: ' \
                                 "#{ENV['Clinician_Email']}"
  end

  scenario 'Researcher destroys a participant' do
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'test_6'
    page.driver.execute_script('window.confirm = function() {return true}')
    click_on 'Destroy'
    find('.alert-success', text: 'Participant was successfully destroyed.')
    expect(page).to_not have_content 'test_6'
  end

  scenario 'Researcher uses breadcrumbs to return home through Participants' do
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'TFD-1111'
    find('p', text: 'Contact Preference')
    within('.breadcrumb') do
      click_on 'Participants'
    end

    find('.list-group-item', text: 'participant61')
    within('.breadcrumb') do
      click_on 'Home'
    end

    expect(page).to have_content 'Arms'
  end

  scenario 'Researcher uses breadcrumbs to return to home through Groups' do
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'TFD-1111'
    find('p', text: 'Contact Preference')
    click_on 'Group'
    within('.breadcrumb') do
      click_on 'Groups'
    end

    find('.list-group-item', text: 'Group 3')
    within('.breadcrumb') do
      click_on 'Home'
    end

    expect(page).to have_content 'Arms'
  end
end
