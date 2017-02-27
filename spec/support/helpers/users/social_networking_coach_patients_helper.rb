# frozen_string_literal: true
def patient_table_group_1
  Users::PatientTable.new(participant: 'TFD-1111')
end

def patient_dashboard_group_1
  Users::PatientDashboard.new(group: 'Group 1')
end

def patient_table_group_6
  Users::PatientTable.new(participant: 'participant61')
end

def patient_dashboard_group_6
  Users::PatientDashboard.new(group: 'Group 6')
end

def patient_data_patient_table
  Users::PatientTable.new(participant: 'TFD-data')
end

def patient_data_dashboard
  Users::PatientDashboard.new(participant: 'TFD-data')
end

def patient_61_patient_table
  Users::PatientTable.new(
    participant: 'participant61',
    date: today - 4
  )
end

def patient_61_dashboard
  Users::PatientDashboard.new(
    participant: 'participant61',
    total_logins: 11,
    date: today - 4
  )
end

def patient_65_patient_table
  Users::PatientTable.new(participant: 'participant65')
end

def participant_61
  Participant.new(
    participant: ENV['PT61_Email'],
    password: ENV['PT61_Password']
  )
end

def social_networking
  Participants::SocialNetworking.new
end
