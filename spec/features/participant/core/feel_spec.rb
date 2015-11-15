# filename: ./spec/features/participant/core/feel_spec.rb

describe 'Active participant in group 1 signs in, navigates to FEEL tool,',
         :core, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_pt(ENV['Participant_Email'], 'participant3',
                 ENV['Participant_Password'])
    end
  end

  before do
    unless ENV['safari']
      sign_in_pt(ENV['Participant_Email'], 'participant3',
                 ENV['Participant_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/FEEL"
  end

  it 'completes Tracking Your Mood' do
    click_on 'Tracking Your Mood'
    select '6', from: 'mood[rating]'
    click_on 'Next'
    find('.alert-success', text: 'Mood saved')

    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Next'
    expect(page).to have_content 'Feeling Tracker Landing'
  end
end

describe 'Active participant in group 3 signs in, navigates to FEEL tool,',
         :core, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_pt(ENV['Alt_Participant_Email'], 'participant1',
                 ENV['Alt_Participant_Password'])
    end
  end

  before do
    unless ENV['safari']
      sign_in_pt(ENV['Alt_Participant_Email'], 'participant1',
                 ENV['Alt_Participant_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/FEEL"
  end

  it 'completes Tracking Your Mood & Emotions' do
    click_on 'Tracking Your Mood & Emotions'
    select '6', from: 'mood[rating]'
    click_on 'Next'
    find('.alert-info', text: 'You just rated your mood as a 6 (Good)')

    select 'anxious', from: 'emotional_rating_emotion_id'
    select 'negative', from: 'emotional_rating_is_positive'
    select '4', from: 'emotional_rating[rating]'
    page.execute_script('window.scrollBy(0,500)')
    click_on 'Add Emotion'
    within '#subcontainer-1' do
      fill_in 'emotional_rating_name', with: 'crazy'
      select 'negative', from: 'emotional_rating_is_positive'
      select '8', from: 'emotional_rating[rating]'
    end

    click_on 'Next'
    find('.alert-success', text: 'Emotional Rating saved')
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Next'
    expect(page).to have_content 'Feeling Tracker Landing'
  end

  it 'uses navbar functionality in all of FEEL' do
    visit "#{ENV['Base_URL']}/navigator/modules/86966983"

    tool = ['Your Recent Moods & Emotions', 'Tracking Your Mood & Emotions',
            'FEEL Home']
    content = ['Positive and Negative Emotions', 'Rate your Mood',
               'Feeling Tracker Landing']

    tool.zip(content) do |t, c|
      click_on 'FEEL'
      click_on t
      expect(page).to have_content c
    end
  end
end

describe 'Active participant in group 1 signs in, navigates to FEEL tool,',
         :core, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_pt(ENV['Participant_5_Email'], 'participant3',
                 ENV['Participant_5_Password'])
    end
  end

  before do
    unless ENV['safari']
      sign_in_pt(ENV['Participant_5_Email'], 'participant3',
                 ENV['Participant_5_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/FEEL"
  end

  it 'views ratings in Mood graph in Your Recent Mood & Emotions' do
    click_on 'Your Recent Moods & Emotions'
    within('#mood') do
      find('.title', text: 'Mood*')
      expect(page).to have_css('.bar.positive', count: 1)
    end
  end

  it 'views ratings in Emotions graph in Your Recent Mood & Emotions' do
    click_on 'Your Recent Moods & Emotions'
    within('#emotions') do
      find('.title', text: 'Positive and Negative Emotions*')
      expect(page).to have_css('.bar.negative', count: 1)
    end
  end

  it 'navigates to 28 day view in Your Recent Mood & Emotions' do
    click_on 'Your Recent Moods & Emotions'
    one_week_ago = Date.today - 6
    one_month_ago = Date.today - 27
    find('#date-range', text: "#{one_week_ago.strftime('%b %d %Y')} - " \
         "#{Date.today.strftime('%b %d %Y')}")

    find('.btn.btn-default', text: '28').click
    expect(page).to have_content "#{one_month_ago.strftime('%b %d %Y')} - " \
                                 "#{Date.today.strftime('%b %d %Y')}"
  end

  it 'navigates to Previous Period in Your Recent Mood & Emotions' do
    click_on 'Your Recent Moods & Emotions'
    find('.title', text: 'Mood*')
    click_on 'Previous Period'
    one_week_ago_1 = Date.today - 7
    two_weeks_ago = Date.today - 13
    expect(page).to have_content "#{two_weeks_ago.strftime('%b %d %Y')} - " \
                                 "#{one_week_ago_1.strftime('%b %d %Y')}"
  end
end
