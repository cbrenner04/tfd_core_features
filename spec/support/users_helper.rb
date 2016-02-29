# filename: ./spec/support/users_helper.rb

require './lib/pages/users'

def clinician_som
  @clincian_som ||= Users.new(
    user: ENV['Clinician_Email'],
    old_user: 'mobilecompleter',
    password: ENV['Clinician_Password']
  )
end

def clinician_sopt2
  @clinician_sopt2 ||= Users.new(
    user: ENV['Clinician_Email'],
    old_user: 'participant2',
    password: ENV['Clinician_Password']
  )
end
