require "minitest/autorun"

require_relative "numbers"

class TestNumbers < MiniTest::Unit::TestCase
  def setup
    @numbers = Numbers.new
  end

  def teardown
    @numbers = nil
  end

  def test_leap_year
    assert(@numbers.leap_year?(2000), "leap year")
    assert(!@numbers.leap_year?(2001), "not leap year")
  end

  def test_leap_years_in_between
    assert_equal(3, @numbers.leap_years_in_between(2000, 2009))
    assert_equal(2, @numbers.leap_years_in_between(2001, 2010))
  end

  def test_minutes_in_between
    minutes_in_the_year_2000 = @numbers.hours_in_an_year(2000) * 60
    minutes_in_the_year_2001 = @numbers.hours_in_an_year(2001) * 60
    assert_equal(minutes_in_the_year_2000, @numbers.minutes_in_between(2000, 2000))
    assert_equal(minutes_in_the_year_2001, @numbers.minutes_in_between(2001, 2001))
    assert_equal(minutes_in_the_year_2000 + minutes_in_the_year_2001, @numbers.minutes_in_between(2000, 2001))
  end

  def test_age_in_seconds
    seconds_in_the_year_2013 = @numbers.hours_in_an_year(2013) * 3600
    assert_equal(seconds_in_the_year_2013, @numbers.age_in_seconds(2013))
  end
end