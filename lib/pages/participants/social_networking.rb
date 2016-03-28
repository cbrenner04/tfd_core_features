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

    def has_1000_characters_left?
      has_text? '1000 characters left'
    end

    def has_1_character_left?
      has_text? '1 character left'
    end

    def one_less_than_1000_characters_of_lorem
      @one_less_than_1000_characters_of_lorem ||=
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in ' \
        'nunc metus. Praesent aliquam faucibus metus. Sed cursus porta dictu' \
        'm. Duis id ornare metus. Nam consectetur mauris quis nibh accumsan ' \
        'tempus. Quisque at viverra quam. Pellentesque dapibus nisi sit amet' \
        ' mauris gravida, ac blandit ante imperdiet. Maecenas purus felis, c' \
        'ondimentum eu venenatis in, faucibus ac erat. Fusce vestibulum libe' \
        'ro vel libero aliquet aliquam. Pellentesque rhoncus et tortor nec c' \
        'onsectetur. Aenean auctor massa molestie est vehicula, ac faucibus ' \
        'arcu tincidunt. Vestibulum molestie metus orci, vel scelerisque dia' \
        'm consectetur eu. Donec risus neque, consequat iaculis metus vehicu' \
        'la, mattis porta diam. Cum sociis natoque penatibus et magnis dis p' \
        'arturient montes, nascetur ridiculus mus. In efficitur mollis risus' \
        ' non fringilla. Vivamus imperdiet mi in libero malesuada ultricies.' \
        ' Vestibulum augue mi, pulvinar sed condimentum eget, cursus et null' \
        'a. Suspendisse cursus, quam nec iaculis faucibus, purus nulla'
    end

    private

    def navigation
      @navigation ||= Participants::Navigation.new
    end
  end
end
