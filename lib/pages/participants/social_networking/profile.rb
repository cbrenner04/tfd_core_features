require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'

class Participants
  class SocialNetworking
    # page object for the profile page
    class Profile
      include RSpec::Matchers
      include Capybara::DSL

      def initialize(profile)
        @answer ||= profile[:answer]
        @question ||= profile[:question]
        @display_name ||= profile[:display_name]
        @other_pt ||= profile[:other_pt]
        @last_seen ||= profile[:last_seen]
        @nudger ||= profile[:nudger]
      end

      def visit_profile
        visit "#{ENV['Base_URL']}/social_networking/profile_page"
        unless has_no_css?('.modal-content')
          find('.modal-content').all('img')[2].click
        end
      end

      def navigate_to_profile
        within '.navbar-collapse' do
          click_on @display_name
          click_on 'My Profile'
        end
      end

      def visible?
        find('#profile-box').has_css?('h3', text: @display_name)
      end

      def visit_another_participants_profile
        find('a', text: @other_pt).click
      end

      def incomplete?
        has_text? 'Fill out your profile so other group members can get ' \
                  'to know you!'
      end

      def check_for_character_count
        within profile_question('What are your hobbies?') do
          find('input[type = text]').click
          expect(social_networking).to have_1000_characters_left
        end
      end

      def check_for_updated_character_count
        within profile_question('What are your hobbies?') do
          response = one_less_than_1000_characters_of_lorem
          enter_profile_answer(response)
          expect(social_networking).to have_updated_character_count(response)
        end
      end

      def create
        question = ['What are your hobbies?', 'What is your favorite color?',
                    'Animal, vegetable or mineral?', 'Group 1 profile question']
        question.zip(@answer) do |q, a|
          navigation.scroll_down
          answer_profile_question(q, a)
        end

        has_no_text? 'Fill out your profile so other group members can get ' \
                     'to know you!'
      end

      def create_group_3_profile
        visit_profile
        incomplete?
        2.times { navigation.scroll_down }
        answer_profile_question('What are your hobbies?', @answer)
        has_no_text? 'Fill out your profile so other group members can get ' \
                     'to know you!'
      end

      def able_to_edit_question?
        within(".panel-#{profile_class}.ng-scope", text: @question) do
          has_css? '.fa.fa-pencil'
        end
      end

      def find_in_feed
        social_networking
          .find_feed_item("Shared a Profile: Welcome, #{@display_name}")
      end

      def has_last_seen?
        find('.text-center.ng-scope', text: @display_name)
          .find('.profile-last-seen').has_text? "Last seen: #{@last_seen}"
      end

      def nudge
        click_on 'Nudge'
        has_text? 'Nudge sent!'
      end

      def has_nudge_in_feed?
        social_networking.find_feed_item("nudged #{@other_pt}")
        has_text? "nudged #{@other_pt}"
      end

      def has_nudge?
        has_text? "#{@nudger} nudged you!"
      end

      private

      def navigation
        @navigation ||= Participants::Navigation.new
      end

      def social_networking
        @social_networking ||= Participants::SocialNetworking.new
      end

      def answer_profile_question(question, answer)
        within profile_question(question) do
          enter_profile_answer(answer)
          social_networking.confirm_with_js
          navigation.save
        end
      end

      def profile_question(question)
        find(".panel.panel-#{profile_class}.ng-scope", text: question)
      end

      def enter_profile_answer(answer)
        find('input[type = text]').set(answer)
      end

      def profile_class
        @profile_class ||=
          ENV['sunnyside'] || ENV['marigold'] ? 'success' : 'default'
      end

      def one_less_than_1000_characters_of_lorem
        @one_less_than_1000_characters_of_lorem ||=
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean i' \
          'n nunc metus. Praesent aliquam faucibus metus. Sed cursus porta d' \
          'ictum. Duis id ornare metus. Nam consectetur mauris quis nibh acc' \
          'umsan tempus. Quisque at viverra quam. Pellentesque dapibus nisi ' \
          'sit amet mauris gravida, ac blandit ante imperdiet. Maecenas puru' \
          's felis, condimentum eu venenatis in, faucibus ac erat. Fusce ves' \
          'tibulum libero vel libero aliquet aliquam. Pellentesque rhoncus e' \
          't tortor nec consectetur. Aenean auctor massa molestie est vehicu' \
          'la, ac faucibus arcu tincidunt. Vestibulum molestie metus orci, v' \
          'el scelerisque diam consectetur eu. Donec risus neque, consequat ' \
          'iaculis metus vehicula, mattis porta diam. Cum sociis natoque pen' \
          'atibus et magnis dis parturient montes, nascetur ridiculus mus. I' \
          'n efficitur mollis risus non fringilla. Vivamus imperdiet mi in l' \
          'ibero malesuada ultricies. Vestibulum augue mi, pulvinar sed cond' \
          'imentum eget, cursus et nulla. Suspendisse cursus, quam nec iacul' \
          'is faucibus, purus nulla'
      end
    end
  end
end
