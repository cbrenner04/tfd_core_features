# module for shared Mood and Emotions Viz functionality
module SharedMoodEmotionsViz
  include Capybara::DSL

  def has_week_view_visible?
    has_css?('#date-range',
             text: "#{(Date.today - 6).strftime('%b %d %Y')} - " \
                   "#{Date.today.strftime('%b %d %Y')}")
  end

  def switch_to_28_day_view
    find('.btn.btn-default', text: '28').click
  end

  def has_28_day_view_visible?
    has_text? "#{(Date.today - 27).strftime('%b %d %Y')} - " \
              "#{Date.today.strftime('%b %d %Y')}"
  end

  def switch_to_7_day_view
    find('.btn.btn-default', text: '7').click
  end

  def switch_to_previous_period
    click_on 'Previous Period'
  end

  def has_previous_period_visible?
    has_text? "#{(Date.today - 13).strftime('%b %d %Y')} - " \
              "#{(Date.today - 7).strftime('%b %d %Y')}"
  end
end
