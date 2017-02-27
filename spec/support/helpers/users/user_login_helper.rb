# frozen_string_literal: true
def fake_user
  User.new(
    user: 'asdf@example.com',
    password: 'asdf'
  )
end

def login_lesson
  Users::Lessons.new(lesson: 'fake')
end

def arm_3
  Users::Arms.new(title: 'Arm 3')
end
