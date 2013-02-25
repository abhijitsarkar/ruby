require 'minitest/autorun'

require_relative '../lib/datastructures.rb'

class PriorityQueueTest < MiniTest::Unit::TestCase
  def test_initialize
    vertex1 = DataStructures::Components::Vertex.new([0, 0])
    vertex1.distance=(0)
    vertex2 = DataStructures::Components::Vertex.new([0, 1])
    vertex2.distance=(1)
    vertex3 = DataStructures::Components::Vertex.new([1, 5])
    vertex3.distance=(4)

    q = DataStructures::PriorityQueue.new(vertex2, vertex3, vertex1)

    assert_equal(vertex1, q.entries[0], "Wrong first item")
    assert_equal(vertex2, q.entries[1], "Wrong second item")
    assert_equal(vertex3, q.entries[2], "Wrong third item")
  end

  def test_add
    vertex1 = DataStructures::Components::Vertex.new([0, 0])
    vertex1.distance=(0)
    vertex2 = DataStructures::Components::Vertex.new([0, 1])
    vertex2.distance=(1)
    vertex3 = DataStructures::Components::Vertex.new([1, 5])
    vertex3.distance=(4)

    q = DataStructures::PriorityQueue.new()
    q.add(vertex2)
    q.add(vertex3)
    q.add(vertex1)

    assert_equal(vertex1, q.entries[0], "Wrong first item")
    assert_equal(vertex2, q.entries[1], "Wrong second item")
    assert_equal(vertex3, q.entries[2], "Wrong third item")
  end

  def test_remove
    vertex1 = DataStructures::Components::Vertex.new([0, 0])
    vertex1.distance=(0)
    vertex2 = DataStructures::Components::Vertex.new([0, 1])
    vertex2.distance=(1)
    vertex3 = DataStructures::Components::Vertex.new([1, 5])
    vertex3.distance=(4)

    q = DataStructures::PriorityQueue.new(vertex2, vertex3, vertex1)

    assert_equal(vertex1, q.remove(), "Wrong first item")
    assert_equal(vertex2, q.remove(), "Wrong second item")
    assert_equal(vertex3, q.remove(), "Wrong third item")
  end

  def test_update
    vertex1 = DataStructures::Components::Vertex.new([0, 0])
    vertex1.distance=(0)
    vertex2 = DataStructures::Components::Vertex.new([0, 1])
    vertex2.distance=(2)
    vertex3 = DataStructures::Components::Vertex.new([1, 5])
    vertex3.distance=(4)

    q = DataStructures::PriorityQueue.new(vertex2, vertex3, vertex1)

    q.update(vertex3, 1);

    assert_equal(vertex1, q.remove(), "Wrong first item")
    assert_equal(vertex3, q.remove(), "Wrong second item")
    assert_equal(vertex2, q.remove(), "Wrong third item")
  end

end