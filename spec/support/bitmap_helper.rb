# frozen_string_literal: true

require 'yaml'
require 'bitmap'

module BitmapHelper
  def bitmap_factory(rows)
    draw_factory(Bitmap.new(rows.first.size, rows.size), rows)
  end

  def area_factory(rows)
    draw_factory(Area.new(rows.first.size, rows.size, ' '), rows)
  end

  def valid_colors_generator(count = 27, slice_size = nil)
    colors_generator([' ', *('A'..'Z')], count, slice_size)
  end

  def invalid_colors_generator(count = 68, slice_size = nil)
    colors_generator([*('!'..'@').to_a, *('['..'~').to_a], count, slice_size)
  end

  def picture_from_file(*args)
    RSpec::DATA_FROM_FILE.dig('pictures', *args)
  end

  def points_from_file(*args)
    RSpec::DATA_FROM_FILE.dig('points', *args)
  end

  private

  def draw_factory(obj, rows)
    rows.each_with_index.with_object(obj) do |(row, y), o|
      row.each_with_index do |color, x|
        o.draw_pixel(x, y, color)
      end
    end
  end

  def colors_generator(palette, count, slice_size)
    palette = palette.cycle(2**62).take(count)
    palette = palette.each_slice(slice_size).to_a if slice_size
    palette
  end
end
