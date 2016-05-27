# filename: ./spec/support/users/core_bug_helper.rb

require 'uuid'
require 'fileutils'
require './lib/pages/participants/learn'
require './lib/pages/users/arms'
require './lib/pages/users/lessons'
require './lib/pages/users/participants_set_up'
require './lib/pages/users/patient_dashboard'
require './lib/pages/users/slideshows'

def bug_participant
  @bug_participant ||= Users::ParticipantsSetUp.new(
    study_id: 'bug_test_pt',
    email: 'bug_test_pt@example.com',
    contact_preference: 'Email',
    display_name: 'Bug Tester',
    start_date: Date.today - 1,
    end_date: Date.today + 365
  )
end

def participant_61_dashboard
  @participant_61_dashboard ||= Users::PatientDashboard.new(
    participant: 'participant61',
    group: 'Group 6',
    date: Date.today - 4,
    total_logins: 11
  )
end

def patient_1
  @patient_1 ||= Users::PatientDashboard.new(
    participant: 'TFD-1111',
    group: 'Group 1',
    lesson_duration: 2
  )
end

def bug_lesson
  @bug_lesson ||= Participants::Learn.new(
    lesson_title: 'Do - Awareness Introduction',
    reading_duration: 120
  )
end

def bug_arm
  @bug_arm ||= Users::Arms.new(title: 'Test Arm for Content Management')
end

def bug_lesson_2
  @bug_lesson_2 ||= Users::Lessons.new(title: 'fake')
end

def bug_slideshow
  @bug_slideshow ||= Users::Slideshows.new(title: 'fake')
end
