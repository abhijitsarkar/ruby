class Numbers
  # define constants
  DAYS_IN_A_YEAR = 365
  DAYS_IN_A_LEAP_YEAR = 366
  HOURS_IN_A_DAY = 24
  MINUTES_IN_A_DAY = 24 * 60
  SECONDS_IN_A_DAY = MINUTES_IN_A_DAY * 60
  def leap_year?(year)
    return (year % 4) == 0
  end

  def leap_years_in_between(start_year, end_year)
    return (leap_year?(start_year) ? (((end_year - start_year) / 4) + 1) : (end_year - start_year) / 4)
  end

  def hours_in_an_year(year)
    return (leap_year?(year) ? DAYS_IN_A_LEAP_YEAR : DAYS_IN_A_YEAR) * HOURS_IN_A_DAY
  end

  def minutes_in_between(start_year, end_year)
    leap_years_in_between = leap_years_in_between(start_year, end_year)
    return ((((end_year - start_year) + 1 - leap_years_in_between) * DAYS_IN_A_YEAR) +
    (leap_years_in_between * DAYS_IN_A_LEAP_YEAR)) * MINUTES_IN_A_DAY
  end

  def minutes_in_a_decade(start_year)
    return minutes_in_between(start_year, start_year + 9)
  end

  # for the purpose of this exercise, this method assumes that you are born on the
  # first day of the year and today is the last day of the current year.
  # sorry, ladies
  def age_in_seconds(birth_year)
    return minutes_in_between(birth_year, Time.new.year) * 60
  end

end