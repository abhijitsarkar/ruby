require 'minitest/autorun'

require_relative 'mock_graph'
require_relative '../lib/datastructures.rb'

class GraphTest < MiniTest::Unit::TestCase
  @@graph = MockGraph.new
  def test_initialize()
    @@graph.vertices.each_with_index { |vertex, index|
      case index
      when 0
        assert(vertex.neighbor?(DataStructures::Components::Vertex.new([5, 0])))
        assert(vertex.neighbor?(DataStructures::Components::Vertex.new([0, 5])))
        refute(vertex.neighbor?(DataStructures::Components::Vertex.new([5, 7])))
      when 1
        assert(vertex.neighbor?(DataStructures::Components::Vertex.new([0, 0])))
        assert(vertex.neighbor?(DataStructures::Components::Vertex.new([7, 5])))
        refute(vertex.neighbor?(DataStructures::Components::Vertex.new([5, 7])))
      when 2
        assert(vertex.neighbor?(DataStructures::Components::Vertex.new([0, 0])))
        assert(vertex.neighbor?(DataStructures::Components::Vertex.new([7, 0])))
        refute(vertex.neighbor?(DataStructures::Components::Vertex.new([5, 7])))
      when 3
        assert(vertex.neighbor?(DataStructures::Components::Vertex.new([5, 0])))
        assert(vertex.neighbor?(DataStructures::Components::Vertex.new([7, 5])))
        refute(vertex.neighbor?(DataStructures::Components::Vertex.new([5, 7])))
      when 4
        assert(vertex.neighbor?(DataStructures::Components::Vertex.new([7, 0])))
        assert(vertex.neighbor?(DataStructures::Components::Vertex.new([0, 5])))
        refute(vertex.neighbor?(DataStructures::Components::Vertex.new([5, 7])))
      when 5
        assert(vertex.edges.empty?())
      else
        refute(true)
      end
    }
  end

  def test_shortest_path_0_0_to_7_5()
    shortest_path = @@graph.shortest_path([0, 0], [7, 5])
    assert_equal([[0, 0], [0, 5], [7, 5]], shortest_path)
  end

  def test_shortest_path_0_0_to_5_7()
    shortest_path = @@graph.shortest_path([0, 0], [5, 7])
    assert_equal([], shortest_path)
  end

  def test_not_reachable_0_0_to_5_7()
    refute(@@graph.reachable?([0, 0], [5, 7]))
  end

  def test_reachable_0_0_to_7_5()
    assert(@@graph.reachable?([0, 0], [7, 5]))
  end
end