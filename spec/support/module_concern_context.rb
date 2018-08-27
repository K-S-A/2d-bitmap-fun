# frozen_string_literal: true

RSpec.shared_context 'module concern context', :module_concern_context do
  before { klass.include(described_class) }

  let(:klass) { Class.new }
  let(:instance) { klass.new }
end
