# filename: ./spec/support/participants/learn_helper.rb

require './lib/pages/participants/learn'

def learn
  @learn ||= Participants::Learn.new(
    lesson_title: 'Do - Awareness Introduction',
    first_slide_body: 'Do - Awareness Introduction'
  )
end
