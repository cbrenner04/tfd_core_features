# filename: ./spec/features/user/core/content_author_slides_spec.rb

require './spec/support/users/slides_helper'

feature 'Content Author, Slides,',
        :superfluous, :core, type: :feature, sauce: sauce_labs do
  feature 'Lesson Modules' do
    background(:all) { content_author.sign_in } if ENV['safari']

    background do
      content_author.sign_in unless ENV['safari']
      visit user_navigation.arms_page
      slide_test_lesson.navigate_to_lessons
      user_navigation.scroll_to_bottom
      slide_test_lesson.open
    end

    scenario 'Content Author creates a slide' do
      test_slide_2.create

      expect(test_slide_2).to be_created_successfully
    end

    scenario 'Content Author updates a slide' do
      slide_3.update

      expect(slide_3).to be_updated_successfully
    end

    scenario 'Content Author views a slide' do
      slide_2.view

      expect(slide_2).to have_body_text
    end

    scenario 'Content Author destroys a slide' do
      slide_5.destroy

      expect(slide_5).to be_destroyed_successfully
    end

    scenario 'Content Author adds a video slide' do
      video_slide.create

      expect(video_slide).to be_created_successfully
    end

    scenario 'Content Author updates a video slide' do
      slide_4.update # could be an issue with check/uncheck is_title_visible

      expect(slide_4).to be_updated_successfully
    end

    scenario 'Content Author views a video slide' do
      slide_4.view

      expect(slide_4).to be_a_video_slide
    end

    scenario 'Content Author destroys a video slide' do
      slide_6.destroy

      expect(slide_6).to be_destroyed_successfully
    end

    scenario 'Content Author adds an audio slide' do
      audio_slide.create

      expect(audio_slide).to be_created_successfully
    end

    scenario 'Content Author updates an audio slide' do
      slide_7.update # could be an issue with check/uncheck is_title_visible

      expect(slide_7).to be_updated_successfully
    end

    scenario 'Content Author views an audio slide' do
      slide_7.view

      expect(slide_7).to be_an_audio_slide
    end

    scenario 'Content Author deletes an audio slide' do
      slide_8.destroy

      expect(slide_8).to be_destroyed_successfully
    end
  end

  feature 'Slideshows' do
    background(:all) { content_author.sign_in } if ENV['safari']

    background do
      content_author.sign_in unless ENV['safari']
      visit user_navigation.arms_page
      slide_test_slideshow.navigate_to_slideshows
      user_navigation.scroll_to_bottom
      slide_test_slideshow.open
    end

    scenario 'Content Author creates a slide' do
      test_slide_2.create

      expect(test_slide_2).to be_created_successfully
    end

    scenario 'Content Author updates a slide' do
      slide_3.update

      expect(slide_test_slideshow).to be_visible
    end

    scenario 'Content Author views a slide' do
      slide_2.view

      expect(slide_2).to have_body_text
    end

    scenario 'Content Author destroys a slide' do
      slide_5.destroy

      expect(slide_5).to be_destroyed_successfully
    end

    scenario 'Content Author adds a video slide' do
      video_slide.create

      expect(video_slide).to be_created_successfully
    end

    scenario 'Content Author updates a video slide' do
      slide_4.update

      expect(slide_test_slideshow).to be_visible
    end

    scenario 'Content Author views a video slide' do
      slide_4.view

      expect(slide_4).to be_a_video_slide
    end

    scenario 'Content Author destroys a video slide' do
      slide_6.destroy

      expect(slide_6).to be_destroyed_successfully
    end

    scenario 'Content Author adds an audio slide' do
      audio_slide.create

      expect(audio_slide).to be_created_successfully
    end

    scenario 'Content Author updates an audio slide' do
      slide_7.update

      expect(slide_test_slideshow).to be_visible
    end

    scenario 'Content Author views an audio slide' do
      slide_7.view

      expect(slide_7).to be_an_audio_slide
    end

    scenario 'Content Author deletes an audio slide' do
      audio_slide.destroy # this is a dependency, need to update

      expect(audio_slide).to be_destroyed_successfully
    end

    scenario 'Content Author adds and removes table of contents' do
      slide_test_slideshow.add_table_of_contents

      expect(slide_test_slideshow).to have_table_of_contents

      slide_test_slideshow.destroy_table_of_contents

      expect(slide_test_slideshow).to_not have_table_of_contents
    end
  end
end
