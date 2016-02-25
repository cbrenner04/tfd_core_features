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
        within('.modal-dialog') do
          has_text? @thought
          find('.close').click
        end
      end
    end
  end
end
