require './lib/pages/participants/navigation'

class Participants
  # page object for Social networking features
  class SocialNetworking
    include Capybara::DSL

    def confirm_with_js
      execute_script('window.confirm = function() {return true}')
    end

    def has_share_options?
      has_text? 'Share the content of this thought?'
    end

    def accept_social
      confirm_with_js
      navigation.next
    end

    def decline_social
      within('.form-group', text: 'Share the content') { choose 'No' }
      navigation.next
    end

    def open_detail
      click_on 'More'
    end

    def scroll_to_bottom_of_feed
      find_feed_item('nudged participant1')
    end

    def find_feed_item(x)
      find('#feed-btn').click unless ENV['tfd'] || ENV['tfdso']
      counter = 0
      while has_no_css?('.list-group-item.ng-scope', text: x) && counter < 15
        execute_script('window.scrollTo(0,100000)')
        counter += 1
      end
    end

    def has_last_feed_item?
      has_text? 'nudged participant1'
    end

    private

    def navigation
      @navigation ||= Participants::Navigation.new
    end
  end
end
