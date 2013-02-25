module DataStructures
  module Components
    class Edge
      include Comparable
      attr_reader :location1, :location2, :weight
      def initialize(location1, location2, weight = 0)
        super()

        @location1 = location1
        @location2 = location2

        # assumes only vertical or horizontal edges
        if (weight == 0)
          weight = (location1.first == location2.first) ?
          (location1.last - location2.last).abs : (location1.first - location2.first).abs
        end
        @weight = weight
      end

      def connects?(location)
        @location1.class == location.class and
        ((@location1 == location) or (@location2 == location))
      end

      def to_s
        "{self.class.name}[location1: #{@location1}, location2: #{@location2}, weight: #{weight}]"
      end

      def eql?(other)
        self.class.equal?(other.class) &&
        (self <=> other) == 0
      end

      def hash
        @location1.hash ^ @location2.hash ^ @weight.hash
      end

      # two edges are comparable if they have at least one location in common
      def <=>(other)
        self.class == other.class and
        (@location1 == other.location1 or @location2 == other.location2)?
        @weight <=> other.weight:
        nil
      end

      alias == eql?
    end
  end
end