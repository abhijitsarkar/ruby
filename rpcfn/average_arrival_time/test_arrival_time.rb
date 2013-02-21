require 'minitest/autorun'

require_relative 'arrival_time'

class TestArrivalTime < MiniTest::Unit::TestCase
  def test_average_arrival_time_1
    arrival_time = ArrivalTime.average_arrival_time(*%w(6:41am 6:51am 7:01am))
    assert_equal("06:51am", arrival_time, "Wrong average arrival time")
  end

  def test_average_arrival_time_2
    arrival_time = ArrivalTime.average_arrival_time(*%w(11:51pm 11:56pm 12:01am 12:06am 12:11am))
    assert_equal("12:01am", arrival_time, "Wrong average arrival time")
  end
end