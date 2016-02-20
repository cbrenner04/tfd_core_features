# filename: ./spec/features/participant/core/learn_spec.rb

feature 'LEARN tool', :core, :marigold, sauce: sauce_labs do
  background(:all) { participant_1.sign_in if ENV['safari'] }

  background do
    participant_1.sign_in unless ENV['safari']
    visit learn.landing_page
  end

  scenario 'Participant sees list opened to this week, collapses list' do
    learn.toggle_week_1_panel

    expect(learn).to_not have_do_intro_lesson_visible
  end

  scenario 'Participant reads Lesson 1' do
    learn.read_do_intro_lesson

    expect(learn).to have_read_record

    expect(learn).to have_printable_link_visible
  end

  scenario 'Participant only sees lessons listed to the end of study length' do
    expect(learn).to have_last_week_listed

    expect(learn).to_not have_week_list_beyond_study
  end
end

feature 'LEARN tool, Participant 5', :core, :marigold, sauce: sauce_labs do
  background(:all) { participant_5.sign_in if ENV['safari'] }

  background do
    participant_5.sign_in unless ENV['safari']
    visit learn.landing_page
  end

  scenario 'Participant views print preview of a lesson' do
    learn.print
    learn.return_to_lessons
  end
end
