# frozen_string_literal: true

RSpec.describe Validators::ColorsValidator do
  describe '#validate_color!', :module_concern_context do
    before { klass::COLORS = %w[A B C].freeze }

    context 'when valid' do
      it 'does not raise error' do
        expect { klass.new.validate_color!('B') }.not_to raise_error
      end
    end

    context 'when inlavid' do
      it 'raises ArgumentError' do
        expect { klass.new.validate_color!('D') }.to raise_error(ArgumentError)
      end
    end
  end
end
