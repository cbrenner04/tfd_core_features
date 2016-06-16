# frozen_string_literal: true
# filename: ./spec/support/users/social_researcher_group_helper.rb

require './lib/pages/users/groups'

def group_10
  @group_10 ||= Users::Groups.new(title: 'Group 10')
end

def group_11
  @group_11 ||= Users::Groups.new(
    title: 'Group 11',
    task: 'LEARN: Do - Planning Slideshow 3 of 4',
    task_release_day: 1
  )
end

def group_11_a
  @group_11_a ||= Users::Groups.new(
    title: 'Group 11',
    task: 'Home Introduction'
  )
end

def group_1_b
  @group_1_b ||= Users::Groups.new(
    title: 'Group 1',
    task: 'DO: #1 Awareness'
  )
end

def new_group
  @new_group ||= Users::Groups.new(
    title: 'Testing Group',
    arm: 'Arm 1',
    moderator: ENV['User_Email']
  )
end
