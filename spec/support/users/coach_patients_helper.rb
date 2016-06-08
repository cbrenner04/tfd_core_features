# frozen_string_literal: true
# filename: ./spec/support/users/coach_patients_helper.rb

require './lib/pages/users/groups'
require './lib/pages/users/patient_dashboard'

def group_2
  @group_2 ||= Users::Groups.new(title: 'Group 2')
end

def patient_dashboard_group_1
  @patient_dashboard_group_1 ||= Users::PatientDashboard.new(
    group: 'Group 1'
  )
end

def patient_dashboard_group_2
  @patient_dashboard_group_2 ||= Users::PatientDashboard.new(
    group: 'Group 2'
  )
end

def participant_1_dashboard
  @participant_1_dashboard ||= Users::PatientDashboard.new(
    participant: 'TFD-1111'
  )
end

def completer_dashboard
  @completer_dashboard ||= Users::PatientDashboard.new(
    participant: 'Completer'
  )
end

def withdraw_dashboard
  @withdraw_dashboard ||= Users::PatientDashboard.new(
    participant: 'TFD-Withdraw',
    date: short_date(today - 1)
  )
end

def data_dashboard
  @data_dashboard ||= Users::PatientDashboard.new(
    participant: 'TFD-data'
  )
end

def inactive_dashboard
  @inactive_dashboard ||= Users::PatientDashboard.new(
    participant: 'TFD-inactive'
  )
end
