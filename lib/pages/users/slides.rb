require './lib/pages/users/navigation'

class Users
  # page object for Slides
  class Slides
    include Capybara::DSL

    def initialize(slides)
      @title ||= slides[:title]
      @body ||= slides[:body]
      @type ||= slides[:type]
      @video_id ||= slides[:video_id]
    end

    def create
      link = if @type == 'video'
               'Add Video Slide'
             elsif @type == 'audio'
               'Add Audio Slide'
             else
               'Add Slide'
             end
      click_on link
      fill_in 'slide_title', with: @title
      fill_in 'slide_options_vimeo_id', with: @video_id if @type == 'video'
      fill_in 'slide_options_audio_url',
              with: ENV['Audio_File'] if @type == 'audio'
      uncheck 'slide[is_title_visible]'
      find('.md-input').set @body
      navigation.scroll_to_bottom
      click_on 'Create'
    end

    def created_successfully?
      has_text?(@title)
    end

    def update
      find('li', text: @title).find('.btn-default').click
      check 'slide[is_title_visible]'
      navigation.scroll_to_bottom
      click_on 'Update'
    end

    def updated_successfully?
      # this fails in slideshows as there is no alert
      has_css?('.alert', text: 'Successfully updated slide')
    end

    def view
      click_on @title
    end

    def has_body_text?
      has_text? @body
    end

    def destroy
      navigation.confirm_with_js
      find('li', text: @title).find('.btn-danger').click
    end

    def destroyed_successfully?
      has_no_text?(@title)
    end

    def video_slide?
      has_css?('.responsive-video')
    end

    def audio_slide?
      has_css?('.responsive-audio')
    end

    private

    def navigation
      @navigation ||= Users::Navigation.new
    end
  end
end
