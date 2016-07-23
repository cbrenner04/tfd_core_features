# frozen_string_literal: true
# filename: ./spec/features/participant/marigold/commitments_spec.rb

require './lib/pages/participants'
require './lib/pages/participants/commitments'
require './lib/pages/participants/commitments_modules/positive_events_and_gratitude'
require './lib/pages/participants/practice_modules/positive_events'
require './lib/pages/participants/skills'

def participant_marigold_4
  @participant_marigold_4 ||= Participant.new(
    participant: ENV['Marigold_4_Email'],
    password: ENV['Marigold_4_Password']
  )
end

def commitments
  @commitments ||= Participants::Commitments.new
end

def commitments_1
  @commitments_1 ||= Participants::Commitments.new
end

def positive_events_and_gratitude
  @positive_events_and_gratitude ||=
    Participants::CommitmentsModules::PositiveEventsAndGratitude.new
end

def skills
  @skills ||= Participants::Skills.new(lesson: 'Home Introduction')
end

def positive_events
  @positive_events ||= Participants::PracticeModules::PositiveEvents.new(
    description: 'test'
  )
end

feature 'Commitments' do
  background do
    participant_marigold_4.sign_in
    commitments.open
  end

  feature 'Positive Events and Gratitude' do
    it 'Participant chooses optional links' do
      positive_events_and_gratitude.open
      positive_events_and_gratitude.move_through_initial_slideshow
      positive_events_and_gratitude.select_review_lessons

      expect(skills).to be_visible

      commitments.open
      positive_events_and_gratitude.open
      positive_events_and_gratitude.move_through_initial_slideshow
      positive_events_and_gratitude.select_look_back_at_journal

      expect(positive_events).to have_review_visible

      commitments.open
      positive_events_and_gratitude.open
      positive_events_and_gratitude.move_through_initial_slideshow
      positive_events_and_gratitude.select_print_bonus_handout

      page.driver.browser.switch_to
          .window(page.driver.browser.window_handles.last)
      expect(current_path).to eq '/positive_events.pdf'
      page.driver.browser.close
      page.driver.browser.switch_to
          .window(page.driver.browser.window_handles.first)
    end

    it 'Participant cannot move on without making a commitment' do
      positive_events_and_gratitude.open
      positive_events_and_gratitude.move_through_initial_slideshow
      participant_navigation.next

      expect(positive_events_and_gratitude).to have_commitment_form_visible

      participant_navigation.next

      expect(commitments).to have_summary_cant_be_blank_alert
    end

    it 'Participant cannot move on without setting a minimum time' do
      positive_events_and_gratitude.open
      positive_events_and_gratitude.move_through_initial_slideshow
      participant_navigation.next

      expect(positive_events_and_gratitude).to have_commitment_form_visible

      positive_events_and_gratitude.set_commitment
      participant_navigation.next

      expect(commitments).to have_making_commitment_form_visible

      participant_navigation.next

      expect(commitments).to have_duration_cant_be_blank_alert
    end

    it 'Participant completes' do
      positive_events_and_gratitude.open
      positive_events_and_gratitude.move_through_initial_slideshow
      participant_navigation.next

      expect(positive_events_and_gratitude).to have_commitment_form_visible

      positive_events_and_gratitude.set_commitment
      participant_navigation.next

      expect(commitments).to have_making_commitment_form_visible

      participant_navigation.next
      commitments_1.set_minimum_time
      commitments_1.set_frequency
      commitments_1.set_tracking
      commitments_1.enter_details
      commitments_1.enter_affirmation
      participant_navigation.next

      expect(commitments).to have_commitment_summary_visible
      expect(positive_events_and_gratitude).to have_commitment
      expect(commitments_1).to have_responses

      commitments.sign
      participant_navigation.next

      expect(commitments).to be_done
    end

    # Repeat above for the rest
  end
end
