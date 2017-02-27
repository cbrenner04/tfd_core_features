# frozen_string_literal: true
def arms
  Users::Arms.new(title: 'fake')
end

def new_arm
  Users::Arms.new(title: 'Test Arm')
end

def update_arm
  Users::Arms.new(
    title: 'Testing Arm',
    updated_title: 'Updated Testing Arm'
  )
end

def test_2_arm
  Users::Arms.new(title: 'Testing Arm 2')
end

def users
  Users::UsersSetUp.new(email: 'fake')
end

def new_super_user
  Users::UsersSetUp.new(email: 'superuser@test.com')
end

def update_super_user
  Users::UsersSetUp.new(email: 'test_7@example.com')
end

def destroy_super_user
  Users::UsersSetUp.new(email: 'test_8@example.com')
end
