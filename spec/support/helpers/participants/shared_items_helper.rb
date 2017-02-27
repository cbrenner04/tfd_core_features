# frozen_string_literal: true
def think
  Participants::Think.new
end

def pt_1_identify_thought_1
  Participants::ThinkModules::Identifying.new(
    feed_item: 'Public thought 1',
    timestamp: "Today at #{Time.now.strftime('%l')}"
  )
end

def pt_1_identify_thought_2
  Participants::ThinkModules::Identifying.new(feed_item: 'Private thought 1')
end

def pt_1_add_new_thought_1
  Participants::ThinkModules::AddNewThought.new(
    thought: 'Public thought 3',
    pattern: 'Magnification or Catastrophizing',
    challenge: 'Testing challenge thought',
    action: 'Testing act-as-if action',
    timestamp: "Today at #{Time.now.strftime('%-l')}"
  )
end

def pt_1_add_new_thought_2
  Participants::ThinkModules::AddNewThought.new(
    thought: 'Private thought 2',
    pattern: 'Magnification or Catastrophizing',
    challenge: 'Testing challenge thought',
    action: 'Testing act-as-if action'
  )
end

def ns_pt_identifying
  Participants::ThinkModules::Identifying.new(first_thought: 'fake')
end

def ns_pt_add_new_thought
  Participants::ThinkModules::Identifying.new(thought: 'fake')
end

def learn_2
  Participants::Learn.new(lesson_title: 'fake')
end

def pt_5_lesson
  Participants::Learn.new(lesson_title: 'Do - Awareness Introduction')
end

def relax
  Participants::Relax.new(feed_item: 'Audio!')
end

def pt_5_pattern
  Participants::ThinkModules::Patterns.new(
    thought: 'ARG!',
    pattern: 'Personalization'
  )
end

def pt_5_reshape
  Participants::ThinkModules::Reshape.new(
    challenge: 'Example challenge',
    action: 'Example act-as-if',
    thought: 'I am useless',
    pattern: 'Labeling and Mislabeling'
  )
end
