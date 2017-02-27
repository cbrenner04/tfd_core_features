# frozen_string_literal: true
def thoughts
  Participants::ThinkModules::Thoughts.new(
    thought: 'I am insignificant',
    pattern: 'Labeling and Mislabeling'
  )
end

def thought_viz
  Participants::ThinkModules::ThoughtVisualization.new(
    pattern: 'Magnification or Catastro...',
    detail_pattern: 'Magnification or Catastro...',
    thought: 'No one likes me'
  )
end
