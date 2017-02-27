# frozen_string_literal: true
def researcher_users
  Users::UsersSetUp.new(email: 'fake')
end

def new_researcher
  Users::UsersSetUp.new(
    email: 'researcher@test.com',
    role: 'Researcher'
  )
end

def test_1_user
  Users::UsersSetUp.new(email: 'test_1@example.com')
end

def test_2_user
  Users::UsersSetUp.new(email: 'test_2@example.com')
end

def new_clinician
  Users::UsersSetUp.new(
    email: 'clinician@test.com',
    role: 'Clinician'
  )
end

def test_3_user
  Users::UsersSetUp.new(email: 'test_3@example.com')
end

def test_4_user
  Users::UsersSetUp.new(email: 'test_4@example.com')
end

def new_content_author
  Users::UsersSetUp.new(
    email: 'contentauthor@test.com',
    role: 'Content Author'
  )
end

def test_5_user
  Users::UsersSetUp.new(email: 'test_5@example.com')
end

def test_6_user
  Users::UsersSetUp.new(email: 'test_6@example.com')
end
