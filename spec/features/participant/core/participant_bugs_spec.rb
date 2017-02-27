# frozen_string_literal: true
def participant_2
  Participant.new(
    participant: ENV['Participant_2_Email'],
    password: ENV['Participant_Password']
  )
end

feature 'Participant Bugs', :core, sauce: sauce_labs do
  feature 'DO tool' do
    background(:all) { participant_1.sign_in if ENV['safari'] }

    background do
      participant_1.sign_in unless ENV['safari']
      visit do_tool.landing_page
    end

    scenario 'Participant completes Planning without multiple alerts' do
      planning.open
      participant_navigation.next
      planning.plan(
        activity: 'New planned activity',
        pleasure: 6,
        accomplishment: 3
      )
      social_networking.accept_social

      expect(do_tool).to have_success_alert

      participant_navigation.scroll_to_bottom
      planning.plan(
        activity: 'Another planned activity',
        pleasure: 4,
        accomplishment: 8
      )
      social_networking.accept_social

      expect(do_tool).to have_success_alert

      planning.move_to_review

      expect(planning).to have_review_page_visible

      participant_navigation.scroll_down
      planning.finish
    end

    scenario 'Participant completes Plan a New Activity wo multiple alerts' do
      plan_new_activity.open
      planning.plan(
        activity: 'New planned activity',
        pleasure: 4,
        accomplishment: 3
      )
      social_networking.accept_social

      expect(do_tool).to have_success_alert
      expect(planning).to have_activity_visible 'New planned activity'
    end

    scenario 'Participant selects Previous Day wo exception' do
      awareness.open
      awareness.move_to_time_period_selection

      start_time = "#{week_day(today)} 2 AM"
      end_time = "#{week_day(today)} 3 AM"

      awareness.create_time_period(start_time: start_time, end_time: end_time)
      awareness.complete_one_hour_review(0, 'Sleep', 9, 3)
      social_networking.accept_social

      expect(awareness).to have_review_tables

      participant_navigation.next unless ENV['driver'] == 'poltergeist'
      activity_viz.open
      participant_navigation.scroll_to_bottom
      activity_viz.go_to_previous_day

      expect(activity_viz).to have_previous_day_visible
    end
  end

  feature 'FEEL tool, Your Recent Mood & Emotions' do
    scenario 'Participant is able to switch view back to 7 Day' do
      participant_1.sign_in unless ENV['safari']
      visit feel.landing_page
      recent_mood_and_emotions.open

      expect(recent_mood_and_emotions).to have_week_view_visible

      recent_mood_and_emotions.switch_to_28_day_view

      expect(recent_mood_and_emotions).to have_28_day_view_visible

      recent_mood_and_emotions.switch_to_7_day_view
      recent_mood_and_emotions.switch_to_previous_period

      expect(recent_mood_and_emotions).to have_previous_period_visible
    end
  end

  feature 'Participant 2 signs in,', :core, :marigold do
    scenario 'Participant completes a module, it appears complete' do
      participant_2.sign_in

      expect(participant_navigation).to have_new_assignment_in_feel

      visit feel.landing_page

      expect(tracking_mood_and_emotions).to be_unread

      tracking_mood_and_emotions.open
      tracking_mood_and_emotions.rate_mood(6)
      tracking_mood_and_emotions.rate_emotion(
        emotion: 'anxious',
        type: 'negative',
        rating: 4
      )
      participant_navigation.scroll_to_bottom
      tracking_mood_and_emotions.submit
      visit feel.landing_page

      expect(tracking_mood_and_emotions).to be_read

      recent_mood_and_emotions.open

      expect(participant_navigation).to_not have_new_assignment_in_feel
    end
  end
end
