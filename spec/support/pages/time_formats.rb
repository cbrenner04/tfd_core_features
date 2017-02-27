# frozen_string_literal: true
# standard format for time and date
module TimeFormats
  def long_date(date)
    date.strftime('%b %d %Y')
  end

  def long_date_with_hour(date_time)
    date_time.strftime('%b %d %Y %I')
  end

  def short_date(date)
    date.strftime('%m/%d/%Y')
  end

  def iso_date(date)
    date.strftime('%F')
  end

  def today
    Date.today
  end

  def week_day(date)
    date.strftime('%a')
  end
end
