# filename: ./spec/features/participant/core/learn_spec.rb

describe 'Active participant in group 1 signs in, navigates to LEARN,',
         :core, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_pt(ENV['Participant_Email'], 'participant5',
                 ENV['Participant_Password'])
    end
  end

  before do
    unless ENV['safari']
      sign_in_pt(ENV['Participant_Email'], 'participant5',
                 ENV['Participant_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/LEARN"
  end

  it 'sees list opened to this week, collapses list' do
    find('.list-group-item-heading', text: 'Do - Awareness Introduction')
    first('.panel-title', text: 'Week 1').click
    expect(page).to_not have_content 'Do - Awareness Introduction'
  end

  it 'reads Lesson 1' do
    click_on 'Do - Awareness Introduction'
    find('h1', text: 'This is just the beginning...')
    click_on 'Next'
    click_on 'Finish'
    expect(page).to have_content "Read on #{Date.today.strftime('%b %d')}"

    expect(page).to have_content 'Printable'
  end

  it 'only sees lessons listed to the end of study length' do
    last_wk_num = (16 if ENV['tfd']) ||
                  (8 if ENV['tfdso'] || ENV['sunnyside'] || ENV['marigold'])
    last_week = (Date.today + 105 if ENV['tfd']) ||
                (Date.today + 49 if ENV['tfdso'] || ENV['sunnyside'] ||
                 ENV['marigold'])
    after_wk_num = (17 if ENV['tfd']) ||
                   (9 if ENV['tfdso'] || ENV['sunnyside'] || ENV['marigold'])
    after_study = (Date.today + 112 if ENV['tfd']) ||
                  (Date.today + 56 if ENV['tfdso'] || ENV['sunnyside'] ||
                   ENV['marigold'])
    expect(page)
      .to have_css('.panel-title.panel-unreleased',
                   text: "Week #{last_wk_num} " \
                   "· #{last_week.strftime('%b %d %Y')}")
    expect(page)
      .to_not have_css('.panel-title.panel-unreleased',
                       text: "Week #{after_wk_num} " \
                       "· #{after_study.strftime('%b %d %Y')}")
  end
end

describe 'Active participant in group 1 signs in, navigates to LEARN,',
         :core, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_pt(ENV['Participant__5_Email'], 'participant1',
                 ENV['Participant__5_Password'])
    end
  end

  before do
    unless ENV['safari']
      sign_in_pt(ENV['Participant_5_Email'], 'participant1',
                 ENV['Participant_5_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/LEARN"
  end

  it 'views print preview of a lesson' do
    click_on 'Printable'
    find('a', text: 'Print')
    click_on 'Return to Lessons'
    expect(page).to have_content 'Week 1'
  end
end
