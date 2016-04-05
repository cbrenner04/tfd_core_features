# filename: ./spec/features/participant/marigold/practice_spec.rb

require './spec/support/participants/practice_helper'

feature 'PRACTICE tool', :marigold, sauce: sauce_labs do
  background do
    marigold_participant_so3.sign_in
    visit practice.landing_page
  end

  scenario 'Participant views examples of Gratitude recordings' do
    gratitude_1.open

    expect(gratitude_1).to have_question

    gratitude_1.show_examples

    expect(gratitude_1).to have_examples
  end

  scenario 'Participant adds entry to Gratitude module' do
    gratitude_1.open

    expect(gratitude_1).to have_question

    gratitude_1.enter_response
    navigation.next

    expect(gratitude_1).to be_saved
  end

  scenario 'Participant views past Gratitude entries' do
    gratitude_2.open_review

    expect(gratitude_2).to have_previous_recording
  end

  scenario 'Participant records new Gratitude entry from index page' do
    gratitude_2.open_review
    gratitude_2.create_new

    expect(gratitude_2).to have_question
  end
end
