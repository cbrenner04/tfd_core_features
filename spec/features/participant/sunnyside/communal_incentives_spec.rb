# filename: ./spec/features/participant/sunnyside/communal_incentives_spec.rb

describe 'Active participant signs in,',
         :sunnyside, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_pt(ENV['Alt_Participant_Email'], 'participant_background',
                 ENV['Alt_Participant_Password'])
    end
  end

  before do
    unless ENV['safari']
      sign_in_pt(ENV['Alt_Participant_Email'], 'participant_background',
                 ENV['Alt_Participant_Password'])
    end

    visit ENV['Base_URL']
  end

  it 'views communal incentives list' do
    find('#communal-plot-btn').click
    expect(page).to have_css('.panel-title.panel-unreleased',
                             text: 'comment on 3 feed items 6/7 complete')

    within('.panel-title.panel-unreleased',
           text: 'comment on 3 feed items 6/7 complete') do
      expect(page).to have_xpath("//img[@src='/assets/flower2.png']")
    end

    page.execute_script('window.scrollBy(0,500)')
    find('.panel-title.panel-unreleased',
         text: 'comment on 3 feed items').click
    expect(page).to have_css('.list-group-item.task-status', count: '7')

    check_completed_behavior(0, "#{Date.today.strftime('%b %e')}")
    check_completed_behavior(1, "#{Date.today.strftime('%b %e')}")
    pt_incentive = page.all('.list-group-item.task-status')
    within pt_incentive[2] do
      expect(page).to_not have_css('.fa.fa-check-circle')

      expect(page).to have_content 'Completed at: ---'
    end
  end

  it 'completes communal incentive, sees communal incentive list update' do
    find('#communal-plot-btn').click
    expect(page).to have_css('.panel-title.panel-unreleased',
                             text: 'comment on 3 feed items 6/7 complete')

    within('#garden-communal') do
      expect(page).to_not have_css('#communal-plot-flower-1')
    end

    comment('Did Not Complete a Goal: p2 alpha', 'great')

    comment('said what about Bob?', 'cool')

    comment('Did Not Complete a Goal: p2 gamma', 'wow')

    visit ENV['Base_URL']
    find('#communal-plot-btn').click
    expect(page).to have_css('.panel.panel-default.panel-info',
                             text: 'comment on 3 feed items 7/7 complete')

    within('#garden-communal') do
      expect(page).to have_css('#communal-plot-flower-1')
    end

    page.execute_script('window.scroll(0,5000)')
    within('.panel.panel-default.panel-info',
           text: 'comment on 3 feed items') do
      find('.panel-title').click
    end

    (0..2).each do |i|
      check_completed_behavior(i, "#{Date.today.strftime('%b %e')}")
    end
  end
end
