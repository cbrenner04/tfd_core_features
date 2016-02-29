# filename: ./spec/support/users/coach_patients_helper.rb

require './lib/pages/users/navigation'
require './lib/pages/users/patient_dashboard'

def patient_dashboard
  @patient_dashboard ||= Users::PatientDashboard.new(participant: 'fake')
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
