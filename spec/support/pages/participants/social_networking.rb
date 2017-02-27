# frozen_string_literal: true
require './spec/support/pages/participants/navigation'

module Participants
  # page object for Social networking features
  class SocialNetworking
    include Capybara::DSL

    def has_share_options?
      has_text? 'Share the content of this thought?'
    end

    def accept_social
      participant_navigation.confirm_with_js
      participant_navigation.next
    end

    def decline_social
      within('.form-group', text: 'Share the content') { choose 'No' }
      participant_navigation.scroll_down
      participant_navigation.next
    end

    def open_detail
      click_on 'More'
    end

    def scroll_to_bottom_of_feed
      find_feed_item('nudged participant1')
    end

    def find_feed_item(item)
      find('#feed-btn').click unless ENV['tfd'] || ENV['tfdso']
      counter = 0
      while has_no_css?('.list-group-item.ng-scope', text: item) && counter < 15
        execute_script('window.scrollTo(0,100000)')
        counter += 1
      end
    end

    def has_last_feed_item?
      has_text? 'nudged participant1'
    end

    def has_1000_characters_left?
      sleep(1)
      has_text? '1000 characters left'
    end

    def has_updated_character_count?(response)
      count = 1000 - response.length
      plural = count > 1 ? 's' : ''
      find('.status', text: "#{count} character#{plural} left")
    end

    def has_participant65_visible_on_landing_page?
      has_css?('h5', text: 'Fifth')
    end

    private

    def participant_navigation
      @participant_navigation ||= Participants::Navigation.new
    end
  end
end
