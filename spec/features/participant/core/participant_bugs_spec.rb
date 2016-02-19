# filename: ./spec/features/participant/core/participant_bugs_spec.rb

feature 'Participant Bugs', :core, sauce: sauce_labs do
  feature 'DO tool,' do
    if ENV['safari']
      background(:all) do
        sign_in_pt(ENV['Participant_Email'], 'participant3',
                   ENV['Participant_Password'])
      end
    end

    background do
      unless ENV['safari']
        sign_in_pt(ENV['Participant_Email'], 'participant3',
                   ENV['Participant_Password'])
      end
    end

    scenario 'Participant completes Planning without multiple alerts' do
      visit "#{ENV['Base_URL']}/navigator/contexts/DO"
      click_on '#2 Planning'
      click_on 'Next'
      plan_activity('New planned activity', 6, 3)
      page.execute_script('window.scrollTo(0,5000)')
      plan_activity('Another planned activity', 4, 8)
      find('h1', text: 'OK...')
      click_on 'Next'
      find('h2', text: 'Your Planned Activities')
      page.execute_script('window.scrollBy(0,500)')
      click_on 'Next'
      expect(page).to have_content 'Do Landing'
    end

    scenario 'Participant completes Plan a New Activity wo multiple alerts' do
      visit "#{ENV['Base_URL']}/navigator/contexts/DO"
      click_on 'Add a New Activity'
      plan_activity('New planned activity', 4, 3)
      expect(page).to have_content 'New planned activity'
    end

    scenario 'Participant selects Previous Day wo exception' do
      visit "#{ENV['Base_URL']}/navigator/contexts/DO"
      click_on '#1 Awareness'
      click_on 'Next'
      find('h1', text: 'Just a slide')
      click_on 'Next'
      select "#{Date.today.strftime('%a')} 2 AM",
             from: 'awake_period_start_time'
      select "#{Date.today.strftime('%a')} 3 AM", from: 'awake_period_end_time'
      click_on 'Create'
      find('.alert-success', text: 'Awake Period saved')
      fill_in 'activity_type_0', with: 'Sleep'
      choose_rating('pleasure_0', 9)
      choose_rating('accomplishment_0', 3)
      page.execute_script('window.scrollBy(0,500)')
      accept_social

      %w(recent fun accomplished).each do |x|
        find("##{x}_activities")
        click_on 'Next'
      end

      click_on 'Next'
      find('h1', text: 'Do Landing')
      click_on 'Your Activities'
      find('p', text: 'Average Accomplishment Discrepancy')
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Previous Day'
      expect(page)
        .to have_content 'Daily Averages for ' \
                         "#{Date.today.prev_day.strftime('%b %d %Y')}"
    end
  end

  feature 'FEEL tool, Your Recent Mood & Emotions' do
    background do
      sign_in_pt(ENV['Participant_Email'], 'participant3',
                 ENV['Participant_Password'])
    end

    scenario 'Participant is able to switch view back to 7 Day' do
      visit "#{ENV['Base_URL']}/navigator/contexts/FEEL"
      click_on 'Your Recent Moods & Emotions'
      one_week_ago = Date.today - 6
      one_month_ago = Date.today - 27
      find('#date-range', text: "#{one_week_ago.strftime('%b %d %Y')} - " \
           "#{Date.today.strftime('%b %d %Y')}")
      find('.btn.btn-default', text: '28').click
      find('#date-range', text: "#{one_month_ago.strftime('%b %d %Y')} - " \
           "#{Date.today.strftime('%b %d %Y')}")
      find('.btn.btn-default', text: '7').click
      click_on 'Previous Period'
      one_week_ago_1 = Date.today - 7
      two_weeks_ago = Date.today - 13
      expect(page).to have_content "#{two_weeks_ago.strftime('%b %d %Y')} - " \
                                   "#{one_week_ago_1.strftime('%b %d %Y')}"
    end
  end

  feature 'Participant 2 signs in,', :marigold do
    background do
      sign_in_pt(ENV['Participant_2_Email'], 'participant1',
                 ENV['Participant_2_Password'])
    end

    scenario 'Participant completes a module, it appears complete' do
      within('.dropdown-toggle', text: 'FEEL') do
        expect(page).to have_content 'New!'
      end

      visit "#{ENV['Base_URL']}/navigator/contexts/FEEL"
      find('.task-status.list-group-item.list-group-item-unread',
           text: 'Tracking Your Mood & Emotions')
      click_on 'Tracking Your Mood & Emotions'
      select '6', from: 'mood[rating]'
      click_on 'Next'
      find('.alert-info', text: 'You just rated your mood as a 6 (Good)')
      select 'anxious', from: 'emotional_rating_emotion_id'
      select 'negative', from: 'emotional_rating_is_positive'
      select '4', from: 'emotional_rating[rating]'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Next'
      find('.alert-success', text: 'Emotional Rating saved')
      visit "#{ENV['Base_URL']}/navigator/contexts/FEEL"
      expect(page)
        .to have_css('.task-status.list-group-item.list-group-item-read',
                     text: 'Tracking Your Mood & Emotions')

      click_on 'Your Recent Moods & Emotions'
      find('.title', text: 'Mood*')
      within('.dropdown-toggle', text: 'FEEL') do
        expect(page).to_not have_content 'New!'
      end

      sign_out("#{moderator}")
    end
  end
end
