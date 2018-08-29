# frozen_string_literal: true

require 'matrix'
require 'utility/bresenham'

# Implements pure logic related to canvas manipulation.
# == Arguments:
# * +width+: canvas width (+Integer+)
# * +height+: canvas height (+Integer+)
# * +color+: canvas color (+String+)
class Area
  include Utility::Bresenham

  attr_reader :data

  Pixel = Struct.new(:color)

  def initialize(width, height, color)
    @data = Matrix.columns(
      Array.new(width) do
        Array.new(height) { Pixel.new(color) }
      end
    )
  end

  def pixel(x, y)
    data[y, x]
  end

  def draw_pixel(x, y, color)
    pixel(x, y).color = color
  end

  def picture(x1, y1, x2, y2)
    data.minor(Range.new(*[y1, y2].sort), Range.new(*[x1, x2].sort))
        .row_vectors
        .map { |row| row.to_a.map(&:color).join }
        .join("\n")
  end

  def draw_line(x1:, y1:, x2:, y2:, color:)
    points(x1, y1, x2, y2).each do |x, y|
      draw_pixel(x, y, color)
    end
  end
end
