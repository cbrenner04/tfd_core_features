# filename: ./spec/support/users/user_login_helper.rb

require './lib/pages/users'
require './lib/pages/users/arms'
require './lib/pages/users/lessons'
require './lib/pages/users/groups'

def fake_user
  @fake_user ||= User.new(
    user: 'asdf@example.com',
    password: 'asdf'
  )
end

def login_lesson
  @login_lesson ||= Users::Lessons.new(lesson: 'fake')
end

def arm_1
  @arm_1 ||= Users::Arms.new(title: 'Arm 1')
end

def arm_3
  @arm_3 ||= Users::Arms.new(title: 'Arm 3')
end

def group_1
  @group_1 ||= Users::Groups.new(title: 'Group 1')
end

def group_5
  @group_5 ||= Users::Groups.new(title: 'Group 5')
end
