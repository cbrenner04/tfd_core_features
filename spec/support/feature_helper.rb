# filename: ./spec/support/feature_helper.rb

def sign_in_pt(participant, old_participant, password)
  visit "#{ENV['Base_URL']}/participants/sign_in"
  unless page.has_css?('#new_participant')
    sign_out(old_participant)
  end
  if page.has_css?('#new_participant')
    within('#new_participant') do
      fill_in 'participant_email', with: participant
      fill_in 'participant_password', with: password
    end
    click_on 'Sign in'
    expect(page).to have_content 'HOME'
  else
    puts 'LOGIN FAILED'
  end
end

def sign_in_user(user, old_user, password)
  visit "#{ENV['Base_URL']}/users/sign_in"
  unless page.has_css?('#new_user')
    sign_out(old_user)
  end
  if page.has_css?('#new_user')
    within('#new_user') do
      fill_in 'user_email', with: user
      fill_in 'user_password', with: password
    end
    click_on 'Sign in'
    expect(page).to have_content 'Home'
  end
end

def sign_out(display_name)
  within('.navbar-collapse') do
    unless page.has_text?('Sign Out')
      find('a', text: display_name).click
    end
    click_on 'Sign Out'
  end
  expect(page).to have_content 'Forgot your password?'
end

def choose_rating(element_id, value)
  find("##{element_id} select")
    .find(:xpath, "option[#{(value + 1)}]").select_option
end

def compare_thought(thought)
  page.execute_script('window.scrollBy(0,500)')
  accept_social
  expect(page).to have_content 'Thought saved'
  within('.panel-body.adjusted-list-group-item') do
    expect(page).to_not have_content thought
  end
  find('.panel-body.adjusted-list-group-item').text
end

def reshape(challenge, action)
  expect(page).to have_content 'You said that you thought...'
  click_on 'Next'
  fill_in 'thought[challenging_thought]', with: challenge
  page.execute_script('window.scrollBy(0,500)')
  click_on 'Next'
  expect(page).to have_content 'Thought saved'
  expect(page).to have_content 'Because what you THINK, FEEL, Do'
  page.execute_script('window.scrollTo(0,5000)')
  click_on 'Next'
  expect(page).to have_content 'What could you do to ACT AS IF you believe ' \
                               'this?'
  fill_in 'thought_act_as_if', with: action
  click_on 'Next'
  expect(page).to have_content 'Thought saved'
end

def pick_tomorrow
  tomorrow = Date.today + 1
  within('#ui-datepicker-div') do
    unless page.has_no_css?('.ui-datepicker-unselectable.ui-state-disabled',
                            text: "#{tomorrow.strftime('%-e')}")
      find('.ui-datepicker-next.ui-corner-all').click
    end
    click_on tomorrow.strftime('%-e')
  end
end

def select_patient(patient)
  within('#patients', text: patient) do
    click_on patient
  end
end

def check_data(item, data)
  within(item) do
    expect(page).to have_content data
  end
end

def go_to_next_page(module_text)
  unless page.has_text? module_text
    page.execute_script('window.scrollTo(0,5000)')
    within('.pagination') do
      click_on '2'
    end
  end
end

def accept_social
  page.driver.execute_script('window.confirm = function() {return true}')
  click_on 'Next'
end

def find_feed_item(item)
  if ENV['sunnyside'] || ENV['marigold']
    find('#feed-btn').click
  end
  counter = 0
  while page.has_no_css?('.list-group-item.ng-scope',
                         text: item) && counter < 15
    page.execute_script('window.scrollTo(0,100000)')
    counter += 1
  end
end

def profile_class
  if ENV['tfd'] || ENV['tfdso']
    'default'
  elsif ENV['sunnyside'] || ENV['marigold']
    'success'
  end
end

def plan_activity(activity, x, y)
  find('#new_activity_radio')
  page.execute_script('window.scrollBy(0,500)')
  find('#new_activity_radio').click
  fill_in 'activity_activity_type_new_title', with: activity
  page.execute_script('window.scrollBy(0,500)')
  find('.fa.fa-calendar').click
  pick_tomorrow
  choose_rating('pleasure_0', x)
  choose_rating('accomplishment_0', y)
  accept_social
  expect(page).to have_content 'Activity saved'
end

def moderator
  if ENV['tfd'] || ENV['tfdso']
    'TFD Moderator'
  elsif ENV['sunnyside']
    'SunnySide'
  elsif ENV['marigold']
    'Marigold'
  end
end

def host_app
  if ENV['tfd']
    'ThinkFeelDo'
  elsif ENV['tfdso']
    'ThinkFeelDo'
  elsif ENV['sunnyside']
    'Sunnyside'
  elsif ENV['marigold']
    'Marigold'
  end
end

def like(item_text)
  within first('.list-group-item.ng-scope', text: item_text) do
    unless page.has_text?('Likes (1)')
      click_on 'Likes (0)'
      find('p', text: 'Liked by')
      click_on 'Like'
      expect(page).to have_content 'Likes (1)'
    end
  end
end

def comment(feed_item, text)
  find_feed_item(feed_item)
  page.execute_script('window.scrollTo(0,10000)')
  item = first('.list-group-item.ng-scope', text: feed_item)
  within item do
    click_on 'Comments (0)'
    click_on 'Add Comment'
    expect(page).to have_content 'What do you think?'
    fill_in 'comment-text', with: text
    page.execute_script('window.scrollBy(0,500)')
    click_on 'Save'
  end
  expect(page).to have_css('.panel-heading', text: 'To Do')
end

def visit_profile
  visit "#{ENV['Base_URL']}/social_networking/profile_page"
  if page.has_css?('.modal-content')
    within('.modal-content') do
      page.all('img')[2].click
    end
  end
end

def check_completed_behavior(num, date)
  behavior = page.all('.list-group-item.task-status')
  within behavior[num] do
    expect(page).to have_css('.fa.fa-check-circle')
    expect(page).to have_content "Completed at: #{date}"
  end
end
