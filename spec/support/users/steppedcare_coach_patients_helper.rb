# filename: ./spec/support/users/steppedcare_coach_patients_helper.rb

require './lib/pages/users/patient_dashboard'

def participant_1_dashboard
  @participant_1_dashboard ||= Users::PatientDashboard.new(
    participant: 'TFD-1111',
    group: 'Group 1'
  )
end

def participant_61_dashboard
  @participant_61_dashboard ||= Users::PatientDashboard.new(
    participant: 'participant61',
    group: 'Group 6',
    total_logins: 11,
    date: Date.today - 4
  )
end

def phq_group_dashboard
  @phq_group_dashboard ||= Users::PatientDashboard.new(
    group: 'PHQ Group'
  )
end

def phq1_dashboard
  @phq1_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-1',
    date: Date.today - 4,
    most_recent_phq_score: 17
  )
end

def phq2_dashboard
  @phq2_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-2'
  )
end

def phq3_dashboard
  @phq3_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-3',
    date: Date.today - 18
  )
end

def phq4_dashboard
  @phq4_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-4'
  )
end

def phq5_dashboard
  @phq5_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-5'
  )
end

def phq6_dashboard
  @phq6_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-6',
    date: Date.today - 4,
    most_recent_phq_score: 17
  )
end

def phq7_dashboard
  @phq7_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-7',
    date: Date.today - 4,
    most_recent_phq_score: 17
  )
end

def phq8_dashboard
  @phq8_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-8',
    date: Date.today - 4,
    most_recent_phq_score: 6
  )
end

def phq9_dashboard
  @phq9_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-9',
    date: Date.today - 4,
    most_recent_phq_score: 4
  )
end

def phq10_dashboard
  @phq10_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-10',
    date: Date.today - 4,
    most_recent_phq_score: 17
  )
end

def phq11_dashboard
  @phq11_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-11',
    date: Date.today - 4,
    most_recent_phq_score: 16
  )
end

def phq12_dashboard
  @phq12_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-12',
    date: Date.today - 4,
    most_recent_phq_score: 4
  )
end

def phq13_dashboard
  @phq13_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-13',
    date: Date.today - 4,
    most_recent_phq_score: 17
  )
end

def phq14_dashboard
  @phq14_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-14',
    date: Date.today - 4,
    most_recent_phq_score: 12
  )
end

def phq15_dashboard
  @phq15_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-15',
    date: Date.today - 4,
    most_recent_phq_score: 13
  )
end

def phq16_dashboard
  @phq16_dashboard ||= Users::PatientDashboard.new(
    participant: 'PHQ-16',
    date: Date.today - 4,
    most_recent_phq_score: 12
  )
end
