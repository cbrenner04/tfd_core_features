# filename: ./spec/features/participant/social_networking/goals_spec.rb

describe 'Active pt in social arm signs in, navigates to ACHIEVE tool,',
         :social_networking, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_pt(ENV['Participant_Email'], 'participant1',
                 ENV['Participant_Password'])
    end
  end

  before do
    unless ENV['safari']
      sign_in_pt(ENV['Participant_Email'], 'participant1',
                 ENV['Participant_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/ACHIEVE"
  end

  it 'reads goal help text' do
    click_on 'Need some help writing a goal?'
    expect(page).to have_content 'The ACHIEVE tool helps you set goals. When' \
                                 ' you are writing your goal, be sure to con' \
                                 'sider the following: What is the specif' \
                                 'ic thing you will do? Where will you do' \
                                 ' it? When will you do it? How much a' \
                                 'nd how often? Remember that SMART goals te' \
                                 'nd to be the most helpful: Specific (the W' \
                                 'hat), Measurable (helps you track your pro' \
                                 'gress), Attainable (something you believe ' \
                                 'you can do), Relevant (i.e., meaningful to' \
                                 ' you, not something other people want you ' \
                                 'to do), and Time-framed. For example, let\'' \
                                 's say you want to work toward being less s' \
                                 'tressed. You might start with a goal to do' \
                                 ' more calming activities each week. From t' \
                                 'here, you can make your goal even more hel' \
                                 'pful by adding in the details: what the sp' \
                                 'ecific calming activities will be, where y' \
                                 'ou\'ll do them, when, how much and how ofte' \
                                 'n. You would then write "I will listen to ' \
                                 '(WHAT) at least 3 calming songs (HOW MUCH)' \
                                 ' every evening (HOW OFTEN) after dinner (W' \
                                 'HEN) on the couch (WHERE).'
  end

  it 'creates a goal' do
    click_on '+ add a goal'
    fill_in 'new-goal-description', with: 'eat a whole pizza'
    choose '8 weeks (end of study)'
    click_on 'Save'
    find('.list-group-item.ng-scope', text: 'due yesterday')
    find('.list-group-item.ng-scope', text: 'eat a whole pizza')
    visit ENV['Base_URL']
    find_feed_item('Created a Goal: eat a whole pizza')
    within('.list-group-item.ng-scope',
           text: 'Created a Goal: eat a whole pizza') do
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'More'

      end_of_study = Date.today + 365
      expect(page).to have_content "due #{end_of_study.strftime('%b %d %Y')}"
    end
  end

  it 'completes a goal' do
    within('.list-group-item.ng-scope', text: 'p1 alpha') do
      if ENV['chrome'] || ENV['safari']
        page.driver.execute_script('window.confirm = function() {return true}')
      end

      click_on 'Complete'
    end

    unless ENV['chrome'] || ENV['safari']
      page.accept_alert 'Are you sure you would like to mark this goal as ' \
                      'complete? This action cannot be undone.'
    end

    page.should have_css('.list-group-item-success', text: 'p1 alpha')
    click_on 'Completed'
    expect(page).to_not have_content 'p1 gamma'

    expect(page).to have_content 'p1 alpha'

    visit ENV['Base_URL']
    find_feed_item('Completed a Goal: p1 alpha')
    expect(page).to have_content 'Completed a Goal: p1 alpha'
  end

  it 'deletes a goal' do
    if ENV['chrome'] || ENV['safari']
      page.driver.execute_script('window.confirm = function() {return true}')
      find('.list-group-item.ng-scope',
           text: 'p1 gamma').find('.btn.btn-link.delete.ng-scope').click
    else
      find('.list-group-item.ng-scope',
           text: 'p1 gamma').find('.btn.btn-link.delete.ng-scope').click
      page.accept_alert 'Are you sure you would like to delete this goal? ' \
                        'This action cannot be undone.'
    end

    expect(page).to_not have_content 'p1 gamma'

    click_on 'Deleted'
    expect(page).to_not have_content 'p1 alpha'

    expect(page).to have_content 'p1 gamma'
  end
end
