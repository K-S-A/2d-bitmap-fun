# frozen_string_literal: true

class Bitmap
  TRANSPARENT = ' '
  COLORS = [TRANSPARENT, *('A'..'Z')].freeze

  attr_reader :width,
              :height

  def initialize(width, height)
    @width = width
    @height = height
  end

  # returns color at coordinate x, y
  def pixel(x, y)
  end

  # changes color at coordinate x,y
  def draw_pixel(x, y, color)
  end

  # returns string that visually represents canvas
  # after printing it at conlose (puts bitmap.picture)
  # Example for canvas 3x3 picture could look like
  # "ABC\nDEF\nGHI"
  def picture(x1 = 0, y1 = 0, x2 = width - 1, y2 = height - 1)
  end

  # draws a line of specific color from coordinate x1,y1 to x2,y2
  def draw_line(x1, y1, x2, y2, color)
  end

  # clears whole canvas
  def clear
  end
end
