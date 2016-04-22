class Participants
  class Think
    # page object for Thought Visualization
    class ThoughtVisualization
      include Capybara::DSL

      def initialize(thought_viz)
        @pattern ||= thought_viz[:pattern]
        @detail_pattern ||= thought_viz[:detail_pattern]
        @thought ||= thought_viz[:thought]
      end

      def open_viz
        first('.viz-clickable', text: @pattern).click
      end

      def visible?
        has_css?('h1', text: 'Thought Distortions')
      end

      def open_detail
        first('.viz-clickable', text: @detail_pattern).click
      end

      def has_detail?
        find('.modal-dialog').has_text? @thought
      end

      def close_modal
        find('.modal-dialog').find('.close').click
      end
    end
  end
end
