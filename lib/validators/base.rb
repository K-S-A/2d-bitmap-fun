# frozen_string_literal: true

module Validators
  module Base # :nodoc:
    def raise_error(message)
      raise(ArgumentError, message)
    end
  end
end
