# frozen_string_literal: true
# module for shared Mood and Emotions Viz functionality
module SharedMoodEmotionsViz
  include Capybara::DSL

  def has_week_view_visible?
    has_css?('#date-range',
             text: "#{long_date(today - 6)} - #{long_date(today)}")
  end

  def switch_to_28_day_view
    find('.btn.btn-default', text: '28').click
  end

  def has_28_day_view_visible?
    has_text? "#{long_date(today - 27)} - #{long_date(today)}"
  end

  def switch_to_7_day_view
    find('.btn.btn-default', text: '7').click
  end

  def switch_to_previous_period
    click_on 'Previous Period'
  end

  def has_previous_period_visible?
    has_text? "#{long_date(today - 13)} - #{long_date(today - 7)}"
  end
end
