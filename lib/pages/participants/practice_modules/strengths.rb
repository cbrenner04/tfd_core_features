module Participants
  module PracticeModules
    # page object for the Strengths journal module
    class Strengths
      include Capybara::DSL

      def initialize(strengths)
        @description ||= strengths[:description]
        @challenges ||= strengths[:challenges]
        @created_at ||= strengths[:created_at]
      end

      def open
        click_on 'New Strengths Journal'
      end

      def open_review
        click_on 'View Strengths Journal'
      end

      def enter_description
        fill_in 'strength[description]', with: @description
      end

      def enter_challenges
        fill_in 'strength[upcoming_challenge]', with: @challenges
      end

      def has_description_alert?
        has_css?('.alert', text: 'Description can\'t be blank')
      end

      def has_challenges_alert?
        has_css?('.alert', text: 'Upcoming challenge can\'t be blank')
      end

      def has_journal_entry?
        has_css?('tr', text: "#{@description} #{@challenges} " \
                             "#{@created_at.strftime('%b %d %Y %I')}")
      end
    end
  end
end
