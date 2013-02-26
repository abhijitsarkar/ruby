require 'minitest/autorun'

require_relative '../lib/datastructures.rb'

class VertexTest < MiniTest::Unit::TestCase
  def test_initialize
    assert_raises(ArgumentError) {
      DataStructures::Components::Vertex.new
    }
    vertex2 = DataStructures::Components::Vertex.new([0, 0])
    assert_equal([0, 0], vertex2.location)
    assert_equal(Float::INFINITY, vertex2.value)
    assert_equal(Float::INFINITY, vertex2.distance)
    assert_equal(false, vertex2.visited)
    assert(vertex2.edges.empty?)
    vertex3 = DataStructures::Components::Vertex.new([0, 0], 1)
    assert_equal([0, 0], vertex3.location)
    assert_equal(1, vertex3.value)
    assert_equal(Float::INFINITY, vertex3.distance)
    assert_equal(false, vertex3.visited)
    assert(vertex3.edges.empty?)
    vertex4 = DataStructures::Components::Vertex.new([0, 0], 1, 2)
    assert_equal([0, 0], vertex4.location)
    assert_equal(1, vertex4.value)
    assert_equal(2, vertex4.distance)
    assert_equal(false, vertex4.visited)
    assert(vertex4.edges.empty?)
    vertex5 = DataStructures::Components::Vertex.new([0, 0], 1, 2, true)
    assert_equal([0, 0], vertex5.location)
    assert_equal(1, vertex5.value)
    assert_equal(2, vertex5.distance)
    assert_equal(true, vertex5.visited)
    assert(vertex5.edges.empty?)
    edge1 = DataStructures::Components::Edge.new([0, 0],  [1, 1])
    vertex6 = DataStructures::Components::Vertex.new([0, 0], 1, 2, true, edge1)
    assert_equal([0, 0], vertex6.location)
    assert_equal(1, vertex6.value)
    assert_equal(2, vertex6.distance)
    assert_equal(true, vertex6.visited)
    assert(vertex6.neighbors.include?([1, 1]))
  end

  def test_eql?
    vertex1 = DataStructures::Components::Vertex.new([0, 0])
    vertex2 = DataStructures::Components::Vertex.new([0, 0])
    vertex3 = DataStructures::Components::Vertex.new([0, 1])

    assert(vertex1.eql?(vertex1), "vertex1 should be equal to self")
    assert(vertex1.eql?(vertex2), "vertex1 should be equal to vertex2")
    refute(vertex1.eql?(vertex3), "vertex1 should NOT be equal to vertex3")
  end

  def test_hash
    vertex1 = DataStructures::Components::Vertex.new([0, 0])
    vertex2 = DataStructures::Components::Vertex.new([0, 0])
    vertex3 = DataStructures::Components::Vertex.new([0, 1])

    assert_equal(vertex1.hash, vertex1.hash, "vertex1.hash should be equal to it's own hash")
    assert_equal(vertex1.hash, vertex2.hash, "vertex1.hash should be equal to vertex2.hash")
    refute_equal(vertex1.hash, vertex3.hash, "vertex1.hash should NOT be equal to vertex3.hash")
  end

  def test_neighbor?
    edge1 = DataStructures::Components::Edge.new([0, 0], [1, 1])
    edge2 = DataStructures::Components::Edge.new([0, 0], [2, 1])
    vertex1 = DataStructures::Components::Vertex.new([0, 0], Float::INFINITY, Float::INFINITY, false, edge1, edge2)
    vertex2 = DataStructures::Components::Vertex.new([3, 1])
    vertex3 = DataStructures::Components::Vertex.new([2, 1], Float::INFINITY, Float::INFINITY, false, edge2)

    assert(vertex1.neighbor?(vertex1), "vertex1 should be it's own neighbor")
    refute(vertex1.neighbor?(vertex2), "vertex1 is NOT a neighbor to vertex2")
    assert(vertex3.neighbor?(vertex1), "vertex3 should be a neighbor to vertex1")
  end

  def test_absurd_edge
    edge1 = DataStructures::Components::Edge.new([1, 5],  [2, 5])
    assert_raises(ArgumentError) {
      DataStructures::Components::Vertex.new([0, 0], Float::INFINITY, Float::INFINITY, false, edge1)
    }
  end

  def test_distance
    vertex2 = DataStructures::Components::Vertex.new([3, 1])
    assert_equal(Float::INFINITY, vertex2.distance)
    vertex2.distance=(2)
    assert_equal(2, vertex2.distance)
  end
end