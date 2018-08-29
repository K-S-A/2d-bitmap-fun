# frozen_string_literal: true

require 'validators/base'

module Validators
  # Adds validation for width/height attributes and coordinate values.
  # Assumes, that class implements +width+ and +height+ methods.
  module TwoDimensionalCoordinatesValidator # :nodoc:
    include Base

    def validate!
      raise_error(invalid_size_message(width)) if invalid_size?(width)
      raise_error(invalid_size_message(height)) if invalid_size?(height)
    end

    def validate_coordinates!(*args)
      args.each_slice(2) do |i, j|
        raise_error(invalid_x_message(i)) if invalid_x?(i)
        raise_error(invalid_y_message(j)) if invalid_y?(j)
      end
    end

    private

    def invalid_x?(x)
      !x.is_a?(Integer) || x.negative? || x >= width
    end

    def invalid_y?(y)
      !y.is_a?(Integer) || y.negative? || y >= height
    end

    def invalid_size?(value)
      !value.is_a?(Integer) || !value.positive?
    end

    def invalid_x_message(x)
      "Invalid x coordinate: #{x}. Expected to be within 0..#{width.pred}"
    end

    def invalid_y_message(y)
      "Invalid y coordinate: #{y}. Expected to be within 0..#{height.pred}"
    end

    def invalid_size_message(value)
      "Invalid bitmap size: #{value}. Positive Integer expected"
    end
  end
end
