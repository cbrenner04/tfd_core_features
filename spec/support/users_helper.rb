# frozen_string_literal: true
# filename: ./spec/support/users_helper.rb

require './lib/pages/users'
require './lib/pages/users/arms'
require './lib/pages/users/groups'
require './lib/pages/users/navigation'

def user_navigation
  @user_navigation ||= Users::Navigation.new
end

def clinician
  @clinician ||= User.new(
    user: ENV['Clinician_Email'],
    password: ENV['Clinician_Password']
  )
end

def content_author
  @content_author ||= User.new(
    user: ENV['Content_Author_Email'],
    password: ENV['Content_Author_Password']
  )
end

def researcher
  @researcher ||= User.new(
    user: ENV['Researcher_Email'],
    password: ENV['Researcher_Password']
  )
end

def super_user
  @super_user ||= User.new(
    user: ENV['User_Email'],
    password: ENV['User_Password']
  )
end

def arm_1
  @arm_1 ||= Users::Arms.new(title: 'Arm 1')
end

def group_1
  @group_1 ||= Users::Groups.new(title: 'Group 1')
end

def group_5
  @group_5 ||= Users::Groups.new(title: 'Group 5')
end

def group_6
  @group_6 ||= Users::Groups.new(title: 'Group 6')
end

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
