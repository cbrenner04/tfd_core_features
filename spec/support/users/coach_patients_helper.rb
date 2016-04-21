# filename: ./spec/support/users/coach_patients_helper.rb

require './lib/pages/users/patient_dashboard'

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
    date: (Date.today - 1).strftime('%m/%d/%Y')
  )
end

def data_dashboard
  @data_dashboard ||= Users::PatientDashboard.new(
    participant: 'TFD-data'
  )
end

def inactive_dashboard
  @inactive_dashboard ||= Users::PatientDashboard.new(
    particiapnts: 'TFD-inactive'
  )
end
