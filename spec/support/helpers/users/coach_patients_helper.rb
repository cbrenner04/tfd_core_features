# frozen_string_literal: true
def dashboard_table_of_contents
  Users::PatientDashboards::TableOfContents.new
end

def group_2
  Users::Groups.new(title: 'Group 2')
end

def patient_table_group_1
  Users::PatientTable.new(participant: 'TFD-1111')
end

def patient_dashboard_group_1
  Users::PatientDashboard.new(group: 'Group 1')
end

def patient_table_group_2
  Users::PatientTable.new(participant: 'TFD-inactive')
end

def patient_dashboard_group_2
  Users::PatientDashboard.new(group: 'Group 2')
end

def participant_1_patient_table
  Users::PatientDashboard.new(participant: 'TFD-1111')
end

def completer_patient_table
  Users::PatientTable.new(participant: 'Completer')
end

def withdraw_patient_table
  Users::PatientTable.new(
    participant: 'TFD-Withdraw',
    date: short_date(today - 1)
  )
end

def data_patient_table
  Users::PatientTable.new(participant: 'TFD-data')
end

def data_dashboard
  Users::PatientDashboard.new(participant: 'TFD-data')
end

def inactive_patient_table
  Users::PatientTable.new(participant: 'TFD-inactive')
end

def inactive_dashboard
  Users::PatientDashboard.new(participant: 'TFD-inactive')
end
