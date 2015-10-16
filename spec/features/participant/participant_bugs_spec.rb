# filename: participant_bugs_spec.rb

describe 'Participant Bugs', type: :feature, sauce: sauce_labs do
  describe 'Participant 1 signs in,' do
    before do
      sign_in_pt(ENV['Participant_Email'], ENV['Participant_Password'])
    end

    it 'visits Your Activities, selects Previous Day w/out exception' do
      visit "#{ENV['Base_URL']}/navigator/contexts/DO"
      click_on '#1 Awareness'
      click_on 'Next'
      find('h1', text: 'Just a slide')
      click_on 'Next'
      select "#{Date.today.strftime('%a')} 2 AM",
             from: 'awake_period_start_time'
      select "#{Date.today.strftime('%a')} 3 AM", from: 'awake_period_end_time'
      click_on 'Create'
      expect(page).to have_content 'Awake Period saved'

      fill_in 'activity_type_0', with: 'Sleep'
      choose_rating('pleasure_0', 9)
      choose_rating('accomplishment_0', 3)
      click_on 'Next'
      expect(page).to have_content 'Activity saved'

      expect(page).to have_content 'Take a look - does this all seem right? ' \
                                   'Recently, you...'

      click_on 'Next'
      expect(page).to have_content 'Things you found fun.'

      click_on 'Next'
      expect(page).to have_content "Things that make you feel like you've " \
                                   'accomplished something.'

      click_on 'Next'
      expect(page).to have_content 'Add a New Activity'

      click_on 'Your Activities'
      expect(page).to have_content 'Today'

      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Previous Day'
      expect(page)
        .to have_content 'Daily Averages for ' \
                         "#{Date.today.prev_day.strftime('%b %d %Y')}"
    end

    it 'visits Your Recent Moods & Emotions, ' \
       'is able to switch view back to 7 Day' do
      visit "#{ENV['Base_URL']}/navigator/contexts/FEEL"
      click_on 'Your Recent Moods & Emotions'
      one_week_ago = Date.today - 6
      one_month_ago = Date.today - 27
      expect(page).to have_content "#{one_week_ago.strftime('%b %d %Y')} - " \
                                   "#{Date.today.strftime('%b %d %Y')}"

      find('.btn.btn-default', text: '28 day').click
      expect(page).to have_content "#{one_month_ago.strftime('%b %d %Y')} - " \
                                   "#{Date.today.strftime('%b %d %Y')}"

      find('.btn.btn-default', text: '7 Day').click
      click_on 'Previous Period'
      one_week_ago_1 = Date.today - 7
      two_weeks_ago = Date.today - 13
      expect(page).to have_content "#{two_weeks_ago.strftime('%b %d %Y')} - " \
                                   "#{one_week_ago_1.strftime('%b %d %Y')}"
    end
  end

  describe 'Participant 2 signs in,' do
    before do
      sign_in_pt(ENV['Participant_2_Email'], ENV['Participant_2_Password'])
    end

    it 'navigates to a module, completes the module, the module appears complete' do
      within('.dropdown-toggle', text: 'FEEL') do
        expect(page).to have_content 'New!'
      end

      visit "#{ENV['Base_URL']}/navigator/contexts/FEEL"
      expect(page)
        .to have_css('.task-status.list-group-item.list-group-item-unread',
                     text: 'Tracking Your Mood & Emotions')

      click_on 'Tracking Your Mood & Emotions'
      select '6', from: 'mood[rating]'
      click_on 'Next'
      expect(page).to have_content 'You just rated your mood as a 6 (Good)'

      select 'anxious', from: 'emotional_rating_emotion_id'
      select 'negative', from: 'emotional_rating_is_positive'
      select '4', from: 'emotional_rating[rating]'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Next'
      expect(page).to have_content 'Emotional Rating saved'

      visit "#{ENV['Base_URL']}/navigator/contexts/FEEL"
      expect(page)
        .to have_css('.task-status.list-group-item.list-group-item-read',
                     text: 'Tracking Your Mood & Emotions')

      click_on 'Your Recent Moods & Emotions'
      expect(page).to have_content 'Positive and Negative Emotions'

      within('.dropdown-toggle', text: 'FEEL') do
        expect(page).to_not have_content 'New!'
      end
    end
  end
end
