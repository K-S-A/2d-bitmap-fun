# frozen_string_literal: true

RSpec.describe Bitmap do
  let(:bitmap) { described_class.new(320, 240) }

  describe '.new' do
    context 'with both positive width and height' do
      it 'returns new instance' do
        expect { bitmap }.not_to raise_error
      end
    end

    context 'with invalid width or height' do
      it 'raises ArgumentError' do
        expect { described_class.new(0, 1) }.to raise_error(ArgumentError)
        expect { described_class.new(1, 0) }.to raise_error(ArgumentError)
        expect { described_class.new(0, 0) }.to raise_error(ArgumentError)
        expect { described_class.new(-1, 0) }.to raise_error(ArgumentError)
        expect { described_class.new(0, -1) }.to raise_error(ArgumentError)
        expect { described_class.new(-1, -1) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#width' do
    subject(:width) { bitmap.width }

    it 'returns value of @width' do
      expect(width).to eq(320)
    end
  end

  describe '#height' do
    subject(:height) { bitmap.height }

    it 'returns value of @height' do
      expect(height).to eq(240)
    end
  end

  describe '#pixel', :bitmap_context do
    context 'with valid coordinates' do
      it 'returns color at specified coordinate', :aggregate_failures do
        expect(bitmap_1x1.pixel(0, 0)).to eq(' ')
        expect(bitmap_1x2.pixel(0, 1)).to eq('A')
        expect(bitmap_2x1.pixel(1, 0)).to eq('A')
        expect(bitmap_2x2.pixel(1, 1)).to eq('C')
        expect(bitmap_2x3.pixel(0, 2)).to eq('D')
        expect(bitmap_3x2.pixel(2, 0)).to eq('B')
        expect(bitmap_7x7.pixel(2, 5)).to eq('J')
        expect(bitmap_500x500.pixel(200, 350)).to eq('X')
      end
    end

    context 'with invalid coordinates', :coordinate_error_context do
      it 'raises ArgumentError', :aggregate_failures do
        expect { bitmap_1x1.pixel(nil, 0) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x1.pixel(0, nil) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x1.pixel('1', 0) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x1.pixel(0, '1') }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x1.pixel(-1, -1) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x1.pixel(0, -1) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x1.pixel(-1, 0) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x1.pixel(0, 1) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x1.pixel(1, 0) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x1.pixel(1, 1) }.to raise_error(ArgumentError, error_message)

        expect { bitmap_1x2.pixel(-1, -1) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x2.pixel(0, -1) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x2.pixel(-1, 0) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x2.pixel(1, 0) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x2.pixel(0, 2) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x2.pixel(1, 1) }.to raise_error(ArgumentError, error_message)

        expect { bitmap_2x1.pixel(-1, -1) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_2x1.pixel(0, -1) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_2x1.pixel(-1, 0) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_2x1.pixel(0, 1) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_2x1.pixel(2, 0) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_2x1.pixel(1, 1) }.to raise_error(ArgumentError, error_message)

        expect { bitmap_7x7.pixel(7, 6) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_7x7.pixel(6, 7) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_7x7.pixel(7, 7) }.to raise_error(ArgumentError, error_message)

        expect { bitmap_500x500.pixel(500, 499) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_500x500.pixel(499, 500) }.to raise_error(ArgumentError, error_message)
        expect { bitmap_500x500.pixel(500, 500) }.to raise_error(ArgumentError, error_message)
      end
    end
  end

  describe '#draw_pixel', :bitmap_context do
    context 'with valid coordinates and color' do
      it 'sets color at specified coordinate', :aggregate_failures do
        expect { bitmap_1x1.draw_pixel(0, 0, 'E') }.to change { bitmap_1x1.pixel(0, 0) }.from(' ').to('E')
        expect { bitmap_7x7.draw_pixel(3, 5, 'H') }.to change { bitmap_7x7.pixel(3, 5) }.from('K').to('H')
        expect { bitmap_500x500.draw_pixel(327, 151, 'L') }.to change { bitmap_500x500.pixel(327, 151) }.from('K').to('L')
      end
    end

    context 'with invalid coordinates', :coordinate_error_context do
      it 'raises ArgumentError', :aggregate_failures do
        expect { bitmap_1x1.draw_pixel(-1, 0, ' ') }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x1.draw_pixel(0, -1, ' ') }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x1.draw_pixel(1, 0, ' ') }.to raise_error(ArgumentError, error_message)
        expect { bitmap_1x1.draw_pixel(0, 1, ' ') }.to raise_error(ArgumentError, error_message)
        expect { bitmap_7x7.draw_pixel(7, 6, ' ') }.to raise_error(ArgumentError, error_message)
        expect { bitmap_7x7.draw_pixel(6, 7, ' ') }.to raise_error(ArgumentError, error_message)
        expect { bitmap_7x7.draw_pixel(7, 7, ' ') }.to raise_error(ArgumentError, error_message)
        expect { bitmap_500x500.draw_pixel(500, 0, ' ') }.to raise_error(ArgumentError, error_message)
        expect { bitmap_500x500.draw_pixel(0, 500, ' ') }.to raise_error(ArgumentError, error_message)
        expect { bitmap_500x500.draw_pixel(500, 500, ' ') }.to raise_error(ArgumentError, error_message)
      end
    end

    context 'with invalid color', :color_error_context do
      it 'raises ArgumentError', :aggregate_failures do
        invalid_colors_generator.each do |color|
          expect { bitmap_1x1.draw_pixel(0, 0, color) }.to raise_error(ArgumentError, error_message)
        end
      end
    end
  end

  describe '#picture', :bitmap_context do
    context 'without specified coordinates' do
      it 'returns stringified representation of the whole bitmap', :aggregate_failures do
        expect(bitmap_1x1.picture).to eq(picture_from_file('bitmap_1x1', '0_0'))
        expect(bitmap_1x2.picture).to eq(picture_from_file('bitmap_1x2', '0_0'))
        expect(bitmap_2x1.picture).to eq(picture_from_file('bitmap_2x1', '0_0'))
        expect(bitmap_2x2.picture).to eq(picture_from_file('bitmap_2x2', '0_0'))
        expect(bitmap_2x3.picture).to eq(picture_from_file('bitmap_2x3', '0_0'))
        expect(bitmap_3x2.picture).to eq(picture_from_file('bitmap_3x2', '0_0'))
        expect(bitmap_7x7.picture).to eq(picture_from_file('bitmap_7x7', '0_0'))
        expect(bitmap_500x500.picture).to eq(picture_from_file('bitmap_500x500', '0_0'))
      end
    end

    context 'when one coordinate is specified' do
      context 'with valid coordinate' do
        it 'returns stringified representation of the bitmap under specified coordinates', :aggregate_failures do
          expect(bitmap_1x1.picture(0)).to eq(picture_from_file('bitmap_1x1', '0_0'))
          expect(bitmap_1x2.picture(0)).to eq(picture_from_file('bitmap_1x2', '0_0'))
          expect(bitmap_2x1.picture(0)).to eq(picture_from_file('bitmap_2x1', '0_0'))
          expect(bitmap_2x1.picture(1)).to eq(picture_from_file('bitmap_2x1', '1_0'))
          expect(bitmap_2x2.picture(0)).to eq(picture_from_file('bitmap_2x2', '0_0'))
          expect(bitmap_2x2.picture(1)).to eq(picture_from_file('bitmap_2x2', '1_0'))
          expect(bitmap_2x3.picture(0)).to eq(picture_from_file('bitmap_2x3', '0_0'))
          expect(bitmap_2x3.picture(1)).to eq(picture_from_file('bitmap_2x3', '1_0'))
          expect(bitmap_3x2.picture(2)).to eq(picture_from_file('bitmap_3x2', '2_0'))
          expect(bitmap_3x2.picture(1)).to eq(picture_from_file('bitmap_3x2', '1_0'))
          expect(bitmap_3x2.picture(0)).to eq(picture_from_file('bitmap_3x2', '0_0'))
          expect(bitmap_7x7.picture(0)).to eq(picture_from_file('bitmap_7x7', '0_0'))
          expect(bitmap_7x7.picture(1)).to eq(picture_from_file('bitmap_7x7', '1_0'))
          expect(bitmap_7x7.picture(2)).to eq(picture_from_file('bitmap_7x7', '2_0'))
          expect(bitmap_7x7.picture(3)).to eq(picture_from_file('bitmap_7x7', '3_0'))
          expect(bitmap_7x7.picture(4)).to eq(picture_from_file('bitmap_7x7', '4_0'))
          expect(bitmap_500x500.picture(0)).to eq(picture_from_file('bitmap_500x500', '0_0'))
          expect(bitmap_500x500.picture(499)).to eq(picture_from_file('bitmap_500x500', '499_0'))
        end
      end

      context 'with invalid coordinate', :coordinate_error_context do
        it 'raises ArgumentError', :aggregate_failures do
          expect { bitmap_1x1.picture(-1) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x2.picture(1) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x1.picture(2) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x2.picture(2) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x3.picture(2) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_3x2.picture(3) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_7x7.picture(7) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_7x7.picture(nil) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_7x7.picture(1.0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_7x7.picture('3') }.to raise_error(ArgumentError, error_message)
          expect { bitmap_500x500.picture(500) }.to raise_error(ArgumentError, error_message)
        end
      end
    end

    context 'when two coordinates are specified' do
      context 'with valid coordinates' do
        it 'returns stringified representation of the bitmap under specified coordinates', :aggregate_failures do
          expect(bitmap_1x1.picture(0, 0)).to eq(picture_from_file('bitmap_1x1', '0_0'))

          expect(bitmap_1x2.picture(0, 0)).to eq(picture_from_file('bitmap_1x2', '0_0'))
          expect(bitmap_1x2.picture(0, 1)).to eq(picture_from_file('bitmap_1x2', '0_1'))

          expect(bitmap_2x1.picture(0, 0)).to eq(picture_from_file('bitmap_2x1', '0_0'))
          expect(bitmap_2x1.picture(1, 0)).to eq(picture_from_file('bitmap_2x1', '1_0'))

          expect(bitmap_2x2.picture(0, 0)).to eq(picture_from_file('bitmap_2x2', '0_0'))
          expect(bitmap_2x2.picture(1, 0)).to eq(picture_from_file('bitmap_2x2', '1_0'))
          expect(bitmap_2x2.picture(0, 1)).to eq(picture_from_file('bitmap_2x2', '0_1'))
          expect(bitmap_2x2.picture(1, 1)).to eq(picture_from_file('bitmap_2x2', '1_1'))

          expect(bitmap_2x3.picture(0, 0)).to eq(picture_from_file('bitmap_2x3', '0_0'))
          expect(bitmap_2x3.picture(1, 0)).to eq(picture_from_file('bitmap_2x3', '1_0'))
          expect(bitmap_2x3.picture(0, 1)).to eq(picture_from_file('bitmap_2x3', '0_1'))
          expect(bitmap_2x3.picture(1, 1)).to eq(picture_from_file('bitmap_2x3', '1_1'))
          expect(bitmap_2x3.picture(0, 2)).to eq(picture_from_file('bitmap_2x3', '0_2'))
          expect(bitmap_2x3.picture(1, 2)).to eq(picture_from_file('bitmap_2x3', '1_2'))

          expect(bitmap_3x2.picture(2, 1)).to eq(picture_from_file('bitmap_3x2', '2_1'))
          expect(bitmap_3x2.picture(1, 1)).to eq(picture_from_file('bitmap_3x2', '1_1'))
          expect(bitmap_3x2.picture(0, 1)).to eq(picture_from_file('bitmap_3x2', '0_1'))
          expect(bitmap_3x2.picture(2, 0)).to eq(picture_from_file('bitmap_3x2', '2_0'))
          expect(bitmap_3x2.picture(1, 0)).to eq(picture_from_file('bitmap_3x2', '1_0'))
          expect(bitmap_3x2.picture(0, 0)).to eq(picture_from_file('bitmap_3x2', '0_0'))

          expect(bitmap_7x7.picture(0, 0)).to eq(picture_from_file('bitmap_7x7', '0_0'))
          expect(bitmap_7x7.picture(6, 6)).to eq(picture_from_file('bitmap_7x7', '6_6'))
          expect(bitmap_7x7.picture(2, 5)).to eq(picture_from_file('bitmap_7x7', '2_5'))

          expect(bitmap_500x500.picture(0, 0)).to eq(picture_from_file('bitmap_500x500', '0_0'))
          expect(bitmap_500x500.picture(100, 1)).to eq(picture_from_file('bitmap_500x500', '100_1'))
          expect(bitmap_500x500.picture(499, 499)).to eq(picture_from_file('bitmap_500x500', '499_499'))
          expect(bitmap_500x500.picture(300, 300)).to eq(picture_from_file('bitmap_500x500', '300_300'))
          expect(bitmap_500x500.picture(150, 150)).to eq(picture_from_file('bitmap_500x500', '150_150'))
          expect(bitmap_500x500.picture(200, 350)).to eq(picture_from_file('bitmap_500x500', '200_350'))
        end
      end

      context 'with invalid coordinates', :coordinate_error_context do
        it 'raises ArgumentError', :aggregate_failures do
          expect { bitmap_1x1.picture(0, 1) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(1, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(1, 1) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(nil, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(0, nil) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(-1, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(0, -1) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(-1, -1) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(1.0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(0, 1.0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture('1', 0) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_1x2.picture(0, 2) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x2.picture(1, 1) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_2x1.picture(0, 1) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x1.picture(2, 0) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_2x2.picture(0, 2) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x2.picture(2, 0) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_2x3.picture(2, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x3.picture(1, 3) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_3x2.picture(3, 1) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_3x2.picture(1, 2) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_7x7.picture(7, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_7x7.picture(5, 7) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_500x500.picture(500, 100) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_500x500.picture(300, 500) }.to raise_error(ArgumentError, error_message)
        end
      end
    end

    context 'when three coordinates are specified' do
      context 'with valid coordinates' do
        it 'returns stringified representation of the bitmap under specified coordinates', :aggregate_failures do
          expect(bitmap_1x1.picture(0, 0, 0)).to eq(picture_from_file('bitmap_1x1', '0_0'))

          expect(bitmap_1x2.picture(0, 0, 0)).to eq(picture_from_file('bitmap_1x2', '0_0'))
          expect(bitmap_1x2.picture(0, 1, 0)).to eq(picture_from_file('bitmap_1x2', '0_1'))

          expect(bitmap_2x1.picture(0, 0, 0)).to eq(picture_from_file('bitmap_2x1', '0_0_0'))
          expect(bitmap_2x1.picture(1, 0, 0)).to eq(picture_from_file('bitmap_2x1', '0_0'))

          expect(bitmap_7x7.picture(2, 2, 5)).to eq(picture_from_file('bitmap_7x7', '2_2_5_6'))
          expect(bitmap_7x7.picture(5, 2, 2)).to eq(picture_from_file('bitmap_7x7', '2_2_5_6'))

          expect(bitmap_500x500.picture(494, 496, 498)).to eq(picture_from_file('bitmap_500x500', '494_496_498_499'))
          expect(bitmap_500x500.picture(498, 496, 494)).to eq(picture_from_file('bitmap_500x500', '494_496_498_499'))
        end
      end

      context 'with invalid coordinates', :coordinate_error_context do
        it 'raises ArgumentError', :aggregate_failures do
          expect { bitmap_1x1.picture(0, 1, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(1, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(0, 0, 1) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(1, 1, 1) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(nil, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(0, nil, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(0, 0, nil) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(-1, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(0, -1, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(0, 0, -1) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_1x2.picture(1, 2, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x2.picture(0, 2, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x2.picture(0, 0, 1) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x2.picture(1, 2, 1) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_2x1.picture(0, 1, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x1.picture(2, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x1.picture(0, 0, 2) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_2x2.picture(0, 2, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x2.picture(2, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x2.picture(0, 0, 2) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_2x3.picture(2, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x3.picture(1, 3, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x3.picture(0, 0, 2) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_3x2.picture(3, 1, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_3x2.picture(1, 2, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_3x2.picture(0, 0, 3) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_7x7.picture(7, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_7x7.picture(5, 7, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_7x7.picture(0, 0, 7) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_500x500.picture(500, 100, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_500x500.picture(300, 500, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_500x500.picture(0, 0, 500) }.to raise_error(ArgumentError, error_message)
        end
      end
    end

    context 'when four coordinates are specified' do
      context 'with valid coordinates' do
        it 'returns stringified representation of the bitmap under specified coordinates', :aggregate_failures do
          expect(bitmap_1x1.picture(0, 0, 0, 0)).to eq(picture_from_file('bitmap_1x1', '0_0'))

          expect(bitmap_1x2.picture(0, 0, 0, 1)).to eq(picture_from_file('bitmap_1x2', '0_0'))
          expect(bitmap_1x2.picture(0, 1, 0, 0)).to eq(picture_from_file('bitmap_1x2', '0_0'))

          expect(bitmap_2x1.picture(0, 0, 1, 0)).to eq(picture_from_file('bitmap_2x1', '0_0'))
          expect(bitmap_2x1.picture(1, 0, 0, 0)).to eq(picture_from_file('bitmap_2x1', '0_0'))
          expect(bitmap_2x1.picture(1, 0, 1, 0)).to eq(picture_from_file('bitmap_2x1', '1_0'))

          expect(bitmap_7x7.picture(2, 2, 5, 4)).to eq(picture_from_file('bitmap_7x7', '2_2_5_4'))
          expect(bitmap_7x7.picture(5, 4, 2, 2)).to eq(picture_from_file('bitmap_7x7', '2_2_5_4'))
          expect(bitmap_7x7.picture(5, 2, 2, 4)).to eq(picture_from_file('bitmap_7x7', '2_2_5_4'))
          expect(bitmap_7x7.picture(2, 4, 5, 2)).to eq(picture_from_file('bitmap_7x7', '2_2_5_4'))

          expect(bitmap_500x500.picture(494, 496, 498, 498)).to eq(picture_from_file('bitmap_500x500', '494_496_498_498'))
          expect(bitmap_500x500.picture(498, 498, 494, 496)).to eq(picture_from_file('bitmap_500x500', '494_496_498_498'))
          expect(bitmap_500x500.picture(498, 496, 494, 498)).to eq(picture_from_file('bitmap_500x500', '494_496_498_498'))
          expect(bitmap_500x500.picture(494, 498, 498, 496)).to eq(picture_from_file('bitmap_500x500', '494_496_498_498'))
        end
      end

      context 'with invalid coordinates', :coordinate_error_context do
        it 'raises ArgumentError', :aggregate_failures do
          expect { bitmap_1x1.picture(1, 0, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(0, 1, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(0, 0, 1, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(0, 0, 0, 1) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_1x1.picture(1, 1, 1, 1) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_2x3.picture(2, 0, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x3.picture(0, 3, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x3.picture(0, 0, 2, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_2x3.picture(0, 0, 0, 3) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_7x7.picture(7, 0, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_7x7.picture(0, 7, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_7x7.picture(0, 0, 7, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_7x7.picture(0, 0, 0, 7) }.to raise_error(ArgumentError, error_message)

          expect { bitmap_500x500.picture(500, 0, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_500x500.picture(0, 500, 0, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_500x500.picture(0, 0, 500, 0) }.to raise_error(ArgumentError, error_message)
          expect { bitmap_500x500.picture(0, 0, 0, 500) }.to raise_error(ArgumentError, error_message)
        end
      end
    end
  end

  describe '#draw_line', :bitmap_context do
    context 'with valid coordinates and color' do
      it 'draws a line with a color for specified coordinates', :aggregate_failures do
        expect { bitmap_1x1.draw_line(0, 0, 0, 0, 'G') }.to change(bitmap_1x1, :picture).from(' ').to('G')

        expect { bitmap_7x7.draw_line(1, 2, 4, 6, 'X') }.to(
          change(bitmap_7x7, :picture).from(picture_from_file('bitmap_7x7', '0_0'))
                                       .to(" ABCDEF\nGHIJKLM\nNXPQRST\nUVXXYZ \nABXDEFG\nHIJXLMN\nOPQRXTU")
        )
      end
    end

    context 'with invalid coordinates', :coordinate_error_context do
      it 'raises ArgumentError', :aggregate_failures do
        expect { bitmap_1x1.draw_line(0, 0, 0, 1, 'K') }.to raise_error(ArgumentError, error_message)
        expect { bitmap_2x3.draw_line(0, 0, 2, 0, 'S') }.to raise_error(ArgumentError, error_message)
        expect { bitmap_2x3.draw_line(0, 0, 0, 3, 'A') }.to raise_error(ArgumentError, error_message)
      end
    end

    context 'with invalid color', :color_error_context do
      it 'raises ArgumentError', :aggregate_failures do
        invalid_colors_generator.each do |color|
          expect { bitmap_1x1.draw_line(0, 0, 0, 0, color) }.to raise_error(ArgumentError, error_message)
        end
      end
    end
  end

  describe '#clear', :bitmap_context do
    before do
      bitmap_1x1.clear
      bitmap_7x7.clear
    end

    it 'clears canvas and returns self' do
      expect(bitmap_1x1.picture.strip.empty?).to eq(true)
      expect(bitmap_7x7.picture.strip.empty?).to eq(true)
    end
  end
end
