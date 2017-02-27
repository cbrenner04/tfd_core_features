# frozen_string_literal: true
def lessons
  Users::Lessons.new(lesson: 'New lesson')
end

def lessons_2
  Users::Lessons.new(
    lesson: 'Do - Doing Introduction',
    slide_title: 'Welcome back!',
    new_title: 'Do - Doing Introduction 123'
  )
end

def lessons_3
  Users::Lessons.new(lesson: 'Lessons for tests')
end
