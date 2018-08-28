# frozen_string_literal: true

require 'validators/base'

module Validators
  # Adds validation for color values
  # Assumes, that class should provide +COLORS+ array with allowed values.
  module ColorsValidator
    include Base

    def validate_color!(value)
      raise_error(invalid_color_message(value)) if invalid_color?(value)
    end

    private

    def invalid_color?(value)
      !self.class::COLORS.include?(value)
    end

    def invalid_color_message(value)
      %(Invalid color value: #{value}. Use one of: "#{self.class::COLORS.join('", "')}")
    end
  end
end
