# filename: ./spec/features/participant/core/learn_spec.rb

require './lib/pages/participants/learn'

def learn
  @learn ||= Participants::Learn.new(
    lesson_title: 'Do - Awareness Introduction'
  )
end

feature 'LEARN tool', :core, :marigold, sauce: sauce_labs do
  background(:all) { participant_1_so5.sign_in if ENV['safari'] }

  background do
    participant_1_so5.sign_in unless ENV['safari']
    visit learn.landing_page
  end

  scenario 'Participant sees list opened to this week, collapses list' do
    learn.toggle_week_1_panel

    expect(learn).to_not have_lesson_visible
  end

  scenario 'Participant reads Lesson 1' do
    learn.read_lesson

    expect(learn).to have_read_record

    expect(learn).to have_printable_link_visible
  end

  scenario 'Participant only sees lessons listed to the end of study length' do
    expect(learn).to have_last_week_listed

    expect(learn).to_not have_week_listed_beyond_study
  end
end

feature 'LEARN tool, Participant 5', :core, :marigold, sauce: sauce_labs do
  background(:all) { participant_5_so1.sign_in if ENV['safari'] }

  scenario 'Participant views print preview of a lesson' do
    participant_5_so1.sign_in unless ENV['safari']
    visit learn.landing_page
    learn.print
    learn.return_to_lessons
  end
end
