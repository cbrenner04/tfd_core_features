require './lib/pages/participants/social_networking'
require './lib/pages/participants/navigation'

module Participants
  module SocialNetworkingModules
    # page object for the Achieve tool
    class Achieve
      include Capybara::DSL

      def initialize(achieve)
        @goal ||= achieve[:goal]
        @due_date ||= achieve[:due_date]
        @status ||= achieve[:status]
      end

      def landing_page
        "#{ENV['Base_URL']}/navigator/contexts/ACHIEVE"
      end

      def open_help
        tries ||= 2
        text = 'Need some help writing a goal?'
        button = ENV['sunnyside'] ? text.upcase : text
        find('.btn', text: button).click
      rescue Capybara::ElementNotFound
        retry unless (tries -= 1).zero?
      end

      def has_help_text?
        has_text? 'The ACHIEVE tool helps you set goals. When you are writin' \
                  'g your goal, be sure to consider the following: What is t' \
                  'he specific thing you will do? Where will you do it? When' \
                  ' will you do it? How much and how often? Remember that SM' \
                  'ART goals tend to be the most helpful: Specific (the What' \
                  '), Measurable (helps you track your progress), Attainable' \
                  ' (something you believe you can do), Relevant (i.e., mean' \
                  'ingful to you, not something other people want you to do)' \
                  ', and Time-framed. For example, let’s say you want to wor' \
                  'k toward being less stressed. You might start with a goal' \
                  ' to do more calming activities each week. From there, you' \
                  ' can make your goal even more helpful by adding in the de' \
                  'tails: what the specific calming activities will be, wher' \
                  'e you’ll do them, when, how much and how often. You would' \
                  ' then write “I will listen to (WHAT) at least 3 calming s' \
                  'ongs (HOW MUCH) every evening (HOW OFTEN) after dinner (W' \
                  'HEN) on the couch (WHERE).'
      end

      def open_new
        click_on '+ add a goal'
      end

      def add
        open_new
        fill_in 'new-goal-description', with: @goal
        choose 'end of study'
        pt_navigation.save
      end

      def visible?
        has_text? @goal
      end

      def find_in_feed
        social_networking.find_feed_item("#{@status} a Goal: #{@goal}")
      end

      def visible_in_feed?
        has_text? "#{@status} a Goal: #{@goal}"
      end

      def has_details?
        within('.list-group-item', text: "Created a Goal: #{@goal}") do
          pt_navigation.scroll_to_bottom
          social_networking.open_detail
          has_text? "due #{long_date(@due_date)}"
        end
      end

      def complete
        within('.list-group-item', text: @goal) do
          pt_navigation.confirm_with_js if ENV['chrome'] || ENV['safari']
          click_on 'Complete'
        end

        unless ENV['chrome'] || ENV['safari']
          accept_alert 'Are you sure you would like to mark this goal as ' \
                       'complete? This action cannot be undone.'
        end

        find('.list-group-item-success', text: 'p1 alpha')
        click_on 'Completed'
      end

      def delete
        if ENV['chrome'] || ENV['safari']
          pt_navigation.confirm_with_js
          find('.list-group-item', text: @goal).find('.delete').click
        else
          find('.list-group-item', text: @goal).find('.delete').click
          accept_alert 'Are you sure you would like to delete this goal? ' \
                       'This action cannot be undone.'
        end
      end

      def view_deleted
        click_on 'Deleted'
      end

      def has_no_specific_date_option?
        has_text? 'no specific date'
      end

      def has_one_week_option?
        has_text? 'end of one week'
      end

      def has_two_week_option?
        has_text? 'end of 2 weeks'
      end

      def has_four_week_option?
        has_text? 'end of 4 weeks'
      end

      def has_end_of_study_option?
        has_text? 'end of study'
      end

      def has_due_date?
        within first('.list-group-item.ng-scope', text: "a Goal: #{@goal}") do
          pt_navigation.scroll_to_bottom
          social_networking.open_detail
          has_text? "due #{long_date(@due_date)}"
        end
      end

      private

      def social_networking
        @social_networking ||= Participants::SocialNetworking.new
      end

      def pt_navigation
        @pt_navigation ||= Participants::Navigation.new
      end
    end
  end
end
