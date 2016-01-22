# filename: ./spec/features/participant/social_networking/landing_page_spec.rb

describe 'SocialNetworking Landing Page, ',
         :social_networking, type: :feature, sauce: sauce_labs do
  describe 'Active participant in social arm signs in,' do
    before do
      unless ENV['safari']
        sign_in_pt(ENV['Participant_Email'], 'goal_4',
                   ENV['Participant_Password'])
      end

      visit ENV['Base_URL']
    end

    it 'creates a profile' do
      page.execute_script('window.scrollBy(0,500)')
      click_on 'Create a Profile'
      unless page.has_no_css?('.modal-content')
        within('.modal-content') do
          page.all('img')[2].click
        end
      end

      expect(page).to have_content 'Fill out your profile so other group ' \
                                   'members can get to know you!'

      question = ['What are your hobbies?', 'What is your favorite color?',
                  'Animal, vegetable or mineral?', 'Group 1 profile question']
      answer = ['Running', 'Blue', 'Mineral', 'Group 1']

      question.zip(answer) do |q, a|
        page.execute_script('window.scrollBy(0,500)')
        answer_profile_question(q, a)
      end

      expect(page).to_not have_content 'Fill out your profile so other ' \
                                       'group members can get to know you!'

      within(".panel.panel-#{profile_class}.ng-scope",
             text: 'Group 1 profile question') do
        expect(page).to have_css '.fa.fa-pencil'
      end

      visit ENV['Base_URL']
      find_feed_item('Shared a Profile: Welcome, participant1')
      expect(page).to_not have_content 'Create a Profile'
    end

    it 'navigates to the profile page from a page other than home' do
      visit "#{ENV['Base_URL']}/navigator/contexts/DO"
      within '.navbar-collapse' do
        click_on 'participant1'
        click_on 'My Profile'
      end

      expect(page).to have_content 'Group 1 profile question'
    end

    it 'creates a whats on your mind post' do
      page.execute_script('window.scrollBy(0,500)')
      click_on "What's on your mind?"
      fill_in 'new-on-your-mind-description', with: "I'm feeling happy!"
      click_on 'Save'
      if ENV['sunnyside'] || ENV['marigold']
        find('#feed-btn').click
      end
      expect(page).to have_content "said I'm feeling happy!"
    end

    it 'selects link in TODO list' do
      find('.panel-title', text: 'To Do')
      page.execute_script('window.scrollBy(0,1500)')
      click_on 'THINK: Thought Distortions'
      expect(page).to have_css('h1', text: 'Thought Distortions')
    end

    it 'views another participants profile' do
      find('a', text: 'participant5').click
      expect(page).to have_content 'What is your favorite color?'
    end

    it 'likes a whats on your mind post written by another participant' do
      find('h1', text: 'HOME')
      find_feed_item('nudged participant1')
      page.execute_script('window.scrollBy(0,2000)')
      like("said it's always sunny in Philadelphia")
      within('.list-group-item.ng-scope',
             text: "said it's always sunny in Philadelphia") do
        find('.likes.ng-binding').click
        expect(page).to have_content 'participant1'
      end
    end

    it 'comments on a nudge post' do
      find('h1', text: 'HOME')
      comment('nudged participant1', 'Sweet Dude!')
      within first('.list-group-item.ng-scope',
                   text: 'nudged participant1') do
        find('.comments.ng-binding').click
        expect(page).to have_content 'participant1: Sweet Dude!'
      end
    end

    it 'checks for due date of a goal post' do
      find('h1', text: 'HOME')
      find_feed_item('nudged participant1')
      within first('.list-group-item.ng-scope', text: 'a Goal: p1 alpha') do
        page.execute_script('window.scrollTo(0,5000)')
        click_on 'More'
        expect(page)
          .to have_content "due #{Date.today.strftime('%b %d %Y')}"
      end
    end

    it 'checks for a goal that was due yesterday and is now incomplete' do
      find('h1', text: 'HOME')
      find_feed_item('nudged participant1')
      page.execute_script('window.scrollBy(0,2000)')
      expect(page).to have_content 'Did Not Complete a Goal: due yesterday'
    end

    it 'does not see an incomplete goal for a goal that was due two days ago' do
      find('h1', text: 'HOME')
      find_feed_item('nudged participant1')
      expect(page).to_not have_content 'Did Not Complete a Goal: due two days' \
                                       ' ago'
      expect(page).to have_content 'a Goal: due two days ago'
    end
  end

  describe 'Active participant signs in, resizes window to mobile' do
    before do
      unless ENV['safari']
        sign_in_pt(ENV['Participant_Email'], 'participant1',
                   ENV['Participant_Password'])
      end

      visit ENV['Base_URL']
      page.driver.browser.manage.window.resize_to(400, 800)
      page.execute_script('window.location.reload()')
    end

    after do
      page.driver.browser.manage.window.resize_to(1280, 743)
    end

    it 'is able to scroll for more feed items' do
      find('.panel-title', text: 'To Do')
      find_feed_item('nudged participant1')

      expect(page).to have_content 'nudged participant1'
    end

    it 'returns to the home page and still sees the feed' do
      visit "#{ENV['Base_URL']}/navigator/contexts/THINK"
      expect(page).to have_content 'Add a New Harmful Thought'

      find('#hamburger_button').click
      find('a', text: 'Home').click
      find('.panel-title', text: 'To Do')
      find_feed_item('nudged participant1')

      expect(page).to have_content 'nudged participant1'
    end
  end

  describe 'Active participant signs in,' do
    it 'complete last task in To Do, sees appropriate message' do
      sign_in_pt(ENV['Participant_4_Email'], 'participant1',
                 ENV['Participant_4_Password'])
      within('.panel.panel-default.ng-scope', text: 'To Do') do
        expect(page).to have_link 'Create a Profile'
        expect(page).to_not have_content 'You are all caught up! Great work!'
      end

      click_on 'Create a Profile'
      unless page.has_no_css?('.modal-content')
        within('.modal-content') do
          page.all('img')[2].click
        end
      end

      expect(page).to have_content 'Fill out your profile so other group ' \
                                   'members can get to know you!'

      page.execute_script('window.scrollBy(0,1000)')
      answer_profile_question('What are your hobbies?', 'Running')

      visit ENV['Base_URL']
      page.evaluate_script('window.confirm = function() { return true; }')
      within('.panel.panel-default.ng-scope', text: 'To Do') do
        expect(page).to_not have_link 'Create a Profile'
        expect(page).to have_content 'You are all caught up! Great work!'
      end

      sign_out('participant4')
    end
  end
end

describe 'SocialNetworking Landing Page, ',
         :tfdso, type: :feature, sauce: sauce_labs do
  describe 'Active participant in social arm signs in,' do
    if ENV['safari']
      before(:all) do
        sign_in_pt(ENV['Participant_Email'], 'participant4',
                   ENV['Participant_Password'])
      end
    end

    before do
      unless ENV['safari']
        sign_in_pt(ENV['Participant_Email'], 'participant4',
                   ENV['Participant_Password'])
      end

      visit ENV['Base_URL']
    end

    it "does not see 'Last seen:' for moderator" do
      find('h1', text: 'HOME')
      within('.col-xs-12.col-md-4.text-center.ng-scope', text: 'ThinkFeelDo') do
        expect('.profile-border.profile-last-seen')
          .to_not have_content 'Last seen:'
      end
    end
  end
end

def answer_profile_question(question, answer)
  within(".panel.panel-#{profile_class}.ng-scope", text: question) do
    find('input[type = text]').set(answer)
    page.evaluate_script('window.confirm = function() { return true; }')
    click_on 'Save'
  end
end

def profile_class
  if ENV['tfd'] || ENV['tfdso']
    'default'
  elsif ENV['sunnyside'] || ENV['marigold']
    'success'
  end
end
