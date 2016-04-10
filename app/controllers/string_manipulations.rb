module StringManipulations

  def trimString(string)
    return string.strip!
  end

  def translate_period_of_time_into_seconds(period_of_time)
    if period_of_time == 'YEAR'
      number_of_seconds = 31556926
    elsif period_of_time == 'MONTH'
      number_of_seconds = 2629744
    elsif period_of_time == 'WEEK'
      number_of_seconds = 604800
    elsif period_of_time == 'DAY'
      number_of_seconds = 86400
    end
    return number_of_seconds
  end

end