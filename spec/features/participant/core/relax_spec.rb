# filename: ./spec/features/participant/core/relax_spec.rb

require './lib/pages/participants/relax'

def relax
  @relax ||= Participants::Relax.new
end

feature 'RELAX tool', :core, :marigold, sauce: sauce_labs do
  background do
    participant_1_soc.sign_in
    visit relax.landing_page
    expect(relax).to be_visible
  end

  scenario 'Participant listens to a relax exercise' do
    relax.open_autogenic_exercises
    relax.play_audio
    relax.finish
  end
end
