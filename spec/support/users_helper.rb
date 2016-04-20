# filename: ./spec/support/users_helper.rb

require './lib/pages/users'

def clinician
  @clincian ||= Users.new(
    user: ENV['Clinician_Email'],
    password: ENV['Clinician_Password']
  )
end
