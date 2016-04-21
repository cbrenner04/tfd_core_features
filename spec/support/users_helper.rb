# filename: ./spec/support/users_helper.rb

require './lib/pages/users'
require './lib/pages/users/navigation'

def navigation
  @navigation ||= Users::Navigation.new
end

def clinician
  @clinician ||= Users.new(
    user: ENV['Clinician_Email'],
    password: ENV['Clinician_Password']
  )
end

def content_author
  @content_author ||= Users.new(
    user: ENV['Content_Author_Email'],
    password: ENV['Content_Author_Password']
  )
end
