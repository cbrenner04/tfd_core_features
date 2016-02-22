require './lib/pages/participants/navigation'

class Participants
  # page object for Social networking features
  class SocialNetworking
    include Capybara::DSL

    def confirm_with_js
      execute_script('window.confirm = function() {return true}')
    end

    def accept_social
      confirm_with_js
      navigation.next
    end

    def open_detail
      click_on 'More'
    end

    def find_feed_item(item)
      unless ENV['tfd'] || ENV['tfdso']
        find('#feed-btn').click
      end
      counter = 0
      while has_no_css?('.list-group-item.ng-scope',
                        text: item) && counter < 15
        execute_script('window.scrollTo(0,100000)')
        counter += 1
      end
    end

    def like(item_text)
      within first('.list-group-item.ng-scope', text: item_text) do
        unless has_text?('Like (1)')
          click_on 'Like'
          expect(page).to have_content 'Like (1)'
        end
      end
    end

    def comment(feed_item, text)
      find_feed_item(feed_item)
      execute_script('window.scrollTo(0,10000)')
      within first('.list-group-item.ng-scope', text: feed_item) do
        click_on 'Comment'
        expect(page).to have_content 'What do you think?'
        fill_in 'comment-text', with: text
        execute_script('window.scrollBy(0,500)')
        click_on 'Save'
        expect(page).to have_content 'Comment (1)'
      end
    end

    def visit_profile
      visit "#{ENV['Base_URL']}/social_networking/profile_page"
      unless has_no_css?('.modal-content')
        within('.modal-content') do
          all('img')[2].click
        end
      end
    end

    private

    def navigation
      @navigation ||= Participants::Navigation.new
    end
  end
end
