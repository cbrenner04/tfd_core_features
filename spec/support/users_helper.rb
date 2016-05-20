# filename: ./spec/support/users_helper.rb

require './lib/pages/users'
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
