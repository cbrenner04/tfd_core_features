# filename: think_spec.rb

describe 'Active participant signs in, navigates to THINK tool,',
         type: :feature, sauce: sauce_labs do
  before do
    unless ENV['safari']
      sign_in_pt(ENV['Participant_Email'], ENV['Participant_Password'])
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/THINK"
    expect(page).to have_content 'Add a New Thought'
  end

  it 'completes Identifying module' do
    click_on '#1 Identifying'
    expect(page).to have_content 'You are what you think'

    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Next'
    expect(page).to have_content 'Helpful thoughts are...'

    click_on 'Next'
    expect(page).to have_content 'Harmful thoughts are:'

    click_on 'Next'
    expect(page).to have_content 'Some quick examples...'

    click_on 'Next'
    fill_in 'thought_content', with: 'Testing helpful thought'
    click_on 'Next'
    expect(page).to have_content 'Thought saved'

    expect(page).to have_content 'Now list another harmful thought...'

    fill_in 'thought_content', with: 'Testing negative thought'
    click_on 'Next'
    expect(page).to have_content 'Thought saved'

    expect(page).to have_content 'Just one more'

    fill_in 'thought_content', with: 'Forced negative thought'
    click_on 'Next'
    expect(page).to have_content 'Good work'

    click_on 'Next'
    expect(page).to have_content 'Add a New Thought'
  end

  it 'completes Patterns module' do
    click_on '#2 Patterns'
    click_on 'Next'
    expect(page).to have_content "Let's start by"

    thought_value = find('.panel-body.adjusted-list-group-item').text
    select 'Personalization', from: 'thought_pattern_id'
    thought_value = compare_thought(thought_value)
    select 'Magnification or Catastrophizing', from: 'thought_pattern_id'
    thought_value = compare_thought(thought_value)
    select 'Magnification or Catastrophizing', from: 'thought_pattern_id'
    thought_value = compare_thought(thought_value)
    select 'Magnification or Catastrophizing', from: 'thought_pattern_id'
    compare_thought(thought_value)
    select 'Personalization', from: 'thought_pattern_id'
    click_on 'Next'
    expect(page).to have_content 'Thought saved'
  end

  it 'completes Reshape module' do
    click_on '#3 Reshape'
    click_on 'Next'
    expect(page).to have_content 'You said you had the following unhelpful ' \
                                 'thoughts:'

    click_on 'Next'
    expect(page).to have_content 'Challenging a thought means'

    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Next'
    reshape('Example challenge', 'Example act-as-if')
    reshape('Example challenge', 'Example act-as-if')
    reshape('Example challenge', 'Example act-as-if')
  end

  it 'completes Add a New Thought module' do
    click_on 'Add a New Thought'
    fill_in 'thought_content', with: 'Testing add a new thought'
    select 'Magnification or Catastrophizing', from: 'thought_pattern_id'
    fill_in 'thought_challenging_thought', with: 'Testing challenge thought'
    fill_in 'thought_act_as_if', with: 'Testing act-as-if action'
    page.execute_script('window.scrollTo(0,5000)')
    click_on 'Next'
    expect(page).to have_content 'Thought saved'

    page.execute_script('window.scrollTo(0,5000)')
    find('.btn.btn-primary.pull-right').click
    expect(page).to have_content 'Add a New Thought'
  end

  it 'cancels Add a New Thought' do
    click_on 'Add a New Thought'
    click_on 'Cancel'
    expect(page).to have_content '#1 Identifying'
  end

  it 'visits Thoughts and sort by column Pattern' do
    click_on 'Thoughts'
    expect(page).to have_content 'I am insignificant'

    find('.sorting', text: 'Pattern').click
    expect(page.all('tr:nth-child(1)')[1])
      .to have_content 'Labeling and Mislabeling'
  end

  it 'uses the skip functionality in all the slideshows in THINK' do
    click_on '#1 Identifying'
    expect(page).to have_content 'You are what you think...'

    click_on 'Skip'
    expect(page).to have_content 'Now, your turn...'

    click_on 'THINK'
    click_on '#2 Patterns'
    expect(page).to have_content 'Like we said, you are what you think... '

    click_on 'Skip'
    expect(page).to have_content "Let's start by"

    click_on 'THINK'
    click_on '#3 Reshape'
    expect(page).to have_content 'Challenging Harmful Thoughts'

    click_on 'Skip'
    unless page.has_text?("You don't have")
      expect(page).to have_content "In case you've forgotten"
    end
  end

  it 'uses navbar functionality for all of THINK' do
    visit "#{ENV['Base_URL']}/navigator/modules/954850709"
    click_on 'THINK'
    click_on '#2 Patterns'
    expect(page).to have_content 'Like we said, you are what you think...'

    click_on 'THINK'
    click_on '#1 Identifying'
    expect(page).to have_content 'You are what you think...'

    click_on 'THINK'
    click_on '#3 Reshape'
    expect(page).to have_content 'Challenging Harmful Thoughts'

    click_on 'THINK'
    click_on 'Add a New Thought'
    expect(page).to have_content 'Add a New Harmful Thought'

    click_on 'THINK'
    click_on 'Thoughts'
    expect(page).to have_content 'Harmful Thoughts'
  end

  it 'uses the visualization' do
    find('.thoughtviz_text.viz-clickable',
         text: 'Magnification or Catastro...').click
    expect(page).to have_content 'Thought Distortions'

    find('.thoughtviz_text.viz-clickable',
         text: 'Magnification or Catastro...').click
    expect(page).to have_content 'Testing add a new thought'

    click_on 'Close'
    expect(page).to have_content 'Click a bubble for more info'

    sign_out
  end
end
