# filename: ./spec/features/user/core/content_author_slides_spec.rb

describe 'Content Author signs in, navigates to Arm 1,',
         :superfluous, :core, type: :feature, sauce: sauce_labs do
  describe 'navigates to Lesson Modules, selects a lesson,' do
    before do
      unless ENV['safari']
        sign_in_user(ENV['Content_Author_Email'], "#{moderator}",
                     ENV['Content_Author_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
      click_on 'Arm 1'
      click_on 'Manage Content'
      click_on 'Lesson Modules'
      find('h1', text: 'Listing Lesson Modules')
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Testing adding/updating slides/lessons'
    end

    it 'creates a slide' do
      click_on 'Add Slide'
      fill_in 'slide_title', with: 'Test slide 2'
      uncheck 'slide[is_title_visible]'
      find('.md-input').set 'Lorem ipsum dolor sit amet, consectetur ' \
                            'adipiscing elit. Vivamus vitae viverra leo, at ' \
                            'tincidunt enim. Nulla vitae enim. Suspendisse.'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Create'
      find('.alert-success', text: 'Successfully created slide for lesson')
      expect(page).to have_content 'Test slide 2'
    end

    it 'updates a slide' do
      find('small', text: 'Testing adding/updating slides/lessons')
      within('li', text: 'Slide 3') do
        find('.btn.btn-default').click
      end
      check 'slide[is_title_visible]'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Update'
      expect(page).to have_content 'Successfully updated slide for lesson'
    end

    it 'views a slide' do
      click_on 'Slide 2'
      expect(page).to have_content 'Log in once a day'
    end

    it 'destroys a slide' do
      find('small', text: 'Testing adding/updating slides/lessons')
      page.driver.execute_script('window.confirm = function() {return true}')
      within('li', text: 'Slide 5') do
        find('.btn.btn-danger').click
      end

      find('.alert-success', text: 'Slide deleted')
      expect(page).to_not have_content 'Slide 5'
    end

    it 'adds a video slide' do
      click_on 'Add Video Slide'
      fill_in 'slide_title', with: 'Test video slide 2'
      fill_in 'slide_options_vimeo_id', with: '111087687'
      uncheck 'slide[is_title_visible]'
      find('.md-input').set 'This is a video slide'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Create'
      find('.alert-success', text: 'Successfully created slide for lesson')
      expect(page).to have_content 'Test video slide 2'
    end

    it 'updates a video slide' do
      find('small', text: 'Testing adding/updating slides/lessons')
      within('li', text: 'Slide 4') do
        find('.btn.btn-default').click
      end

      uncheck 'slide[is_title_visible]'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Update'
      expect(page).to have_content 'Successfully updated slide for lesson'
    end

    it 'views a video slide' do
      click_on 'Slide 4'
      expect(page).to have_css('.responsive-video')
    end

    it 'destroys a video slide' do
      find('small', text: 'Testing adding/updating slides/lessons')
      page.driver.execute_script('window.confirm = function() {return true}')
      within('li', text: 'Slide 6') do
        find('.btn.btn-danger').click
      end

      find('.alert-success', text: 'Slide deleted')
      expect(page).to_not have_content 'Slide 6'
    end

    it 'adds an audio slide' do
      click_on 'Add Audio Slide'
      fill_in 'slide_title', with: 'Test audio slide'
      fill_in 'slide_options_audio_url', with: ENV['Audio_File']
      find('.md-input').set 'This is an audio slide'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Create'
      find('.alert-success', text: 'Successfully created slide for lesson')
      expect(page).to have_content 'Test audio slide'
    end

    it 'updates an audio slide' do
      find('small', text: 'Testing adding/updating slides/lessons')
      within('li', text: 'Slide 7') do
        find('.btn.btn-default').click
      end

      find('h1', text: 'Edit Slide')
      uncheck 'slide[is_title_visible]'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Update'
      expect(page).to have_content 'Successfully updated slide for lesson'
    end

    it 'views an audio slide' do
      click_on 'Slide 7'
      expect(page).to have_css('.responsive-audio')
    end

    it 'deletes an audio slide' do
      find('small', text: 'Testing adding/updating slides/lessons')
      page.driver.execute_script('window.confirm = function() {return true}')
      within('li', text: 'Slide 8') do
        find('.btn.btn-danger').click
      end

      find('.alert-success', text: 'Slide deleted')
      expect(page).to_not have_content 'Slide 8'
    end
  end

  describe 'navigates to Slideshows, selects a slideshow,' do
    before do
      unless ENV['safari']
        sign_in_user(ENV['Content_Author_Email'], "#{moderator}",
                     ENV['Content_Author_Password'])
      end

      visit "#{ENV['Base_URL']}/think_feel_do_dashboard/arms"
      click_on 'Arm 1'
      click_on 'Manage Content'
      click_on 'Slideshows'
      find('h1', text: 'Listing Slideshows')
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Brand new slideshow for testing'
    end

    it 'creates a slide' do
      click_on 'Add Slide'
      fill_in 'slide_title', with: 'Test slide 2'
      uncheck 'slide[is_title_visible]'
      find('.md-input').set 'Lorem ipsum dolor sit amet, consectetur ' \
                            'adipiscing elit. Vivamus vitae viverra leo, at ' \
                            'tincidunt enim. Nulla vitae enim. Suspendisse.'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Create'
      expect(page).to have_content 'Test slide 2'
    end

    it 'updates a slide' do
      find('small', text: 'Brand new slideshow for testing')
      within('li', text: 'Slide 3') do
        find('.btn.btn-default').click
      end
      check 'slide[is_title_visible]'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Update'
      expect(page).to have_css('small', text: 'Brand new slideshow for testing')
    end

    it 'views a slide' do
      click_on 'Slide 2'
      expect(page).to have_content 'Log in once a day'
    end

    it 'destroys a slide' do
      find('small', text: 'Brand new slideshow for testing')
      page.driver.execute_script('window.confirm = function() {return true}')
      within('li', text: 'Slide 5') do
        find('.btn.btn-danger').click
      end

      expect(page).to_not have_content 'Slide 5'
    end

    it 'adds a video slide' do
      click_on 'Add Video Slide'
      fill_in 'slide_title', with: 'Test video slide 2'
      fill_in 'slide_options_vimeo_id', with: '111087687'
      uncheck 'slide[is_title_visible]'
      find('.md-input').set 'This is a video slide'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Create'
      expect(page).to have_content 'Test video slide 2'
    end

    it 'updates a video slide' do
      find('small', text: 'Brand new slideshow for testing')
      within('li', text: 'Slide 4') do
        find('.btn.btn-default').click
      end

      uncheck 'slide[is_title_visible]'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Update'
      expect(page).to have_css('small', text: 'Brand new slideshow for testing')
    end

    it 'views a video slide' do
      click_on 'Slide 4'
      expect(page).to have_css('.responsive-video')
    end

    it 'destroys a video slide' do
      find('small', text: 'Brand new slideshow for testing')
      page.driver.execute_script('window.confirm = function() {return true}')
      within('li', text: 'Slide 6') do
        find('.btn.btn-danger').click
      end

      expect(page).to_not have_content 'Slide 6'
    end

    it 'adds an audio slide' do
      click_on 'Add Audio Slide'
      fill_in 'slide_title', with: 'Test audio slide'
      fill_in 'slide_options_audio_url', with: ENV['Audio_File']
      find('.md-input').set 'This is an audio slide'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Create'
      expect(page).to have_content 'Test audio slide'
    end

    it 'updates an audio slide' do
      find('small', text: 'Brand new slideshow for testing')
      within('li', text: 'Slide 7') do
        find('.btn.btn-default').click
      end

      find('h2', text: 'Edit Slide')
      uncheck 'slide[is_title_visible]'
      page.execute_script('window.scrollTo(0,5000)')
      click_on 'Update'
      expect(page).to have_css('small', text: 'Brand new slideshow for testing')
    end

    it 'views an audio slide' do
      click_on 'Slide 7'
      expect(page).to have_css('.responsive-audio')
    end

    it 'deletes an audio slide' do
      find('small', text: 'Brand new slideshow for testing')
      page.driver.execute_script('window.confirm = function() {return true}')
      within('li', text: 'Slide 8') do
        find('.btn.btn-danger').click
      end

      expect(page).to_not have_content 'Test audio slide'
    end

    it 'adds and removes table of contents' do
      click_on 'Add Table of Contents'
      within '.ui-sortable' do
        expect(page).to have_content 'Table of Contents'
      end

      click_on 'Destroy Table of Contents'
      within '.ui-sortable' do
        expect(page).to_not have_content 'Table of Contents'
      end
    end
  end
end
