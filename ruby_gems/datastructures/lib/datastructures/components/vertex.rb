module DataStructures
  module Components
    class Vertex
      attr_reader :location
      attr_accessor :value, :distance, :visited, :edges
      # arguments are substituted from left to right, so if you
      # want to assign a value for 'distance', you must do so for 'value' too.
      # Otherwise, the 'value' will get the value sent for distance.
      # ask them why they didn't support overloading.
      def initialize(location, value = Float::INFINITY, 
          distance = Float::INFINITY, visited = false, *edges)
        super() # invocation w/o param actually send all the params passed to initialize! go, figure.

        @location = location
        @value = value
        @visited = visited
        @distance = distance
        @edges = (edges != nil ? edges.compact : []) # remove nil elements from the array
        @edges.each { |edge|
          raise ArgumentError.new(
          "Edge must connect to the vertex location #{location}, " +
          edge.to_s) unless edge.connects?(location)
        }
      end

      # another vertex is a neighbor is it is connected to at least one of this
      # vertex's edges
      def neighbor?(neighbor)
        return true unless not eql?(neighbor)
        return false unless self.class.equal?(neighbor.class) and @edges != nil
        connects = false

        @edges.each { |edge|
          connects = edge.connects?(neighbor.location) or connects
          return true unless not connects
        }
        connects
      end

      def neighbors
        temp = []

        return temp unless @edges != nil

        @edges.each { |edge|
          temp << (edge.location1 == @location ? edge.location2 : edge.location1)
        }

        temp
      end

      def to_s
        "{self.class.name}[location: #{@location}, edges: #{@edges}]"
      end

      def eql?(other)
        self.class.equal?(other.class) &&
        @location == other.location
      end

      def hash
        location.hash
      end

      alias == eql?
    end
  end
end