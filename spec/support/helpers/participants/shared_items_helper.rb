# frozen_string_literal: true
def learn_2
  Participants::Learn.new(lesson_title: 'fake')
end

def pt_5_lesson
  Participants::Learn.new(lesson_title: 'Do - Awareness Introduction')
end

def relax
  Participants::Relax.new(feed_item: 'Audio!')
end

def pt_5_reshape
  Participants::ThinkModules::Reshape.new(
    challenge: 'Example challenge',
    action: 'Example act-as-if',
    thought: 'I am useless',
    pattern: 'Labeling and Mislabeling'
  )
end
