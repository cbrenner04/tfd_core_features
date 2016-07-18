# frozen_string_literal: true
# filename: ./spec/features/participant/core/think_spec.rb

require './spec/support/participants/think_helper.rb'

feature 'THINK tool', :core, sauce: sauce_labs do
  background(:all) { participant_1.sign_in } if ENV['safari']

  background do
    participant_1.sign_in unless ENV['safari']
    visit think.landing_page

    expect(think).to be_visible
  end

  scenario 'Participant completes Identifying module' do
    identifying.open
    identifying.move_to_thought_input
    identifying.complete

    expect(think).to be_visible
  end

  # this is dependent upon the previous spec
  scenario 'Participant completes Patterns module' do
    patterns.open
    patterns.move_to_pattern_entry_form
    patterns.complete_for_five_thoughts

    expect(think).to have_success_alert
    expect(think).to be_visible
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
    participant_navigation.scroll_down
    participant_navigation.cancel

    expect(think).to be_visible
  end

  scenario 'Participant visits Thoughts and sort by column Pattern' do
    thoughts.open

    expect(thoughts).to have_thought_visible

    thoughts.sort_by_patterns

    within(thoughts.first_row) { expect(thoughts).to have_pattern }
  end

  scenario 'Participant uses the skip functionality in Identifying' do
    identifying.open
    participant_navigation.skip

    expect(identifying).to have_thought_entry_form
  end

  scenario 'Participant uses the skip functionality in Patterns' do
    patterns.open
    participant_navigation.skip

    expect(patterns).to have_pattern_entry_form
  end

  scenario 'Participant uses the skip functionality in Reshape' do
    reshape.open
    participant_navigation.skip

    expect(reshape).to have_reshape_form
  end

  scenario 'Participant uses navbar functionality for all of THINK' do
    visit think.identifying_tool
    think.navigate_to_all_modules_through_nav_bar
  end
end

feature 'THINK Tool, Visualization', :core, sauce: sauce_labs do
  scenario 'Participant uses the visualization' do
    participant_5.sign_in
    visit think.landing_page

    expect(think).to be_visible

    participant_navigation.scroll_to_bottom
    thought_viz.open_viz

    expect(thought_viz).to be_visible

    thought_viz.open_detail

    expect(thought_viz).to have_detail

    thought_viz.close_modal

    expect(thought_viz).to be_visible
  end
end
