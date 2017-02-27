# frozen_string_literal: true
def participant_1_soc
  Participant.new(
    participant: ENV['Participant_Email'],
    old_participant: 'completer',
    password: ENV['Participant_Password']
  )
end

def relax
  Participants::Relax.new(feed_item: 'fake')
end

feature 'RELAX tool', :core, :marigold, sauce: sauce_labs do
  scenario 'Participant listens to a relax exercise' do
    participant_1_soc.sign_in
    visit relax.landing_page

    expect(relax).to be_visible

    relax.open_autogenic_exercises
    relax.play_audio
    relax.finish
  end
end
