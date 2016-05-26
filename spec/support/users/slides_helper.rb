require './lib/pages/users/lessons'
require './lib/pages/users/slides'
require './lib/pages/users/slideshows'

def slide_test_lesson
  @slide_test_lesson ||= Users::Lessons.new(
    lesson: 'Testing adding/updating slides/lessons'
  )
end

def test_slide_2
  @test_slide_2 ||= Users::Slides.new(
    title: 'Test slide 2',
    body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus vi'
  )
end

def slide_3
  @slide_3 ||= Users::Slides.new(title: 'Slide 3')
end

def slide_2
  @slide_2 ||= Users::Slides.new(
    title: 'Slide 2',
    body: 'Log in once a day'
  )
end

def slide_5
  @slide_5 ||= Users::Slides.new(
    title: 'Slide 5'
  )
end

def video_slide
  @video_slide ||= Users::Slides.new(
    title: 'Test video slide 2',
    body: 'This is a video slide',
    type: 'video',
    video_id: '111087687'
  )
end

def slide_4
  @slide_4 ||= Users::Slides.new(title: 'Slide 4')
end

def slide_6
  @slide_6 ||= Users::Slides.new(title: 'Slide 6')
end

def audio_slide
  @audio_slide ||= Users::Slides.new(
    title: 'Test audio slide',
    body: 'This is an audio slide',
    type: 'audio'
  )
end

def slide_7
  @slide_7 ||= Users::Slides.new(title: 'Slide 7')
end

def slide_8
  @slide_8 ||= Users::Slides.new(title: 'Slide 8')
end

def slide_test_slideshow
  @slide_test_slideshow ||= Users::Slideshows.new(
    title: 'Brand new slideshow for testing'
  )
end
