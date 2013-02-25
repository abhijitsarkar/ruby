require 'minitest/autorun'

require_relative '../lib/datastructures.rb'

class EdgeTest < MiniTest::Unit::TestCase
  def test_compare
    edge1 = DataStructures::Components::Edge.new([1, 1],  [2, 1])
    edge2 = DataStructures::Components::Edge.new([1, 1],  [2, 1])
    edge3 = DataStructures::Components::Edge.new([1, 1],  [2, 1], 2)
    edge4 = DataStructures::Components::Edge.new([3, 1],  [5, 1], 2)

    assert_equal(0, edge1 <=> edge1, "edge1 should be equal to self")
    assert_equal(0, edge1 <=> edge2, "edge1 should be equal to edge2")
    assert((edge2 <=> edge3) < 0, "edge2 should be less than edge3")
    assert((edge3 <=> edge1) > 0, "edge3 should be greater than edge1")
    assert_nil(edge1 <=> edge4, "edge1 is not comparable to edge4")
  end

  def test_connects?
    edge1 = DataStructures::Components::Edge.new([1, 1],  [2, 1])

    assert(edge1.connects?([1, 1]), "edge1 connects to [1, 1]")
    refute(edge1.connects?([3, 1]), "edge1 does NOT connect to [1, 1]")
  end

  def test_weight
    edge1 = DataStructures::Components::Edge.new([1, 1],  [2, 1])
    edge2 = DataStructures::Components::Edge.new([1, 1],  [3, 1], 3)

    assert_equal(1, edge1.weight, "Wrong weight")
    assert_equal(3, edge2.weight, "Wrong weight")
  end

  def test_hash
    edge1 = DataStructures::Components::Edge.new([1, 1],  [2, 1])
    edge2 = DataStructures::Components::Edge.new([1, 1],  [2, 1])
    edge3 = DataStructures::Components::Edge.new([1, 1],  [2, 1], 2)

    assert_equal(edge1.hash, edge1.hash, "edge1.hash should be equal to it's own hash")
    assert_equal(edge1.hash, edge2.hash, "edge1.hash should be equal to edge2.hash")
    refute_equal(edge1.hash, edge3.hash, "edge1.hash should NOT be equal to edge3.hash")
  end
end