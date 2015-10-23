# filename: ./spec/features/participant/sunnyside/individual_incentives_spec.rb

describe 'Individual incentives',
         :sunnyside, type: :feature, sauce: sauce_labs do
  describe 'Active participant signs in,' do
    before do
      unless ENV['safari']
        sign_in_pt(ENV['Alt_Participant_Email'], 'participant3',
                   ENV['Alt_Participant_Password'])
      end

      visit ENV['Base_URL']
    end

    it 'visits profile page to see a list of incentives & related behaviors' do
      visit_profile
      expect(page).to have_css('.panel-title.panel-unreleased',
                               text: 'like 3 feed items 0/3 complete')

      within('.panel-title.panel-unreleased',
             text: 'like 3 feed items 0/3 complete') do
        expect(page).to have_xpath("//img[@src='/assets/flower1.png']")
      end

      find('.panel-title.panel-unreleased', text: 'like 3 feed items').click
      expect(page).to have_css('.list-group-item.task-status', count: '3')
    end

    it 'completes a behavior for an incentive, sees incentive list update' do
      find_feed_item('Did Not Complete a Goal: p2 alpha')
      like('Did Not Complete a Goal: p2 alpha')

      # toast expectation commented out due to issues w/ its functionality
      # and WebDriver

      # expect(page).to have_css('.alert.alert-success.alert-dismissible',
      #                          text: 'Congratulations: you completed the ' \
      #                          "behavior: Like a person's shared content")

      visit_profile
      expect(page).to have_css('.panel-title.panel-unreleased',
                               text: 'like 3 feed items 1/3 complete')

      find('.panel-title.panel-unreleased', text: 'like 3 feed items').click
      expect(page).to have_content "Like a person's shared content."

      page.execute_script('window.scrollBy(0,500)')
      check_completed_behavior(0, "#{Date.today.strftime('%b %e')}")
    end

    it 'completes all behaviors for an incentive, ' \
       'sees the incentive list update' do
      find_feed_item('said what about Bob?')
      page.execute_script('window.scrollTo(0,10000)')
      like('Did Not Complete a Goal: p2 alpha')
      like('Did Not Complete a Goal: p2 gamma')
      page.execute_script('window.scrollBy(0,1000)')
      like('said what about Bob?')

      # toast expectation commented out due to issues w/ its functionality
      # and WebDriver

      # expect(page).to have_css('.alert.alert-success.alert-dismissible',
      #                          text: 'Congratulations: you completed the ' \
      #                          'incentive: like 3 feed items')

      visit_profile
      expect(page).to have_css('.panel.panel-default.panel-info',
                               text: 'like 3 feed items 3/3 complete')

      within('#garden-individual') do
        expect(page).to have_xpath("//img[@src='/assets/flower1.png']")
      end

      within('.panel.panel-default.panel-info', text: 'like 3 feed items') do
        find('.panel-title').click
      end

      expect(page).to have_content "Like a person's shared content."

      (0..2).each do |i|
        check_completed_behavior(i, "#{Date.today.strftime('%b %e')}")
      end
    end

    it 'completes a repeatable incentive for a second time' do
      visit_profile
      within('#garden-individual') do
        expect(page).to have_xpath("//img[@src='/assets/flower3.png']")
      end

      expect(page)
        .to have_css('.panel.panel-default.panel-info',
                     text: 'create a goal # of times complete: 1')

      visit "#{ENV['Base_URL']}/navigator/contexts/ACHIEVE"
      click_on '+ add a goal'
      fill_in 'new-goal-description', with: 'do something fun'
      choose '8 weeks (end of study)'
      click_on 'Save'
      page.should have_css('.list-group-item.ng-scope',
                           text: 'do something fun')
      visit ENV['Base_URL']
      visit_profile
      within('#garden-individual') do
        expect(page)
          .to have_css('.ui-draggable.ui-draggable-handle', count: '3')
      end

      expect(page)
        .to have_css('.panel.panel-default.panel-info',
                     text: 'create a goal # of times complete: 2')
    end

    it 'checks completed behaviors and incentives of another participant' do
      within('.col-xs-12.col-md-4.text-center', text: 'SunnySide') do
        within('.garden.small-garden') do
          expect(page).to have_xpath("//img[@src='/assets/flower1.png']")
        end

        click_on 'SunnySide'
      end

      expect(page).to have_css('.panel.panel-default.panel-info',
                               text: 'like 3 feed items 3/3 complete')

      within('.large-garden') do
        expect(page).to have_xpath("//img[@src='/assets/flower1.png']")
      end

      within('.panel.panel-default.panel-info', text: 'like 3 feed items') do
        find('.panel-title').click
      end

      expect(page).to have_content "Like a person's shared content."

      (0..2).each do |i|
        check_completed_behavior(i, "#{Date.today.strftime('%b %e')}")
      end
    end
  end
end
