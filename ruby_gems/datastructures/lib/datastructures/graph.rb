require_relative 'priority_queue'
require_relative './components/vertex'

module DataStructures
  module Graph
    attr_reader :vertices
    def initialize()
      super()
    end

    def index(vertex)
      vertices.index(vertex)
    end

    def at(index)
      vertices[index]
    end

    def at_location(location)
      idx = index(DataStructures::Components::Vertex.new(location, nil))
      at(idx) unless idx == nil
    end

    def to_s
      "#{self.class.name}[vertices: #{vertices}]"
    end

    def shortest_path(src_location, dest_location)
      predecessors = dijkstras_shortest_path(src_location, dest_location)[1]

      return [] unless predecessors.has_key?(dest_location)

      shortest_path = []

      shortest_path = shortest_path << dest_location

      predecessor = predecessors.fetch(dest_location, nil)

      while (predecessor != nil)
        shortest_path = shortest_path << predecessor

        predecessor = predecessors.fetch(predecessor, nil)
      end

      shortest_path.reverse # arrange src to dest
    end

    def reachable?(src_location, dest_location)
      dijkstras_shortest_path(src_location, dest_location)[0] != Float::INFINITY
    end

    protected

    def edges(row, col, vertices)
      raise NoMethodError("method not implemented; override if required")
    end

    def node?(str)
      raise NoMethodError("method not implemented; override if required")
    end

    private

    def dijkstras_shortest_path(src_location, dest_location)
      src_vertex = at_location(src_location)

      raise ArgumentError.new("No such source and/or destination") unless src_vertex != nil and at_location(dest_location) != nil

      predecessors = {}

      vertices.each { |vertex|
        vertex.distance=(Float::INFINITY)
      }

      src_vertex.distance=(0)
      predecessors.store(src_location, nil)

      priority_queue = DataStructures::PriorityQueue.new(*vertices)

      while (not priority_queue.empty?())
        vertex = priority_queue.remove()

        return [vertex.distance, predecessors] if vertex.location == dest_location

        vertex.edges.each { |edge|
          neighbor = (edge.location1 == vertex.location ? at_location(edge.location2) : at_location(edge.location1))

          candidate_distance = vertex.distance + edge.weight
          if (candidate_distance < neighbor.distance)
            priority_queue.update(neighbor, candidate_distance);
            predecessors.store(neighbor.location, vertex.location)
          end
        }
      end
      return [Float::INFINITY, predecessors]
    end

  end # end of class Graph
end