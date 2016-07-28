# frozen_string_literal: true
# filename: ./spec/features/user/marigold/researcher_reports_spec.rb

require './lib/pages/users/reports'

def reports
  @reports ||= Users::Reports.new
end

feature 'Researcher, downloads CSV exports', :marigold do
  background(:all) { reports.set_up }

  after(:all) { reports.tear_down }

  scenario 'Commitments' do
    reports.select_file('Commitments')
    reports.check_file('commitment')
  end

  scenario 'DICE Surveys' do
    reports.select_file('DICE Surveys')
    reports.check_file('stressassessment')
  end

  scenario 'Emotional Rating' do
    reports.select_file('Emotional Rating')
    reports.check_file('emotionalrating')
  end

  scenario 'Gamification: Behavior' do
    reports.select_file('Gamification: Behavior')
    reports.check_file('behavior')
  end

  scenario 'Gamification: Incentive' do
    reports.select_file('Gamification: Incentive')
    reports.check_file('incentive')
  end

  scenario 'Gamification: Participant Behavior' do
    reports.select_file('Gamification: Participant Behavior')
    reports.check_file('participantbehavior')
  end

  scenario 'Gamification: Participant Incentive' do
    reports.select_file('Gamification: Participant Incentive')
    reports.check_file('participantincentive')
  end

  scenario 'Login' do
    reports.select_file('Login')
    reports.check_file('login')
  end

  scenario 'Module Page View' do
    reports.scroll_down
    reports.select_file('Module Page View')
    reports.check_file('modulepageview')
  end

  scenario 'Module Session' do
    reports.select_file('Module Session')
    reports.check_file('modulesession')
  end

  scenario 'Participant Profile' do
    reports.scroll_down
    reports.select_file('Participant Profile')
    reports.check_file('participantprofile')
  end

  scenario 'Practice: Activation Activity' do
    reports.scroll_down
    reports.select_file('Practice: Activation Activity')
    reports.check_file('activationactivity')
  end

  scenario 'Practice: Gratitude Journal' do
    reports.scroll_down
    reports.select_file('Practice: Gratitude Journal')
    reports.check_file('gratituderecording')
  end

  scenario 'Practice: Kindness' do
    reports.select_file('Practice: Kindness')
    reports.check_file('kindness')
  end

  scenario 'Practice: Mindfulness Activity' do
    reports.scroll_down
    reports.select_file('Practice: Mindfulness Activity')
    reports.check_file('mindfulactivity')
  end

  scenario 'Practice: Mindfulness Meditation' do
    reports.select_file('Practice: Mindfulness Meditation')
    reports.check_file('meditation')
  end

  scenario 'Practice: Positive Experience' do
    reports.scroll_down
    reports.select_file('Practice: Positive Experience')
    reports.check_file('experience')
  end

  scenario 'Practice: Reappraisal' do
    reports.scroll_down
    reports.select_file('Practice: Reappraisal')
    reports.check_file('reappraisal')
  end

  scenario 'Practice: Strength' do
    reports.select_file('Practice: Strength')
    reports.check_file('strength')
  end

  scenario 'Site Session' do
    reports.scroll_down
    reports.select_file('Site Session')
    reports.check_file('sitesession')
  end

  scenario 'Skill: Feedback' do
    reports.scroll_down
    reports.select_file('Skill: Feedback')
    reports.check_file('lessonfeedback')
  end

  scenario 'Skill: Slide View' do
    reports.select_file('Skill: Slide View')
    reports.check_file('lessonslideview')
  end

  scenario 'Skill: Viewing' do
    reports.scroll_down
    reports.select_file('Skill: Viewing')
    reports.check_file('lessonviewing')
  end

  scenario 'Social: Comment' do
    reports.scroll_down
    reports.select_file('Social: Comment')
    reports.check_file('comment')
  end

  scenario 'Social: Like' do
    reports.scroll_down
    reports.select_file('Social: Like')
    reports.check_file('like')
  end

  scenario 'Social: Nudge' do
    reports.scroll_down
    reports.select_file('Social: Nudge')
    reports.check_file('nudge')
  end

  scenario 'Social: On My Mind Statements' do
    reports.scroll_down
    reports.select_file('Social: On My Mind Statements')
    reports.check_file('offtopicpost')
  end

  scenario 'Task Completion' do
    reports.select_file('Task Completion')
    reports.check_file('taskcompletion')
  end

  scenario 'Tool Access' do
    reports.scroll_down
    reports.select_file('Tool Access')
    reports.check_file('toolaccess')
  end

  scenario 'Unsubscribed Phone Numbers' do
    reports.scroll_down
    reports.select_file('Unsubscribed Phone Numbers')
    reports.check_file('smsdeliveryerrorrecord')
  end

  scenario 'User Agent' do
    reports.scroll_down
    reports.select_file('User Agent')
    reports.check_file('useragent')
  end

  scenario 'Video Session' do
    reports.scroll_down
    reports.select_file('Video Session')
    reports.check_file('videosession')
  end
end
