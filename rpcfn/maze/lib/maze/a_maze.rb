require 'datastructures'

module Maze
  class AMaze
    include DataStructures::Graph
    def initialize(vertices)
      super()
      @vertices = []
      vertices_array = vertices.split("\n")
      @rows = vertices_array.length
      @cols = vertices_array.first.length
      @rows.freeze
      @cols.freeze

      vertices_array.map.each_with_index { |line, row|
        line.each_char.each_with_index { |char, col|
          if (node?(char))
            @vertices << DataStructures::Components::Vertex.new([row, col], Float::INFINITY, Float::INFINITY, false, *edges(row, col, vertices_array))
          end
        }
      }
    end

    private

    def edges(row, col, vertices)
      list_of_edges = []

      i = row + 1 # search down
      while (node?(vertices[i][col]))
        if (node?(vertices[i][col - 1]) or node?(vertices[i][col + 1]))
          list_of_edges << DataStructures::Components::Edge.new([row, col],  [i, col])
        end
        i += 1
      end

      i = row - 1 # search up
      while (node?(vertices[i][col]))
        if (node?(vertices[i][col - 1]) or node?(vertices[i][col + 1]))
          list_of_edges << DataStructures::Components::Edge.new([row, col],  [i, col])
        end
        i-= 1
      end

      i = col + 1 # search right
      while (node?(vertices[row][i]))
        if (node?(vertices[row - 1][i]) or node?(vertices[row + 1][i]))
          list_of_edges << DataStructures::Components::Edge.new([row, col],  [row, i])
        end
        i += 1
      end

      i = col - 1 # search left
      while (node?(vertices[row][i]))
        if (node?(vertices[row - 1][i]) or node?(vertices[row + 1][i])) # look up/down for nodes
          list_of_edges << DataStructures::Components::Edge.new([row, col],  [row, i])
        end
        i -= 1
      end

      list_of_edges
    end # end of method edges

    def node?(str)
      (str =~ /\s/) != nil
    end
  end
end