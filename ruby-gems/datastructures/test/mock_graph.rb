require_relative '../lib/datastructures.rb'

class MockGraph
  include DataStructures::Graph
  def initialize()
    super()
    @vertices = []

    # [0, 0]-----[0, 5]
    #       |   |
    #       |   |
    #       |   |
    # [5, 0]|   |  [5, 7]
    #       |   |
    # [7, 0]-----[7, 5]

    edge1 = DataStructures::Graph::Edge.new([0, 0],  [5, 0])
    edge2 = DataStructures::Graph::Edge.new([0, 0],  [0, 5])
    edge3 = DataStructures::Graph::Edge.new([5, 0],  [0, 0])
    edge4 = DataStructures::Graph::Edge.new([0, 5],  [0, 0])
    edge5 = DataStructures::Graph::Edge.new([5, 0],  [7, 0])
    edge6 = DataStructures::Graph::Edge.new([7, 0],  [5, 0])
    edge7 = DataStructures::Graph::Edge.new([7, 0],  [7, 5])
    edge8 = DataStructures::Graph::Edge.new([7, 5],  [7, 0])
    edge9 = DataStructures::Graph::Edge.new([0, 5],  [7, 5])
    edge10 = DataStructures::Graph::Edge.new([7, 5],  [0, 5])

    vertex1 = DataStructures::Graph::Vertex.new([0, 0], edge1, edge2)
    vertex2 = DataStructures::Graph::Vertex.new([0, 5], edge4, edge9)
    vertex3 = DataStructures::Graph::Vertex.new([5, 0], edge5, edge3)
    vertex4 = DataStructures::Graph::Vertex.new([7, 0], edge6, edge7)
    vertex5 = DataStructures::Graph::Vertex.new([7, 5], edge8, edge10)
    vertex6 = DataStructures::Graph::Vertex.new([5, 7])

    @vertices << vertex1 << vertex2 << vertex3 << vertex4 << vertex5 << vertex6
  end
end