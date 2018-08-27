# frozen_string_literal: true

RSpec.describe Validators::TwoDimensionalCoordinatesValidator do
  before { klass.include(described_class) }

  let(:klass) { Struct.new(:width, :height) }

  describe '#validate!' do
    context 'when valid' do
      it 'does not raise error', :aggregate_failures do
        expect { klass.new(1, 1).validate! }.not_to raise_error
        expect { klass.new(rand(1..100), rand(1..100)).validate! }.not_to raise_error
      end
    end

    context 'when inlavid' do
      it 'raises ArgumentError', :aggregate_failures do
        expect { klass.new(0, 1).validate! }.to raise_error(ArgumentError)
        expect { klass.new(1, 0).validate! }.to raise_error(ArgumentError)
        expect { klass.new(0, 0).validate! }.to raise_error(ArgumentError)
        expect { klass.new(-1, 0).validate! }.to raise_error(ArgumentError)
        expect { klass.new(0, -1).validate! }.to raise_error(ArgumentError)
        expect { klass.new(-1, -1).validate! }.to raise_error(ArgumentError)
        expect { klass.new('1', '0').validate! }.to raise_error(ArgumentError)
        expect { klass.new(0, nil).validate! }.to raise_error(ArgumentError)
        expect { klass.new(nil, 0).validate! }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#validate_coordinates!' do
    context 'with valid coordinates' do
      it 'does not raise error', :aggregate_failures do
        expect { klass.new(1, 1).validate_coordinates!(0, 0) }.not_to raise_error
        expect { klass.new(1, 1).validate_coordinates!(0, 0, 0, 0) }.not_to raise_error
        expect { klass.new(7, 7).validate_coordinates!(0, 0) }.not_to raise_error
        expect { klass.new(7, 7).validate_coordinates!(0, 0, 0, 0) }.not_to raise_error
        expect { klass.new(7, 7).validate_coordinates!(6, 6) }.not_to raise_error
        expect { klass.new(7, 7).validate_coordinates!(6, 6, 6, 6) }.not_to raise_error
      end
    end

    context 'with invalid coordinates' do
      it 'raises ArgumentError', :aggregate_failures do
        expect { klass.new(1, 1).validate_coordinates!(1, 0) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(0, 0, 1, 0) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(0, 1) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(0, 0, 0, 1) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(1, 1) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(0, 0, 1, 1) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(-1, 0) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(0, 0, -1, 0) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(0, -1) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(0, 0, 0, -1) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(-1, -1) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(0, 0, -1, -1) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!('1', '0') }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(0, 0, '1', '0') }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(0, nil) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(0, 0, 0, nil) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(nil, 0) }.to raise_error(ArgumentError)
        expect { klass.new(1, 1).validate_coordinates!(0, 0, nil, 0) }.to raise_error(ArgumentError)

        expect { klass.new(7, 7).validate_coordinates!(7, 0) }.to raise_error(ArgumentError)
        expect { klass.new(7, 7).validate_coordinates!(0, 0, 7, 0) }.to raise_error(ArgumentError)
        expect { klass.new(7, 7).validate_coordinates!(0, 7) }.to raise_error(ArgumentError)
        expect { klass.new(7, 7).validate_coordinates!(0, 0, 0, 7) }.to raise_error(ArgumentError)
        expect { klass.new(7, 7).validate_coordinates!(7, 7) }.to raise_error(ArgumentError)
        expect { klass.new(7, 7).validate_coordinates!(0, 0, 7, 7) }.to raise_error(ArgumentError)
      end
    end
  end
end
