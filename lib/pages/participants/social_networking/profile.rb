require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'

class Participants
  class SocialNetworking
    # page object for the profile page
    class Profile
      include Capybara::DSL

      def initialize(profile_arry)
        @answer ||= profile_arry[:answer]
        @question ||= profile_arry[:question]
        @display_name ||= profile_arry[:display_name]
        @other_pt ||= profile_arry[:other_pt]
        @last_seen ||= profile_arry[:last_seen]
        @nudger ||= profile_arry[:nudger]
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

      def create
        visit_profile
        has_text? 'Fill out your profile so other group members can get ' \
                  'to know you!'

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
        has_text? 'Fill out your profile so other group members can get ' \
                  'to know you!'
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
        within(".panel.panel-#{profile_class}.ng-scope", text: question) do
          find('input[type = text]').set(answer)
          social_networking.confirm_with_js
          navigation.save
        end
      end

      def profile_class
        if ENV['tfd'] || ENV['tfdso']
          'default'
        elsif ENV['sunnyside'] || ENV['marigold']
          'success'
        end
      end
    end
  end
end
