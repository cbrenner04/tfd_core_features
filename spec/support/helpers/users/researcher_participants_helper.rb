# frozen_string_literal: true
def researcher_participants
  Users::ParticipantsSetUp.new(study_id: 'none')
end

def new_participant
  Users::ParticipantsSetUp.new(
    study_id: 'Tests',
    email: 'test@example.com',
    contact_preference: 'Email'
  )
end

def update_participant
  Users::ParticipantsSetUp.new(
    study_id: 'test_1',
    updated_study_id: 'Updated test_1',
    email: 'updated_test_1@example.com',
    contact_preference: 'Email'
  )
end

def test_2_participant
  Users::ParticipantsSetUp.new(study_id: 'test_2')
end

def invalid_start_participant
  Users::ParticipantsSetUp.new(
    study_id: 'test_3',
    start_date: 'mm/dd/yyyy',
    end_date: today + 365
  )
end

def invalid_end_participant
  Users::ParticipantsSetUp.new(
    study_id: 'test_3',
    start_date: today - 1,
    end_date: 'mm/dd/yyyy'
  )
end

def past_end_participant
  Users::ParticipantsSetUp.new(
    study_id: 'test_3',
    start_date: today - 1,
    end_date: today - 5
  )
end

def test_4_participant
  Users::ParticipantsSetUp.new(
    study_id: 'test_4',
    start_date: today - 1,
    end_date: today + 365
  )
end

def test_5_participant
  Users::ParticipantsSetUp.new(study_id: 'test_5')
end

def test_6_participant
  Users::ParticipantsSetUp.new(study_id: 'test_6')
end
