# filename: ./spec/features/participant/incentives/individual_incentives_spec.rb

feature 'Individual incentives', :incentives, sauce: sauce_labs do
  background do
    unless ENV['safari']
      sign_in_pt(ENV['Alt_Participant_Email'], 'participant3',
                 ENV['Alt_Participant_Password'])
    end

    visit ENV['Base_URL']
  end

  scenario 'Participant views list of incentives & related behaviors' do
    visit_profile
    within('.panel-title.panel-unreleased',
           text: 'like 3 feed items 0/3 complete') do
      expect(page).to have_xpath("//img[@src='/assets/flower1.png']")
    end

    page.execute_script('window.scrollBy(0,500)')
    find('.panel-title.panel-unreleased', text: 'like 3 feed items').click
    expect(page).to have_css('.list-group-item.task-status', count: '3')
  end

  scenario 'Participant completes a behavior, sees incentive list update' do
    find_feed_item('Did Not Complete a Goal: p2 alpha')
    like('Did Not Complete a Goal: p2 alpha')
    visit_profile
    find('.panel-title.panel-unreleased',
         text: 'like 3 feed items 1/3 complete')

    page.execute_script('window.scrollBy(0,500)')
    find('.panel-title.panel-unreleased', text: 'like 3 feed items').click
    first('.list-group-item', text: "Like a person's shared content.")
    page.execute_script('window.scrollBy(0,500)')
    check_completed_behavior(0, "#{Time.now.strftime('%b %d %Y %I')}")
  end

  scenario 'Participant completes all behaviors, sees incentive list update' do
    find_feed_item('said what about Bob?')
    page.execute_script('window.scrollTo(0,10000)')
    like('Did Not Complete a Goal: p2 alpha')
    like('Did Not Complete a Goal: p2 gamma')
    page.execute_script('window.scrollBy(0,1000)')
    like('said what about Bob?')
    visit_profile
    expect(page).to have_css('.panel.panel-default.panel-info',
                             text: 'like 3 feed items 3/3 complete')

    within('#garden-individual') do
      expect(page).to have_xpath("//img[@src='/assets/flower1.png']")
    end

    page.execute_script('window.scrollBy(0,500)')
    within('.panel.panel-default.panel-info', text: 'like 3 feed items') do
      find('.panel-title').click
    end

    first('.list-group-item', text: "Like a person's shared content.")
    (0..2).each do |i|
      check_completed_behavior(i, "#{Time.now.strftime('%b %d %Y %I')}")
    end
  end

  scenario 'Participant completes a repeatable incentive for a second time' do
    visit_profile
    within('#garden-individual') do
      expect(page).to have_xpath("//img[@src='/assets/flower3.png']")
    end

    find('.panel.panel-default.panel-info',
         text: 'create a goal # of times complete: 1')

    visit "#{ENV['Base_URL']}/navigator/contexts/ACHIEVE"
    click_on '+ add a goal'
    fill_in 'new-goal-description', with: 'do something fun'
    choose 'end of study'
    click_on 'Save'
    find('.list-group-item.ng-scope', text: 'do something fun')
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

  scenario 'Participant checks completed incentives of another participant' do
    within('.col-xs-12.col-md-4.text-center', text: 'participant2') do
      within('.garden.small-garden') do
        expect(page).to have_xpath("//img[@src='/assets/flower1.png']")
      end

      click_on 'participant2'
    end

    find('.panel.panel-default.panel-info',
         text: 'like 3 feed items 3/3 complete')

    within('.large-garden') do
      expect(page).to have_xpath("//img[@src='/assets/flower1.png']")
    end

    page.execute_script('window.scrollBy(0,500)')
    within('.panel.panel-default.panel-info', text: 'like 3 feed items') do
      find('.panel-title').click
    end

    first('.list-group-item', text: "Like a person's shared content.")
    (0..2).each do |i|
      check_completed_behavior(i, "#{Time.now.strftime('%b %d %Y %I')}")
    end

    first('.close').click while has_css?('.alert', text: 'Congratulations')

    visit ENV['Base_URL']
    sign_out('participant3')
  end
end
