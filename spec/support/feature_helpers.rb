# filename: ./spec/support/feature_helpers.rb

# Helpers related to core functionality

def compare_thought(thought)
  page.execute_script('window.scrollBy(0,500)')
  accept_social
  find('.alert-success', text: 'Thought saved')
  within('.panel-body.adjusted-list-group-item') do
    expect(page).to_not have_content thought
  end
  find('.panel-body.adjusted-list-group-item').text
end

def reshape(challenge, action)
  find('h3', text: 'You said that you thought...')
  click_on 'Next'
  fill_in 'thought[challenging_thought]', with: challenge
  page.execute_script('window.scrollBy(0,500)')
  click_on 'Next'
  find('.alert-success', text: 'Thought saved')
  find('p', text: 'Because what you THINK, FEEL, Do')
  page.execute_script('window.scrollTo(0,5000)')
  click_on 'Next'
  find('label', text: 'What could you do to ACT AS IF you believe this?')
  fill_in 'thought_act_as_if', with: action
  click_on 'Next'
  find('.alert-success', text: 'Thought saved')
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
      click_on 'Next'
    end
  end
end

def moderator
  'participant2'
end

def host_app
  if ENV['tfd'] || ENV['tfdso']
    'ThinkFeelDo'
  elsif ENV['sunnyside']
    'Sunnyside'
  elsif ENV['marigold']
    'Marigold'
  end
end

# Helpers related to social_networking functionality

def find_feed_item(item)
  unless ENV['tfd'] || ENV['tfdso']
    find('#feed-btn').click
  end
  counter = 0
  while page.has_no_css?('.list-group-item.ng-scope',
                         text: item) && counter < 15
    page.execute_script('window.scrollTo(0,100000)')
    counter += 1
  end
end

def like(item_text)
  within first('.list-group-item.ng-scope', text: item_text) do
    unless page.has_text?('Like (1)')
      click_on 'Like'
      expect(page).to have_content 'Like (1)'
    end
  end
end

def comment(feed_item, text)
  find_feed_item(feed_item)
  page.execute_script('window.scrollTo(0,10000)')
  within first('.list-group-item.ng-scope', text: feed_item) do
    click_on 'Comment'
    expect(page).to have_content 'What do you think?'
    fill_in 'comment-text', with: text
    page.execute_script('window.scrollBy(0,500)')
    click_on 'Save'
    expect(page).to have_content 'Comment (1)'
  end
end

def visit_profile
  visit "#{ENV['Base_URL']}/social_networking/profile_page"
  unless page.has_no_css?('.modal-content')
    within('.modal-content') do
      page.all('img')[2].click
    end
  end
end

# Helpers related to sunnyside functionality
def check_completed_behavior(num, date)
  behavior = page.all('.list-group-item.task-status')
  within behavior[num] do
    expect(page).to have_css('.fa.fa-check-circle')
    expect(page).to have_content "Completed at: #{date}"
  end
end
