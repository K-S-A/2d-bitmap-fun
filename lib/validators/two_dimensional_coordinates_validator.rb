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

    def invalid_x?(value)
      !value.is_a?(Integer) || value.negative? || value >= width
    end

    def invalid_y?(value)
      !value.is_a?(Integer) || value.negative? || value >= height
    end

    def invalid_size?(value)
      !value.is_a?(Integer) || !value.positive?
    end

    def invalid_x_message(value)
      "Invalid x coordinate: #{value}. Expected to be within 0..#{width.pred}"
    end

    def invalid_y_message(value)
      "Invalid y coordinate: #{value}. Expected to be within 0..#{height.pred}"
    end

    def invalid_size_message(value)
      "Invalid bitmap size: #{value}. Positive Integer expected"
    end
  end
end
