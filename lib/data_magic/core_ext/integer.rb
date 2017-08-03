class Integer
  def days_from_today(format = '%D')
    the_day = Date.today + self
    the_day.strftime(format)
  end

  def days_ago(format = '%D')
    the_day = Date.today - self
    the_day.strftime(format)
  end
end
