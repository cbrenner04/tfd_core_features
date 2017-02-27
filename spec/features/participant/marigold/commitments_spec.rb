# frozen_string_literal: true
feature 'Boosters', :marigold, sauce: sauce_labs do
  scenario 'are not accessible before assigned' do
    marigold_participant.sign_in
    commitments.open

    expect(commitments).to be_inaccessible
  end

  scenario 'invite link takes participant to boosters' do
    participant_marigold_4.sign_in
    visit "#{ENV['Base_URL']}/booster_session"

    expect(commitments).to have_thank_you_visible

    participant_navigation.alt_next

    expect(commitments).to be_visible
  end

  scenario 'is navigable after sign in' do
    participant_marigold_4.sign_in
    commitments.open

    expect(commitments).to be_visible
  end

  feature 'give incentive for completing' do
    scenario 'booster 1' do
      marigold_6.sign_in
      commitments.open
      complete_activation_commitment
      visit ENV['Base_URL']
      commitment_incentive.close_incentive_alerts
      marigold_6_navigation.navigate_to_profile

      expect(incentive_1).to have_image_in_plot
    end

    scenario 'booster 2' do
      marigold_7.sign_in
      commitments.open
      complete_activation_commitment
      visit ENV['Base_URL']
      commitment_incentive.close_incentive_alerts
      marigold_7_navigation.navigate_to_profile

      expect(incentive_1).to have_image_in_plot
      expect(incentive_2).to have_image_in_plot
    end

    scenario 'booster 3' do
      marigold_8.sign_in
      commitments.open
      complete_activation_commitment
      visit ENV['Base_URL']
      commitment_incentive.close_incentive_alerts
      marigold_8_navigation.navigate_to_profile

      expect(incentive_1).to have_image_in_plot
      expect(incentive_2).to have_image_in_plot
      expect(incentive_3).to have_image_in_plot
    end
  end
end

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

      expect(positive_events_practice_module).to have_review_visible

      commitments.open
      positive_events_and_gratitude.open
      positive_events_and_gratitude.move_through_initial_slideshow
      positive_events_and_gratitude.select_print_bonus_handout

      unless ENV['driver'] == 'poltergeist'
        page.driver.browser.switch_to
            .window(page.driver.browser.window_handles.last)
        expect(current_path).to eq '/positive_events.pdf'
        page.driver.browser.close
        page.driver.browser.switch_to
            .window(page.driver.browser.window_handles.first)
      end
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

      expect(activation_practice_module).to have_review_visible

      commitments.open
      activation_commitment.open
      activation_commitment.move_through_initial_slideshow
      activation_commitment.select_print_bonus_handout

      unless ENV['driver'] == 'poltergeist'
        page.driver.browser.switch_to
            .window(page.driver.browser.window_handles.last)
        expect(current_path).to eq '/activation.html'
        page.driver.browser.close
        page.driver.browser.switch_to
            .window(page.driver.browser.window_handles.first)
      end
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

      expect(mindfulness_practice_module).to have_review_visible

      commitments.open
      mindfulness_commitment.open
      mindfulness_commitment.move_through_initial_slideshow
      mindfulness_commitment.select_print_bonus_handout

      unless ENV['driver'] == 'poltergeist'
        page.driver.browser.switch_to
            .window(page.driver.browser.window_handles.last)
        expect(current_path).to eq '/mindfulness.pdf'
        page.driver.browser.close
        page.driver.browser.switch_to
            .window(page.driver.browser.window_handles.first)
      end
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

      expect(reappraisals_practice_module).to have_review_visible

      commitments.open
      reappraisal_commitment.open
      reappraisal_commitment.move_through_initial_slideshow
      reappraisal_commitment.select_print_bonus_handout

      unless ENV['driver'] == 'poltergeist'
        page.driver.browser.switch_to
            .window(page.driver.browser.window_handles.last)
        expect(current_path).to eq '/reappraisal.pdf'
        page.driver.browser.close
        page.driver.browser.switch_to
            .window(page.driver.browser.window_handles.first)
      end
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

      expect(kindness_practice_module).to have_review_visible

      commitments.open
      kindness_commitment.open
      kindness_commitment.move_through_initial_slideshow
      kindness_commitment.select_print_bonus_handout

      unless ENV['driver'] == 'poltergeist'
        page.driver.browser.switch_to
            .window(page.driver.browser.window_handles.last)
        expect(current_path).to eq '/kindness.pdf'
        page.driver.browser.close
        page.driver.browser.switch_to
            .window(page.driver.browser.window_handles.first)
      end
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
