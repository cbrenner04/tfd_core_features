# filename: ./spec/features/participant/core/relax_spec.rb

feature 'RELAX tool', :core, :marigold, sauce: sauce_labs do
  background do
    sign_in_pt(ENV['Participant_Email'], 'completer',
               ENV['Participant_Password'])
    visit "#{ENV['Base_URL']}/navigator/contexts/RELAX"
    expect(page).to have_content 'RELAX Home'
  end

  scenario 'Participant listens to a relax exercise' do
    click_on 'Autogenic Exercises'
    within('.jp-controls') do
      find('.jp-play').click
    end

    click_on 'Next'
    expect(page).to have_content 'Home'
  end
end
