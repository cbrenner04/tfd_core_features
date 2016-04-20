# filename: ./spec/features/participants/marigold/feel_spec.rb

require './lib/pages/participants/feel'
require './lib/pages/participants/feel/emotion_tracking'

def feel
  @feel ||= Participants::Feel.new
end

def emotions
  @emotions ||= Participants::Feel::EmotionsTracking.new
end

feature 'FEEL tool', :marigold, sauce: sauce_labs do
  scenario 'Participant tracks their emotions for the day' do
    marigold_participant_so3.sign_in
    visit feel.landing_page
    emotions.open

    expect(emotions).to have_emotions

    emotions.rate

    expect(emotions).to be_saved
  end
end