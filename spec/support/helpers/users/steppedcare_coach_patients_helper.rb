# frozen_string_literal: true
def phq_group
  Users::Groups.new(title: 'PHQ Group')
end

def dashboard_table_of_contents
  Users::PatientDashboards::TableOfContents.new
end

def participant_1_patient_table
  Users::PatientTable.new(participant: 'TFD-1111')
end

def participant_1_dashboard
  Users::PatientDashboard.new(
    participant: 'TFD-1111',
    group: 'Group 1'
  )
end

def participant_61_patient_table
  Users::PatientTable.new(
    participant: 'participant61',
    total_logins: 11,
    date: today - 4
  )
end

def participant_61_dashboard
  Users::PatientDashboard.new(
    participant: 'participant61',
    group: 'Group 6',
    total_logins: 11,
    date: today - 4
  )
end

def phq_group_patient_table
  Users::PatientTable.new(participant: 'PHQ-1')
end

def phq_group_dashboard
  Users::PatientDashboard.new(group: 'PHQ Group')
end

def phq1_patient_table
  Users::PatientTable.new(
    participant: 'PHQ-1',
    date: today - 4
  )
end

def phq1_dashboard
  Users::PatientDashboard.new(
    participant: 'PHQ-1',
    date: today - 4,
    most_recent_phq_score: 17
  )
end

def phq2_patient_table
  Users::PatientTable.new(participant: 'PHQ-2')
end

def phq3_patient_table
  Users::PatientTable.new(participant: 'PHQ-3')
end

def phq3_dashboard
  Users::PatientDashboard.new(
    participant: 'PHQ-3',
    date: today - 18
  )
end

def phq4_patient_table
  Users::PatientTable.new(participant: 'PHQ-4')
end

def phq4_dashboard
  Users::PatientDashboard.new(participant: 'PHQ-4')
end

def phq5_patient_table
  Users::PatientTable.new(participant: 'PHQ-5')
end

def phq5_dashboard
  Users::PatientDashboard.new(participant: 'PHQ-5')
end

def phq6_patient_table
  Users::PatientTable.new(
    participant: 'PHQ-6',
    date: today - 4,
    most_recent_phq_score: 17
  )
end

def phq7_patient_table
  Users::PatientTable.new(
    participant: 'PHQ-7',
    date: today - 4,
    most_recent_phq_score: 17
  )
end

def phq8_patient_table
  Users::PatientTable.new(
    participant: 'PHQ-8',
    date: today - 4,
    most_recent_phq_score: 6
  )
end

def phq9_patient_table
  Users::PatientTable.new(
    participant: 'PHQ-9',
    date: today - 4,
    most_recent_phq_score: 4
  )
end

def phq10_patient_table
  Users::PatientTable.new(
    participant: 'PHQ-10',
    date: today - 4,
    most_recent_phq_score: 17
  )
end

def phq11_patient_table
  Users::PatientTable.new(
    participant: 'PHQ-11',
    date: today - 4,
    most_recent_phq_score: 16
  )
end

def phq12_patient_table
  Users::PatientTable.new(
    participant: 'PHQ-12',
    date: today - 4,
    most_recent_phq_score: 4
  )
end

def phq13_patient_table
  Users::PatientTable.new(
    participant: 'PHQ-13',
    date: today - 4,
    most_recent_phq_score: 17
  )
end

def phq14_patient_table
  Users::PatientTable.new(
    participant: 'PHQ-14',
    date: today - 4,
    most_recent_phq_score: 12
  )
end

def phq15_patient_table
  Users::PatientTable.new(
    participant: 'PHQ-15',
    date: today - 4,
    most_recent_phq_score: 13
  )
end

def phq16_patient_table
  Users::PatientTable.new(
    participant: 'PHQ-16',
    date: today - 4,
    most_recent_phq_score: 12
  )
end
