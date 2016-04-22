require './lib/pages/participants/navigation'

# module for shared Activities viz functionality
module SharedActivitiesViz
  include Capybara::DSL

  def has_current_day_visible?
    has_text? "Daily Averages for #{Date.today.strftime('%b %d %Y')}"
  end

  def go_to_previous_day
    find('h3', text: 'Daily Averages')
    participant_navigation.scroll_down
    click_on 'Previous Day'
  end

  def has_daily_summary_visible?
    has_text? 'Average Accomplishment Discrepancy'
  end

  def toggle_daily_summary
    click_on 'Daily Summaries'
    sleep(1)
  end

  def has_previous_day_visible?
    has_text? "Daily Averages for #{(Date.today - 1).strftime('%b %d %Y')}"
  end

  def open_visualize
    click_on 'Visualize'
  end

  def go_to_three_day_view
    click_on 'Last 3 Days'
  end

  def has_three_day_view_visible?
    has_text?((Date.today - 2).strftime('%A, %m/%d'))
  end

  def open_date_picker
    click_on 'Day'
  end

  def has_date_picker?
    has_css? '#datepicker'
  end

  private

  def participant_navigation
    @participant_navigation ||= Participants::Navigation.new
  end
end
