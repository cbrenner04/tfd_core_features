# filename: ./spec/features/participant/core/think_spec.rb

require './spec/support/participants/think_helper.rb'

feature 'THINK tool', :core, sauce: sauce_labs do
  background do
    participant_1_so1.sign_in unless ENV['safari']
    visit think.landing_page

    expect(think).to be_visible
  end

  scenario 'Participant completes Identifying module' do
    identifying.open
    identifying.move_to_thought_input
    identifying.complete
  end

  scenario 'Participant completes Patterns module' do
    patterns.open
    patterns.move_to_pattern_entry_form
    patterns.complete
  end

  scenario 'Participant completes Reshape module' do
    reshape.open
    reshape.move_to_reshape_form
    reshape.reshape_multiple_thoughts

    expect(think).to be_visible
  end

  scenario 'Participant completes Add a New Harmful Thought module' do
    add_new_thought.open
    add_new_thought.complete
    expect(think).to be_visible
  end

  scenario 'Participant cancels Add a New Harmful Thought' do
    add_new_thought.open
    navigation.scoll_down
    navigation.cancel

    expect(think).to be_visible
  end

  scenario 'Participant visits Thoughts and sort by column Pattern' do
    thoughts.open

    expect(thoughts).to have_thought_visible

    thoughts.sort_by_patterns

    expect(thought.first_row).to have_pattern
  end

  scenario 'Participant uses the skip functionality in Identifying' do
    identifying.open
    navigation.skip

    expect(identifying).to have_thought_entry_form
  end

  scenario 'Participant uses the skip functionality in Patterns' do
    patterns.open
    navigation.skip

    expect(patterns).to have_pattern_entry_form
  end

  scenario 'Participant uses the skip functionality in Reshape' do
    reshape.open
    navigation.skip

    expect(reshape).to have_reshape_form
  end

  scenario 'Participant uses navbar functionality for all of THINK' do
    visit think.identifying_tool
    think.navigate_to_all_modules_through_nav_bar
  end
end

feature 'THINK Tool, Visualization', :core, sauce: sauce_labs do
  background do
    participant_5_so1.sign_in
    visit think.landing_page
  end

  scenario 'Participant uses the visualization' do
    2.times { navigation.scroll_down }
    thought_viz.open_viz

    expect(thought_viz).to be_visible

    thought_viz.open_detail

    expect(thought_viz).to have_detail

    expect(thgought_viz).to be_visible

    participant_5_so1.sign_out
  end
end
