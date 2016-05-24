# filename: ./spec/support/users/super_user_helper.rb

require './lib/pages/users/arms'
require './lib/pages/users/users_set_up'

def arms
  @arms ||= Users::Arms.new(title: 'fake')
end

def new_arm
  @new_arm ||= Users::Arms.new(title: 'Test Arm')
end

def update_arm
  @update_arm ||= Users::Arms.new(
    title: 'Testing Arm',
    updated_title: 'Updated Testing Arm'
  )
end

def test_2_arm
  @test_2_arm ||= Users::Arms.new(title: 'Testing Arm 2')
end

def users
  @users ||= Users::UsersSetUp.new(email: 'fake')
end

def new_super_user
  @new_super_user ||= Users::UsersSetUp.new(email: 'superuser@test.com')
end

def update_super_user
  @update_super_user ||= Users::UsersSetUp.new(email: 'test_7@example.com')
end

def destroy_super_user
  @destroy_super_user ||= Users::UsersSetUp.new(email: 'test_8@example.com')
end
