class Participants
  # page object for Incentives features
  class Incentives
    include Capybara::DSL

    def initialize(incentive)
      @incentive ||= incentive[:incentive]
      @completed ||= incentive[:completed]
      @total ||= incentive[:total]
      @image ||= incentive[:image]
      @plot ||= incentive[:plot]
      @pt_list_item ||= incentive[:pt_list_item]
      @date ||= incentive[:date]
      @flower_count ||= incentive[:flower_count]
      @participant ||= incentive[:participant]
    end

    def open_communal_plot
      find('#communal-plot-btn').click
    end

    def visible?
      has_css?('.panel-title',
               text: "#{@incentive} #{@completed}/#{@total} complete")
    end

    def has_image_in_plot?
      find("#garden-#{@plot}").has_css? "img[src = \"/assets/#{@image}.png\"]"
    end

    def has_incomplete_image?
      incentive_title.has_css?('.flower-translucent') &&
        incentive_title.has_css?("img[src = \"/assets/#{@image}.png\"]")
    end

    def open_incentives_list
      incentive_title.click
    end

    def has_incentives_listed?
      has_css?('.list-group-item.task-status', count: @total)
    end

    def incomplete?
      within all('.list-group-item.task-status')[@pt_list_item] do
        has_no_css?('.fa.fa-check-circle') && has_text?('Completed at: ---')
      end
    end

    def complete?
      within all('.list-group-item')[@pt_list_item] do
        has_css?('.fa.fa-check-circle') && has_text?("Completed at: #{@date}")
      end
    end

    def has_num_completed?
      has_css?('.panel-info',
               text: "#{@incentive} # of times complete: #{@completed}")
    end

    def has_correct_num_of_flowers_in_plot?
      find("#garden-#{@plot}")
        .has_css?('.ui-draggable-handle', count: @flower_count)
    end

    def has_image_in_home_plot?
      find('.text-center', text: @participant)
        .find('.small-garden').has_css? "img[src = \"/assets/#{@image}.png\"]"
    end

    def visit_another_pt_incentives
      find('.text-center', text: @participant)
        .find('a', text: @participant).click
    end

    def close_incentive_alerts
      first('.close').click while has_css?('.alert', text: 'Congratulations')
    end

    private

    def incentive_title
      find('.panel-title',
           text: "#{@incentive} #{@completed}/#{@total} complete")
    end
  end
end
