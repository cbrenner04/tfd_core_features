require './lib/pages/participants'
require './lib/pages/participants/social_networking'
require './lib/pages/users/patient_dashboard'

def patient_dashboard_group_1
  @patient_dashboard_group_1 ||= Users::PatientDashboard.new(group: 'Group 1')
end

def patient_dashboard_group_6
  @patient_dashboard_group_6 ||= Users::PatientDashboard.new(group: 'Group 6')
end

def patient_data_dashboard
  @patient_data_dashboard ||= Users::PatientDashboard.new(
    participant: 'TFD-data'
  )
end

def patient_61_dashboard
  @patient_61_dashboard ||= Users::PatientDashboard.new(
    participant: 'participant61',
    total_logins: 11,
    date: Date.today - 4
  )
end

def patient_65_dashboard
  @patient_65_dashboard ||= Users::PatientDashboard.new(
    participant: 'participant65'
  )
end

def participant_61
  @participant_61 ||= Participant.new(
    participant: ENV['PT61_Email'],
    password: ENV['PT61_Password']
  )
end

def social_networking
  @social_networking ||= Participants::SocialNetworking.new
end
