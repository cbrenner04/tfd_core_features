# frozen_string_literal: true
def new_group_a
  Users::Groups.new(
    title: 'Testing Group',
    arm: 'Arm 2'
  )
end

def group_11
  Users::Groups.new(
    title: 'Group 11',
    task: 'LEARN: Do - Planning Slideshow 3 of 4',
    task_release_day: 1
  )
end

def group_11_a
  Users::Groups.new(
    title: 'Group 11',
    task: 'Testing adding/updating slides/lessons'
  )
end

def group_1_b
  Users::Groups.new(
    title: 'Group 1',
    task: 'DO: #1 Awareness'
  )
end
