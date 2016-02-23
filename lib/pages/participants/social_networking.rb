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
      find('#feed-btn').click unless ENV['tfd'] || ENV['tfdso']
      counter = 0
      while has_no_css?('.list-group-item.ng-scope',
                        text: item) && counter < 15
        navigation.scroll_to_bottom
        counter += 1
      end
    end

    def visit_participant_5_profile
      find('a', text: 'participant5').click
    end

    def like(item_text)
      within first('.list-group-item.ng-scope', text: item_text) do
        click_on 'Like' unless has_text?('Like (1)')
        has_text? 'Like (1)'
      end
    end

    def comment(feed_item, text)
      find_feed_item(feed_item)
      navigation.scroll_to_bottom
      within first('.list-group-item.ng-scope', text: feed_item) do
        click_on 'Comment'
        has_text? 'What do you think?'
        fill_in 'comment-text', with: text
        navigation.scroll_down
        click_on 'Save'
        has_text? 'Comment (1)'
      end
    end

    private

    def navigation
      @navigation ||= Participants::Navigation.new
    end
  end
end
