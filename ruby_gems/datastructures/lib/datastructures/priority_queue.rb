require 'forwardable'

module DataStructures
  class PriorityQueue
    include Enumerable
    extend Forwardable

    attr_reader :vertices
    def initialize(*vertices)
      super()
      @vertices = (vertices != nil ? vertices.compact : []) # remove any nil elements from the array

      @sort = lambda {
        @vertices.sort! { |vertex1, vertex2|
          vertex1.distance <=> vertex2.distance # asc sort
        }
      }

      @sort.call
    end

    def_delegators :@vertices, :each, :length, :empty? # :push, :pop, :&, :index, :[], :<<

    def add(vertex)
      return self if vertex == nil

      @vertices << vertex

      @sort.call

      @vertices
    end

    def remove
      return nil if @vertices.empty?()

      vertex = @vertices.delete_at(0)

      @sort.call

      vertex
    end

    def update(vertex, key)
      return self if vertex == nil
      idx = @vertices.index(vertex)
      (@vertices[idx]).distance=(key) unless idx == nil

      @sort.call

      @vertices
    end

    def to_s
      "#{self.class.name}[vertices: #{@vertices}]"
    end
  end
end