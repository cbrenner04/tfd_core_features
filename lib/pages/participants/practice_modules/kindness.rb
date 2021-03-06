# frozen_string_literal: true
module Participants
  module PracticeModules
    # page object for Kindness Journal module
    class Kindness
      include Capybara::DSL

      def initialize(kindness)
        @kindness ||= kindness[:kindness]
        @created_at ||= kindness[:created_at]
      end

      def open
        click_on 'New Kindness Journal'
      end

      def open_review
        click_on 'View Kindness Journal'
      end

      def has_review_visible?
        has_css?('#kindness-table')
      end

      def has_entry_alert?
        has_css?('.alert', text: 'Journal entry can\'t be blank')
      end

      def complete
        fill_in 'kindness[journal_entry]', with: @kindness
      end

      def has_journal_entry?
        has_css?('tr', text: "#{@kindness} #{long_date_with_hour(@created_at)}")
      end
    end
  end
end
