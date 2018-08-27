# frozen_string_literal: true

module Utility
  # Customized implementation of:
  # https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
  # Line rotation added for better accuracy/resolution.
  # Also works for vertical lines.
  # Does not iterate whole canvas.
  module Bresenham
    def points(x1, y1, x2, y2)
      if x1 > x2
        points(x2, y2, x1, y1)
      elsif x1 == x2 && y1 != y2 || (y2 - y1).abs > (x2 - x1)
        points(y1, x1, y2, x2).map { |y, x| [x, y] }
      else
        approx_points(x1, y1, x2, y2)
      end
    end

    private

    def approx_points(x1, y1, x2, y2)
      delta_x = x2 - x1
      delta_y = (y2 - y1).abs
      slope = y1 > y2 ? -1 : 1

      y_error = 2 * delta_y
      xy_error = y_error - (2 * delta_x)
      delta = y_error - delta_x
      y = y1

      (x1..x2).each_with_object([]) do |x, arr|
        arr << [x, y]

        if delta.positive?
          delta += xy_error
          y += slope
        else
          delta += y_error
        end
      end
    end
  end
end
