# filename: ./spec/support/users/social_researcher_group_helper.rb

require './lib/pages/users/groups'

def group_8
  @group_8 ||= Users::Groups.new(
    title: 'Group 8',
    updated_title: 'Updated Group 8'
  )
end

def group_9
  @group_9 ||= Users::Groups.new(
    title: 'Group 9',
    updated_moderator: ENV['User_Email']
  )
end

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
    task: 'Testing adding/updating slides/lessons'
  )
end

def new_group
  @new_group ||= Users::Groups.new(
    title: 'Testing Group',
    arm: 'Arm 1',
    moderator: ENV['User_Email']
  )
end