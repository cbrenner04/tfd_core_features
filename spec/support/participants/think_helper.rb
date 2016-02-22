# filename: ./spec/support/participants/think_helper.rb

require './lib/pages/participants/navigation'
require './lib/pages/participants/think'
Dir['./lib/pages/participants/think/*.rb'].each { |file| require file }

def navigation
  @navigation ||= Participants::Navigation.new
end

def think
  @think ||= Participants::Think.new
end

def identifying
  @identifying ||= Participants::Think::Identifying.new(
    first_thought: 'Testing helpful thought',
    second_thought: 'Testing negative thought',
    third_thought: 'Forced negative thought'
  )
end

def patterns
  @patterns ||= Participants::Think::Patterns.new
end

def reshape
  @reshape ||= Participants::Think::Reshape.new(
    challenge: 'Example challenge',
    action: 'Example act-as-if',
    num_thoughts: 3
  )
end

def add_new_thought
  @add_new_thought ||= Participants::Think::AddNewThought.new(
    thought: 'Testing add a new thought',
    pattern: 'Magnification or Catastrophizing',
    challenge: 'Testing challenge thought',
    action: 'Testing act-as-if action'
  )
end

def thoughts
  @thoughts ||= Participants::Think::Thoughts.new(
    thought: 'I am insignificant',
    pattern: 'Labeling and Mislabeling'
  )
end

def thought_viz
  @thought_viz ||= Participants::Think::ThoughtVisualization.new(
    pattern: 'Magnification or Catastro...',
    detail_pattern: 'Magnification or Catastro...',
    thought: 'No one likes me'
  )
end
