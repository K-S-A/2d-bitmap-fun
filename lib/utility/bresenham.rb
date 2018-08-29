# frozen_string_literal: true

module Utility
  # Customized implementation of:
  # https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
  # Line rotation added for better accuracy/resolution.
  # Also works for vertical lines.
  # Does not iterate whole canvas.
  module Bresenham
    def points(x1, y1, x2, y2)
      Line.new(x1, y1, x2, y2).points
    end

    # Implements Bresenham's line algorithm
    #
    # == Attributes
    #   * +x1+: x coordinate of the first point
    #   * +y1+: y coordinate of the first point
    #   * +x2+: x coordinate of the second point
    #   * +y2+: y coordinate of the second point
    class Line
      attr_reader :x1,
                  :y1,
                  :x2,
                  :y2,
                  :vertical

      def initialize(x1, y1, x2, y2)
        @x1 = x1
        @y1 = y1
        @x2 = x2
        @y2 = y2

        @vertical = vertical?

        normalize_params!
      end

      def points
        @points ||= if vertical
                      approx_points.map(&:reverse)
                    else
                      approx_points
                    end
      end

      private

      def vertical?
        (y2 - y1).abs > (x2 - x1).abs
      end

      def normalize_params!
        if vertical
          @x1, @y1 = @y1, @x1
          @x2, @y2 = @y2, @x2
        end

        return if x1 < x2

        @x1, @x2 = @x2, @x1
        @y1, @y2 = @y2, @y1
      end

      def approx_points
        delta = y_derrivative - delta_x
        y = y1

        (x1..x2).each_with_object([]) do |x, arr|
          arr << [x, y]
          delta, y = next_delta_y(delta, y)
        end
      end

      def next_delta_y(delta, y)
        if delta.positive?
          [delta + xy_derrivative, y + slope]
        else
          [delta + y_derrivative, y]
        end
      end

      def delta_x
        @delta_x ||= x2 - x1
      end

      def delta_y
        @delta_y ||= (y2 - y1).abs
      end

      def slope
        @slope ||= y1 > y2 ? -1 : 1
      end

      def y_derrivative
        @y_derrivative ||= 2 * delta_y
      end

      def xy_derrivative
        @xy_derrivative ||= y_derrivative - (2 * delta_x)
      end
    end
  end
end
