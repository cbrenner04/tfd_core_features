# frozen_string_literal: true
# filename: ./spec/features/participant/marigold/commitments_spec.rb

require './lib/pages/participants'
require './spec/support/participants/commitments_helper.rb'
require './lib/pages/participants/commitments.rb'
Dir['./lib/pages/participants/commitiments_modules/*.rb']
  .each { |file| require file }

feature 'Commitments', :marigold, sauce: sauce_labs do
  background do
    participant_marigold_4.sign_in
    commitments.open
  end

  feature 'Positive Events and Gratitude' do
    scenario 'Participant chooses optional links' do
      positive_events_and_gratitude.open
      positive_events_and_gratitude.move_through_initial_slideshow
      positive_events_and_gratitude.select_review_lessons

      expect(skills_visible).to be_visible

      commitments.open
      positive_events_and_gratitude.open
      positive_events_and_gratitude.move_through_initial_slideshow
      positive_events_and_gratitude.select_look_back_at_journal

      expect(positive_events_practice_modules).to have_review_visible

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

    scenario 'Participant cannot move on without making a commitment' do
      positive_events_and_gratitude.open
      positive_events_and_gratitude.move_through_initial_slideshow
      participant_navigation.next

      expect(positive_events_and_gratitude).to have_commitment_form_visible

      participant_navigation.next

      expect(commitments).to have_summary_cant_be_blank_alert
    end

    scenario 'Participant cannot move on without setting a minimum time' do
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

    scenario 'Participant completes' do
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

      expect(positive_events_and_gratitude).to have_commitment_summary_visible
      expect(positive_events_and_gratitude).to have_commitment
      expect(commitments_1).to have_responses

      commitments.sign
      participant_navigation.next

      expect(commitments).to be_done
    end
  end

  feature 'Activation' do
    scenario 'Participants chooses optional links' do
      activation_commitment.open
      activation_commitment.move_through_initial_slideshow
      activation_commitment.select_review_lessons

      expect(skills_visible).to be_visible

      commitments.open
      activation_commitment.open
      activation_commitment.move_through_initial_slideshow
      activation_commitment.select_look_back_at_journal

      expect(activation_practice_modules).to have_review_visible

      commitments.open
      activation_commitment.open
      activation_commitment.move_through_initial_slideshow
      activation_commitment.select_print_bonus_handout

      page.driver.browser.switch_to
          .window(page.driver.browser.window_handles.last)
      expect(current_path).to eq '/activation.html'
      page.driver.browser.close
      page.driver.browser.switch_to
          .window(page.driver.browser.window_handles.first)
    end

    scenario 'Participant cannot move on without making a commitment' do
      activation_commitment.open
      activation_commitment.move_through_initial_slideshow
      participant_navigation.next

      expect(activation_commitment).to have_commitment_form_visible

      participant_navigation.next

      expect(commitments).to have_summary_cant_be_blank_alert
    end

    scenario 'Participant cannot move on without setting a minimum time' do
      activation_commitment.open
      activation_commitment.move_through_initial_slideshow
      participant_navigation.next

      expect(activation_commitment).to have_commitment_form_visible

      activation_commitment.set_commitment
      participant_navigation.next

      expect(commitments).to have_making_commitment_form_visible

      participant_navigation.next

      expect(commitments).to have_duration_cant_be_blank_alert
    end

    scenario 'Participant completes' do
      activation_commitment.open
      activation_commitment.move_through_initial_slideshow
      participant_navigation.next

      expect(activation_commitment).to have_commitment_form_visible

      activation_commitment.set_commitment
      participant_navigation.next

      expect(commitments).to have_making_commitment_form_visible

      participant_navigation.next
      commitments_2.set_minimum_time
      commitments_2.set_frequency
      commitments_2.set_tracking
      commitments_2.enter_details
      commitments_2.enter_affirmation
      participant_navigation.next

      expect(activation_commitment).to have_commitment_summary_visible
      expect(activation_commitment).to have_commitment
      expect(commitments_2).to have_responses

      commitments.sign
      participant_navigation.next

      expect(commitments).to be_done
    end
  end

  feature 'Mindfulness' do
    scenario 'Participants chooses optional links' do
      mindfulness_commitment.open
      mindfulness_commitment.move_through_initial_slideshow
      mindfulness_commitment.select_review_lessons

      expect(skills_visible).to be_visible

      commitments.open
      mindfulness_commitment.open
      mindfulness_commitment.move_through_initial_slideshow
      mindfulness_commitment.select_look_back_at_journal

      expect(mindfulness_practice_modules).to have_review_visible

      commitments.open
      mindfulness_commitment.open
      mindfulness_commitment.move_through_initial_slideshow
      mindfulness_commitment.select_print_bonus_handout

      page.driver.browser.switch_to
          .window(page.driver.browser.window_handles.last)
      expect(current_path).to eq '/mindfulness.pdf'
      page.driver.browser.close
      page.driver.browser.switch_to
          .window(page.driver.browser.window_handles.first)
    end

    scenario 'Participant cannot move on without making a commitment' do
      mindfulness_commitment.open
      mindfulness_commitment.move_through_initial_slideshow
      participant_navigation.next

      expect(mindfulness_commitment).to have_commitment_form_visible

      participant_navigation.next

      expect(commitments).to have_summary_cant_be_blank_alert
    end

    scenario 'Participant cannot move on without setting a minimum time' do
      mindfulness_commitment.open
      mindfulness_commitment.move_through_initial_slideshow
      participant_navigation.next

      expect(mindfulness_commitment).to have_commitment_form_visible

      mindfulness_commitment.set_commitment
      participant_navigation.next

      expect(commitments).to have_making_commitment_form_visible

      participant_navigation.next

      expect(commitments).to have_duration_cant_be_blank_alert
    end

    scenario 'Participant completes' do
      mindfulness_commitment.open
      mindfulness_commitment.move_through_initial_slideshow
      participant_navigation.next

      expect(mindfulness_commitment).to have_commitment_form_visible

      mindfulness_commitment.set_commitment
      participant_navigation.next

      expect(commitments).to have_making_commitment_form_visible

      participant_navigation.next
      commitments_2.set_minimum_time
      commitments_2.set_frequency
      commitments_2.set_tracking
      commitments_2.enter_details
      commitments_2.enter_affirmation
      participant_navigation.next

      expect(mindfulness_commitment).to have_commitment_summary_visible
      expect(mindfulness_commitment).to have_commitment
      expect(commitments_2).to have_responses

      commitments.sign
      participant_navigation.next

      expect(commitments).to be_done
    end
  end

  feature 'Reappraisal' do
    scenario 'Participants chooses optional links' do
      reappraisal_commitment.open
      reappraisal_commitment.move_through_initial_slideshow
      reappraisal_commitment.select_review_lessons

      expect(skills_visible).to be_visible

      commitments.open
      reappraisal_commitment.open
      reappraisal_commitment.move_through_initial_slideshow
      reappraisal_commitment.select_look_back_at_journal

      expect(reappraisals_practice_modules).to have_review_visible

      commitments.open
      reappraisal_commitment.open
      reappraisal_commitment.move_through_initial_slideshow
      reappraisal_commitment.select_print_bonus_handout

      page.driver.browser.switch_to
          .window(page.driver.browser.window_handles.last)
      expect(current_path).to eq '/reappraisal.pdf'
      page.driver.browser.close
      page.driver.browser.switch_to
          .window(page.driver.browser.window_handles.first)
    end

    scenario 'Participant cannot move on without making a commitment' do
      reappraisal_commitment.open
      reappraisal_commitment.move_through_initial_slideshow
      participant_navigation.next

      expect(reappraisal_commitment).to have_commitment_form_visible

      participant_navigation.next

      expect(commitments).to have_summary_cant_be_blank_alert
    end

    scenario 'Participant cannot move on without setting a minimum time' do
      reappraisal_commitment.open
      reappraisal_commitment.move_through_initial_slideshow
      participant_navigation.next

      expect(reappraisal_commitment).to have_commitment_form_visible

      reappraisal_commitment.set_commitment
      participant_navigation.next

      expect(commitments).to have_making_commitment_form_visible

      participant_navigation.next

      expect(commitments).to have_duration_cant_be_blank_alert
    end

    scenario 'Participant completes' do
      reappraisal_commitment.open
      reappraisal_commitment.move_through_initial_slideshow
      participant_navigation.next

      expect(reappraisal_commitment).to have_commitment_form_visible

      reappraisal_commitment.set_commitment
      participant_navigation.next

      expect(commitments).to have_making_commitment_form_visible

      participant_navigation.next
      commitments_2.set_minimum_time
      commitments_2.set_frequency
      commitments_2.set_tracking
      commitments_2.enter_details
      commitments_2.enter_affirmation
      participant_navigation.next

      expect(reappraisal_commitment).to have_commitment_summary_visible
      expect(reappraisal_commitment).to have_commitment
      expect(commitments_2).to have_responses

      commitments.sign
      participant_navigation.next

      expect(commitments).to be_done
    end
  end

  feature 'Kindness' do
    scenario 'Participants chooses optional links' do
      kindness_commitment.open
      kindness_commitment.move_through_initial_slideshow
      kindness_commitment.select_review_lessons

      expect(skills_visible).to be_visible

      commitments.open
      kindness_commitment.open
      kindness_commitment.move_through_initial_slideshow
      kindness_commitment.select_look_back_at_journal

      expect(kindness_practice_modules).to have_review_visible

      commitments.open
      kindness_commitment.open
      kindness_commitment.move_through_initial_slideshow
      kindness_commitment.select_print_bonus_handout

      page.driver.browser.switch_to
          .window(page.driver.browser.window_handles.last)
      expect(current_path).to eq '/kindness.pdf'
      page.driver.browser.close
      page.driver.browser.switch_to
          .window(page.driver.browser.window_handles.first)
    end

    scenario 'Participant cannot move on without making a commitment' do
      kindness_commitment.open
      kindness_commitment.move_through_initial_slideshow
      participant_navigation.next

      expect(kindness_commitment).to have_commitment_form_visible

      participant_navigation.next

      expect(commitments).to have_summary_cant_be_blank_alert
    end

    scenario 'Participant cannot move on without setting a minimum time' do
      kindness_commitment.open
      kindness_commitment.move_through_initial_slideshow
      participant_navigation.next

      expect(kindness_commitment).to have_commitment_form_visible

      kindness_commitment.set_commitment
      participant_navigation.next

      expect(commitments).to have_making_commitment_form_visible

      participant_navigation.next

      expect(commitments).to have_duration_cant_be_blank_alert
    end

    scenario 'Participant completes' do
      kindness_commitment.open
      kindness_commitment.move_through_initial_slideshow
      participant_navigation.next

      expect(kindness_commitment).to have_commitment_form_visible

      kindness_commitment.set_commitment
      participant_navigation.next

      expect(commitments).to have_making_commitment_form_visible

      participant_navigation.next
      commitments_2.set_minimum_time
      commitments_2.set_frequency
      commitments_2.set_tracking
      commitments_2.enter_details
      commitments_2.enter_affirmation
      participant_navigation.next

      expect(kindness_commitment).to have_commitment_summary_visible
      expect(kindness_commitment).to have_commitment
      expect(commitments_2).to have_responses

      commitments.sign
      participant_navigation.next

      expect(commitments).to be_done
    end
  end
end
