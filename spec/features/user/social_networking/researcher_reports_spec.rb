# frozen_string_literal: true
# filename: ./spec/features/user/social_networking/researcher_reports_spec.rb

require './lib/pages/users/reports'

def reports
  @reports ||= Users::Reports.new
end

feature 'Researcher downloads CSV Exports', :social_networking, :browser do
  background(:all) { reports.set_up }

  after(:all) { reports.tear_down }

  scenario 'Comment' do
    reports.select_and_check_file('Comment')
  end

  scenario 'Goal' do
    reports.select_and_check_file('Goal')
  end

  scenario 'Like' do
    reports.select_and_check_file('Like')
  end

  scenario 'Nudge' do
    reports.select_and_check_file('Nudge')
  end

  scenario 'Off Topic Post' do
    reports.select_and_check_file('Off Topic Post')
  end

  scenario 'Tool Share' do
    reports.select_and_check_file('Tool Share')
  end

  scenario 'Emotional Rating' do
    reports.select_and_check_file('Emotional Rating')
  end

  scenario 'Thought' do
    reports.select_and_check_file('Thought')
  end

  scenario 'Activity' do
    reports.select_and_check_file('Activity')
  end
end
