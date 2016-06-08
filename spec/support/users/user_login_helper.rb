# frozen_string_literal: true
# filename: ./spec/support/users/user_login_helper.rb

require './lib/pages/users'
require './lib/pages/users/arms'
require './lib/pages/users/lessons'

def fake_user
  @fake_user ||= User.new(
    user: 'asdf@example.com',
    password: 'asdf'
  )
end

def login_lesson
  @login_lesson ||= Users::Lessons.new(lesson: 'fake')
end

def arm_3
  @arm_3 ||= Users::Arms.new(title: 'Arm 3')
end
