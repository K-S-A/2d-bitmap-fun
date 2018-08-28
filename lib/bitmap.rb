# frozen_string_literal: true

require 'area'

require 'validators/colors_validator'
require 'validators/two_dimensional_coordinates_validator'

# Implements some primitive operations on images.
# Image is a rectangle canvas where (`0`,`0`) is the top left coordinate
# and (`width - 1`,`height - 1`) is bottom right coordinate.
# Color is a character of latin alphabet.
# At the beginning all images are transperent.
# == Attributes
# * +width+: canvas width (+Integer+)
# * +height+: canvas height (+Integer+)
class Bitmap
  include Validators::ColorsValidator
  include Validators::TwoDimensionalCoordinatesValidator

  TRANSPARENT = ' '
  COLORS = [TRANSPARENT, *('A'..'Z')].freeze

  attr_reader :width,
              :height

  def initialize(width, height)
    @width = width
    @height = height

    validate!

    clear
  end

  # returns color at coordinate x, y
  def pixel(x, y)
    validate_coordinates!(x, y)

    area.pixel(x, y).color
  end

  # changes color at coordinate x,y
  def draw_pixel(x, y, color)
    validate_coordinates!(x, y)
    validate_color!(color)

    area.draw_pixel(x, y, color)
  end

  # returns string that visually represents canvas
  # after printing it at conlose (puts bitmap.picture)
  # Example for canvas 3x3 picture could look like
  # "ABC\nDEF\nGHI"
  def picture(x1 = 0, y1 = 0, x2 = width - 1, y2 = height - 1)
    validate_coordinates!(x1, y1, x2, y2)

    area.picture(x1, y1, x2, y2)
  end

  # draws a line of specific color from coordinate x1,y1 to x2,y2
  def draw_line(x1, y1, x2, y2, color)
    validate_coordinates!(x1, y1, x2, y2)
    validate_color!(color)

    area.draw_line(x1: x1, y1: y1, x2: x2, y2: y2, color: color)
  end

  # clears whole canvas
  def clear
    @area = Area.new(width, height, TRANSPARENT)
    self
  end

  private

  attr_reader :area
end
