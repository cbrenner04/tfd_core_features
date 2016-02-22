class Participants
  class Think
    # page object for Thoughts module
    class Thoughts
      include Capybara::DSL

      def initialize(thoughts_arry)
        @thought ||= thoughts_arry[:thought]
        @pattern ||= thoughts_arry[:pattern]
      end

      def open
        click_on 'Thoughts'
      end

      def has_thought_visible?
        has_css?('tr', text: @thought)
      end

      def sort_by_patterns
        find('.sorting', text: 'Pattern').click
      end

      def first_row
        @first_row ||= all('tr:nth-child(1)')[1]
      end

      def has_pattern?
        has_text? @pattern
      end
    end
  end
end
