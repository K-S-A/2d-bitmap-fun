# frozen_string_literal: true

RSpec.shared_context 'coordinate error context', :coordinate_error_context do
  let(:error_message) do
    /Invalid [xy]{1} coordinate: .*\. Expected to be within 0\.\.\d+/
  end
end

RSpec.shared_context 'color error context', :color_error_context do
  let(:error_message) do
    /Invalid color value: .*\. Use one of:/
  end
end
