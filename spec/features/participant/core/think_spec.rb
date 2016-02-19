# filename: ./spec/features/participant/core/think_spec.rb

feature 'THINK tool', :core, sauce: sauce_labs do
  background do
    unless ENV['safari']
      sign_in_pt(ENV['Participant_Email'], 'nonsocialpt',
                 ENV['Participant_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/THINK"
    expect(page).to have_content 'Add a New Harmful Thought'
  end

  scenario 'Participant completes Identifying module' do
    click_on '#1 Identifying'
    find('h1', text: 'You are what you think')
    ['Helpful thoughts are...', 'Harmful thoughts are:',
     'Some quick examples...'].each do |s|
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Next'
      find('h1', text: s)
    end

    click_on 'Next'

    heading = ['Now, your turn...', 'Now list another harmful thought...',
               'Just one more']
    response = ['Testing helpful thought', 'Testing negative thought',
                'Forced negative thought']
    heading.zip(response) do |h, r|
      find('h2', text: h)
      fill_in 'thought_content', with: r
      accept_social
      find('.alert-success', text: 'Thought saved')
    end

    find('h1', text: 'Good work')
    click_on 'Next'
    expect(page).to have_content 'Add a New Harmful Thought'
  end

  scenario 'Participant completes Patterns module' do
    click_on '#2 Patterns'
    click_on 'Next'
    find('p', text: "Let's start by")
    thought_value = find('.panel-body.adjusted-list-group-item').text
    select 'Personalization', from: 'thought_pattern_id'
    3.times do
      thought_value = compare_thought(thought_value)
      select 'Magnification or Catastrophizing', from: 'thought_pattern_id'
    end

    compare_thought(thought_value)
    select 'Personalization', from: 'thought_pattern_id'
    page.execute_script('window.scrollBy(0,500)')
    accept_social
    find('.alert-success', text: 'Thought saved')
    expect(page).to have_content 'Add a New Harmful Thought'
  end

  scenario 'Participant completes Reshape module' do
    click_on '#3 Reshape'
    click_on 'Next'
    find('h2', text: 'You said you had the following unhelpful thoughts:')
    click_on 'Next'
    find('p', text: 'Challenging a thought means')

    begin
      tries ||= 3
      click_on 'Next'
    rescue Selenium::WebDriver::Error::UnknownError
      page.execute_script('window.scrollBy(0,1000)')
      retry unless (tries -= 1).zero?
    end

    3.times do
      reshape('Example challenge', 'Example act-as-if')
    end

    expect(page).to have_content 'Add a New Harmful Thought'
  end

  scenario 'Participant completes Add a New Harmful Thought module' do
    click_on 'Add a New Harmful Thought'
    fill_in 'thought_content', with: 'Testing add a new thought'
    select 'Magnification or Catastrophizing', from: 'thought_pattern_id'
    fill_in 'thought_challenging_thought', with: 'Testing challenge thought'
    fill_in 'thought_act_as_if', with: 'Testing act-as-if action'
    page.execute_script('window.scrollTo(0,5000)')
    accept_social
    find('.alert-success', text: 'Thought saved')
    page.execute_script('window.scrollTo(0,5000)')
    find('.btn.btn-primary.pull-right').click
    expect(page).to have_content 'Add a New Harmful Thought'
  end

  scenario 'Participant cancels Add a New Harmful Thought' do
    click_on 'Add a New Harmful Thought'
    find('h2', text: 'Add a New Harmful Thought')
    page.execute_script('window.scrollBy(0,500)')
    click_on 'Cancel'
    expect(page).to have_content '#1 Identifying'
  end

  scenario 'Participant visits Thoughts and sort by column Pattern' do
    click_on 'Thoughts'
    find('tr', text: 'I am insignificant')
    find('.sorting', text: 'Pattern').click
    expect(page.all('tr:nth-child(1)')[1])
      .to have_content 'Labeling and Mislabeling'
  end

  scenario 'Participant uses the skip functionality in Identifying' do
    click_on '#1 Identifying'
    find('h1', text: 'You are what you think...')
    click_on 'Skip'
    expect(page).to have_content 'Now, your turn...'
  end

  scenario 'Participant uses the skip functionality in Patterns' do
    click_on '#2 Patterns'
    find('h1', text: 'Like we said, you are what you think...')
    click_on 'Skip'
    expect(page).to have_content "Let's start by"
  end

  scenario 'Participant uses the skip functionality in Reshape' do
    click_on '#3 Reshape'
    find('h1', text: 'Challenging Harmful Thoughts')
    click_on 'Skip'
    unless page.has_text?("You don't have")
      expect(page).to have_content "In case you've forgotten"
    end
  end

  scenario 'Participant uses navbar functionality for all of THINK' do
    visit "#{ENV['Base_URL']}/navigator/modules/954850709"

    tool = ['#2 Patterns', '#1 Identifying', '#3 Reshape',
            'Add a New Harmful Thought', 'Thoughts']
    content = ['Like we said, you are what you think...',
               'You are what you think...', 'Challenging Harmful Thoughts',
               'Add a New Harmful Thought', 'Harmful Thoughts']

    tool.zip(content) do |t, c|
      click_on 'THINK'
      click_on t
      expect(page).to have_content c
    end
  end
end

feature 'THINK Tool, Visualization', :core, sauce: sauce_labs do
  background do
    sign_in_pt(ENV['Participant__5_Email'], 'participant1',
               ENV['Participant__5_Password'])
    visit "#{ENV['Base_URL']}/navigator/contexts/THINK"
  end

  scenario 'Participant uses the visualization' do
    page.execute_script('window.scrollBy(0,1000)')
    find('.thoughtviz_text.viz-clickable',
         text: 'Magnification or Catastro...').click
    find('h1', text: 'Thought Distortions')

    find('.thoughtviz_text.viz-clickable',
         text: 'Magnification or Catastro...').click
    within('.modal-dialog') do
      expect(page).to have_content 'No one likes me'

      find('.close').click
    end

    find('text', text: 'Click a bubble for more info')
    sign_out('participant5')
  end
end
