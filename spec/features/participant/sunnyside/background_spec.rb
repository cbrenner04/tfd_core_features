# filename: ./spec/features/participant/sunnyside/background_spec.rb

describe 'An active participant signs in,',
         :sunnyside, :marigold, type: :feature, sauce: sauce_labs do
  if ENV['safari']
    before(:all) do
      sign_in_pt(ENV['PTBackground_Email'], 'participant5',
                 ENV['PTBackground_Password'])
    end
  end

  before do
    if ENV['safari']
      visit ENV['Base_URL']
    else
      sign_in_pt(ENV['PTBackground_Email'], 'participant5',
                 ENV['PTBackground_Password'])
    end
  end

  it 'selects a background image' do
    within('.modal-content') do
      find('#vine-image').click
    end

    expect(page).to_not have_css('.modal-content')

    visit "#{ENV['Base_URL']}/navigator/contexts/THINK"
    if ENV['safari'] || ENV['chrome']
      find('.snap-content.footless:nth-child(1)')
        .native.css_value('background-image')
        .should eq('url(http://localhost:3000/assets/vine.jpg)')
    else
      find('.snap-content.footless:nth-child(1)')
        .native.css_value('background-image')
        .should eq('url("http://localhost:3000/assets/vine.jpg")')
    end
  end

  it 'updates the background image from profile page' do
    unless page.has_no_css?('.modal-content')
      within('.modal-content') do
        find('#vine-image').click
      end
    end

    visit_profile
    click_on 'Change Background'
    within('.modal-content') do
      find('#rainbow-image').click
    end

    visit "#{ENV['Base_URL']}/navigator/contexts/THINK"
    if ENV['safari'] || ENV['chrome']
      find('.snap-content.footless:nth-child(1)')
        .native.css_value('background-image')
        .should eq('url(http://localhost:3000/assets/rainbow.jpg)')
    else
      find('.snap-content.footless:nth-child(1)')
        .native.css_value('background-image')
        .should eq('url("http://localhost:3000/assets/rainbow.jpg")')
    end
  end
end
