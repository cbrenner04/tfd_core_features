# filename: ./spec/features/user/social_networking/coach_groups_spec.rb

describe 'Coach signs in and navigates to Group Dashboard of Group 6',
         :social_networking, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_user(ENV['Clinician_Email'], 'participant1',
                   ENV['Clinician_Password'])
    end
  end

  before do
    unless ENV['safari']
      sign_in_user(ENV['Clinician_Email'], "#{moderator}",
                   ENV['Clinician_Password'])
    end

    visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
    click_on 'Arm 1'
    click_on 'Group 6'
    click_on 'Group Dashboard'
  end

  it 'views Group Summary' do
    within('.panel.panel-default', text: 'Group Summary') do
      data = ['logins  7 10 4 3 5 0 0 0', 'thoughts  1 0 1 1 1 0 0 0',
              'activities past  1 0 1 0 0 0 0 0',
              'activities future  0 0 0 0 2 0 0 0',
              'on the mind statements  0 0 0 1 0 0 0 0',
              'comments  0 0 2 0 1 0 0 0', 'goals  1 2 0 0 0 0 0 0',
              'likes  1 2 1 0 1 0 0 0']

      (2..9).zip(data) do |i, d|
        check_data("tr:nth-child(#{i})", d)
      end
    end
  end

  it 'uses the links within Group Summary' do
    within('.panel.panel-default', text: 'Group Summary') do
      items = ['logins', 'thoughts', 'activities past', 'activities future',
               'on the mind statements', 'comments', 'goals', 'likes']
      items.each do |tool|
        click_on tool
      end
    end
  end

  it 'views Logins by Week' do
    within('.panel.panel-default', text: 'Logins By Week') do
      data = ['First 4 3 0 2 2 0 0 0', 'Second  2 1 1 1 2 0 0 0',
              'Third  1 0 1 0 1 0 0 0', 'Fourth  0 6 1 0 0 0 0 0',
              'Fifth  0 0 1 0 0 0 0 0']
      (2..6).zip(data) do |i, d|
        check_data("tr:nth-child(#{i})", d)
      end
    end
  end

  it 'views Lesson View Summary' do
    within('.panel.panel-default', text: 'Lesson View Summary') do
      table_row_0 = page.all('tr:nth-child(1)')
      table_row_2 = page.all('tr:nth-child(2)')
      row = [table_row_0[0], table_row_2[0], 'tr:nth-child(3)',
             table_row_0[4]]
      lesson = ['Testing adding/updating slides/lessons 1 of 5 COMPLETE',
                'Do - Awareness Introduction 2 of 5 COMPLETE',
                'Do - Planning Introduction 1 of 5 COMPLETE',
                'Think - Identifying Conclusion 3 of 5 COMPLETE']
      comp_pt = ['First', 'Second Third', 'Second', 'First Second Third']
      incomp_pt = ['Second Third Fourth Fifth', 'First Fourth Fifth',
                   'First Third Fourth Fifth', 'Fourth Fifth']

      row.zip(lesson, comp_pt, incomp_pt) do |r, l, c, i|
        within(r) do
          expect(page).to have_content l

          page.execute_script('window.scrollBy(0,1000)')
          click_on 'View Complete Participants'
          expect(page).to have_content c

          click_on 'View Incomplete Participants'
          expect(page).to have_content i
        end
      end
    end
  end

  it 'views Thoughts' do
    within('.panel.panel-default', text: 'Group Summary') do
      click_on 'thoughts'
    end

    within('#thoughts-container') do
      find('.sorting', text: 'Week').click
      table_row = page.all('tr:nth-child(1)')
      date_1 = Date.today - 34
      date_2 = Date.today - 20
      row = [table_row[1], 'tr:nth-child(2)']
      content = ['First I am no good  Labeling and Mislabeling  ' \
                 'I did good at work today  I am good  ' \
                 "#{date_1.strftime('%b %d %Y')}", 'First This is stupid  ' \
                 'Fortune Telling  It could be useful  I should try it out  ' \
                 "#{date_2.strftime('%b %d %Y')}"]
      num = ['1 1 1', '3 0 0']
      row.zip(content, num) do |r, c, n|
        within(r) do
          expect(page).to have_content c
          expect(page).to have_content n
        end
      end
    end
  end

  it 'views Activities Past' do
    within('.panel.panel-default', text: 'Group Summary') do
      click_on 'activities past'
    end

    within('#activities-past-container') do
      find('.sorting', text: 'Week').click
      table_row = page.all('tr:nth-child(1)')
      date_1 = Date.today - 33
      date_2 = Date.today - 34
      date_3 = Date.today - 20
      date_4 = Date.today - 21
      row = [table_row[1], 'tr:nth-child(2)']
      content_1 = ['First Running reviewed and complete ' \
                   "#{date_1.strftime('%b %d %Y')}", 'Second Jumping reviewed' \
                   " and complete #{date_3.strftime('%b %d %Y')}"]
      content_2 = ["6 5 6 8 #{date_2.strftime('%b %d %Y')}",
                   "6 9 9 3 #{date_4.strftime('%b %d %Y')}"]
      content_3 = ['1 0 0', '3 1 1']
      row.zip(content_1, content_2, content_3) do |r, c1, c2, c3|
        within(r) do
          expect(page).to have_content c1
          expect(page).to have_content c2
          expect(page).to have_content c3
        end
      end
    end
  end

  it 'views Activities Future' do
    within('.panel.panel-default', text: 'Group Summary') do
      click_on 'activities future'
    end

    within('#activities-planned-container') do
      find('.sorting', text: 'Week').click
      table_row = page.all('tr:nth-child(1)')
      date_1 = Date.today + 4
      date_2 = Date.today - 1
      date_3 = Date.today + 7
      row = [table_row[1], 'tr:nth-child(2)']
      content_1 = ["Third Go to movie #{date_1.strftime('%b %d %Y')}",
                   "Fourth Yelling #{date_3.strftime('%b %d %Y')}"]
      content_2 = ["9 7 #{date_2.strftime('%b %d %Y')}",
                   "0 2 #{date_2.strftime('%b %d %Y')}"]
      content_3 = ['5 1 1', '5 0 0']
      row.zip(content_1, content_2, content_3) do |r, c1, c2, c3|
        within(r) do
          expect(page).to have_content c1
          expect(page).to have_content c2
          expect(page).to have_content c3
        end
      end
    end
  end

  it 'views On-My-Mind Statements' do
    within('.panel.panel-default', text: 'Group Summary') do
      click_on 'on the mind statements'
    end

    within('#on-my-mind-container') do
      find('.sorting', text: 'Week').click
      table_row = page.all('tr:nth-child(1)')
      within table_row[1] do
        date_1 = Date.today - 14
        expect(page).to have_content "First I'm feeling great!  " \
                                     "#{date_1.strftime('%b %d %Y')}"

        expect(page).to have_content '4 0 0'
      end
    end
  end

  it 'views Comments' do
    within('.panel.panel-default', text: 'Group Summary') do
      click_on 'comments'
    end

    within('#comments-container') do
      find('.sorting', text: 'Created At').click
      table_row = page.all('tr:nth-child(1)')
      date_1 = Date.today - 20
      date_2 = Date.today - 18
      date_3 = Date.today - 1
      row = [table_row[1], 'tr:nth-child(2)', 'tr:nth-child(3)']
      content = ['Second Nice job on identifying the pattern! Thought: ' \
                 "participant61, I am no good #{date_1.strftime('%b %d %Y')}",
                 'First Great activity! Activity: participant62, Jumping, ' \
                 "#{date_2.strftime('%b %d %Y')}", 'Fifth That sounds like ' \
                 'fun! Activity: participant63, Go to movie, ' \
                 "#{date_3.strftime('%b %d %Y')}"]
      num = ['1', '3', '5']
      row.zip(content, num) do |r, c, n|
        within(r) do
          expect(page).to have_content c
          expect(page).to have_content n
        end
      end
    end
  end

  it 'views Goals' do
    within('.panel.panel-default', text: 'Group Summary') do
      click_on 'goals'
    end

    within('#goals-container') do
      find('.sorting', text: 'Created Date').click
      table_row = page.all('tr:nth-child(1)')
      date_1 = Date.today - 30
      date_2 = Date.today - 26
      date_3 = Date.today - 34
      date_4 = Date.today + 3
      date_6 = Date.today - 12
      date_7 = Date.today - 14
      date_8 = Date.today - 24
      row = [table_row[1], 'tr:nth-child(2)', 'tr:nth-child(3)']
      content_1 = ['First do something  incomplete ' \
                   "#{date_1.strftime('%b %d %Y')} ", 'Third Get crazy ' \
                   "incomplete not deleted #{date_4.strftime('%m/%d/%Y')} ",
                   "Fifth go to work #{date_6.strftime('%b %d %Y')} "]
      content_2 = ["#{date_2.strftime('%m/%d/%Y')}", '', 'not deleted ' \
                   "#{date_7.strftime('%m/%d/%Y')} "]
      content_3 = ["#{date_3.strftime('%b %d %Y')}",
                   "#{date_2.strftime('%b %d %Y')}",
                   "#{date_8.strftime('%b %d %Y')}"]
      num = ['1 0 0', '2 1 0', '2 1 0']
      row.zip(content_1, content_2, content_3, num) do |r, c1, c2, c3, n|
        within(r) do
          expect(page).to have_content c1
          expect(page).to have_content c2
          expect(page).to have_content c3
          expect(page).to have_content n
        end
      end
    end
  end

  it 'views Likes' do
    within('.panel.panel-default', text: 'Group Summary') do
      begin
        tries ||= 3
        click_on 'likes'
      rescue Selenium::WebDriver::Error::UnknownError
        page.execute_script('window.scrollBy(0,500)')
        retry unless (tries -= 1).zero?
      end
    end

    within('#likes-container') do
      find('.sorting', text: 'Week').click
      date_1 = Date.today - 33
      date_2 = Date.today - 24
      date_3 = Date.today - 19
      date_4 = Date.today - 1
      table_row = page.all('tr:nth-child(1)')
      row = [table_row[1], 'tr:nth-child(2)', 'tr:nth-child(3)',
             'tr:nth-child(4)', 'tr:nth-child(5)']
      content = ['Second SocialNetworking::SharedItem Thought: I am no good ' \
                 "#{date_1.strftime('%b %d %Y')}", 'First ' \
                 'SocialNetworking::SharedItem  Goal: Get crazy ' \
                 "#{date_2.strftime('%b %d %Y')}", 'Second  ' \
                 'SocialNetworking::SharedItem  Goal: go to work ' \
                 "#{date_2.strftime('%b %d %Y')}", 'Third  ' \
                 'SocialNetworking::SharedItem  Activity: Jumping ' \
                 "#{date_3.strftime('%b %d %Y')}", 'Fifth  ' \
                 'SocialNetworking::SharedItem  Activity: Go to movie ' \
                 "#{date_4.strftime('%b %d %Y')}"]
      num = ['1', '2', '2', '3', '5']
      row.zip(content, num) do |r, c, n|
        within(r) do
          expect(page).to have_content c
          expect(page).to have_content n
        end
      end
    end
  end

  it 'uses breadcrumbs to return to home' do
    click_on 'Group'
    expect(page).to have_content 'Title: Group 6'

    within('.breadcrumb') do
      click_on 'Home'
    end

    expect(page).to have_content 'Arms'
  end
end
