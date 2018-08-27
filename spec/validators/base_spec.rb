# frozen_string_literal: true

RSpec.describe Validators::Base, :module_concern_context do
  describe '#raise_error' do
    let(:message) { 'Some message' }

    it 'raises ArgumentError with a message' do
      expect { instance.raise_error(message) }.to raise_error(ArgumentError, message)
    end
  end
end
