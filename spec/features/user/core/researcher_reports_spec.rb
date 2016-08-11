# frozen_string_literal: true
# filename: ./spec/features/user/core/researcher_reports_spec.rb

require './lib/pages/users/reports'

def reports
  @reports ||= Users::Reports.new
end

feature 'Researcher, downloads CSV exports', :core, :browser do
  background(:all) { reports.set_up }

  after(:all) { reports.tear_down }

  scenario 'Module Page View' do
    reports.select_and_check_file('Module Page View')
  end

  scenario 'Module Session' do
    reports.select_and_check_file('Module Session')
  end

  scenario 'Lesson Viewing' do
    reports.select_and_check_file('Lesson Viewing')
  end

  scenario 'Lesson Slide View' do
    reports.scroll_down
    reports.select_and_check_file('Lesson Slide View')
  end

  scenario 'Video Session' do
    reports.select_and_check_file('Video Session')
  end

  scenario 'Task Completion' do
    reports.scroll_down
    reports.select_and_check_file('Task Completion')
  end

  scenario 'Site Session' do
    reports.scroll_down
    reports.select_and_check_file('Site Session')
  end

  scenario 'Tool Access' do
    reports.select_and_check_file('Tool Access')
  end

  scenario 'User Agent' do
    reports.scroll_down
    reports.select_and_check_file('User Agent')
  end

  scenario 'Login' do
    reports.select_and_check_file('Login')
  end

  scenario 'Events' do
    reports.select_and_check_file('Events')
  end

  scenario 'Messaging' do
    reports.select_and_check_file('Messaging')
  end
end
