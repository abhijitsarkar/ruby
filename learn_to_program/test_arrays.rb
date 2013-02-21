require "minitest/autorun"

require_relative "arrays"

class TestArrays < MiniTest::Unit::TestCase
  def setup
    @arrays = Arrays.new
  end

  def teardown
    @arrays = nil
  end

  def test_merge_sort1
    assert_equal([], @arrays.merge_sort([]))
    assert_equal([1], @arrays.merge_sort([1]))
    assert_equal([1, 2, 4], @arrays.merge_sort([2, 4, 1]))
    assert_equal([1, 2, 4, 6, 6], @arrays.merge_sort([2, 4, 6, 6, 1]))
  end

  #  def test_merge_sort2
  #    assert_equal([], @arrays.merge_sort2([], 0, 0))
  #    assert_equal([1], @arrays.merge_sort2([1], 0, 1))
  #    assert_equal([1, 2, 4], @arrays.merge_sort2([2, 4, 1], 0, 3))
  #    assert_equal(["1", "2", "3", "4"], @arrays.merge_sort2(["1", "2", "4", "3"], 0, 4))
  #  end
end