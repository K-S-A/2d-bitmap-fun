# frozen_string_literal: true

RSpec.describe Area do
  describe '#pixel', :area_context do
    it 'returns Pixel at specified coordinate', :aggregate_failures do
      expect(area_1x1.pixel(0, 0)).to be_kind_of(Area::Pixel)
      expect(area_1x1.pixel(0, 0).color).to eq(' ')

      expect(area_1x2.pixel(0, 0).color).to eq(' ')
      expect(area_1x2.pixel(0, 1).color).to eq('A')

      expect(area_2x1.pixel(0, 0).color).to eq(' ')
      expect(area_2x1.pixel(1, 0).color).to eq('A')

      expect(area_2x2.pixel(0, 0).color).to eq(' ')
      expect(area_2x2.pixel(1, 0).color).to eq('A')
      expect(area_2x2.pixel(0, 1).color).to eq('B')
      expect(area_2x2.pixel(1, 1).color).to eq('C')

      expect(area_2x3.pixel(0, 0).color).to eq(' ')
      expect(area_2x3.pixel(1, 0).color).to eq('A')
      expect(area_2x3.pixel(0, 1).color).to eq('B')
      expect(area_2x3.pixel(1, 1).color).to eq('C')
      expect(area_2x3.pixel(0, 2).color).to eq('D')
      expect(area_2x3.pixel(1, 2).color).to eq('E')

      expect(area_3x2.pixel(2, 1).color).to eq('E')
      expect(area_3x2.pixel(1, 1).color).to eq('D')
      expect(area_3x2.pixel(0, 1).color).to eq('C')
      expect(area_3x2.pixel(2, 0).color).to eq('B')
      expect(area_3x2.pixel(1, 0).color).to eq('A')
      expect(area_3x2.pixel(0, 0).color).to eq(' ')

      expect(area_7x7.pixel(0, 0).color).to eq(' ')
      expect(area_7x7.pixel(6, 6).color).to eq('U')
      expect(area_7x7.pixel(2, 5).color).to eq('J')

      expect(area_500x500.pixel(499, 499).color).to eq('F')
      expect(area_500x500.pixel(300, 300).color).to eq('R')
      expect(area_500x500.pixel(150, 150).color).to eq('I')
      expect(area_500x500.pixel(100, 1).color).to eq('F')
      expect(area_500x500.pixel(200, 350).color).to eq('X')
    end
  end

  describe '#draw_pixel', :area_context do
    it 'sets color at specified coordinate', :aggregate_failures do
      expect { area_1x1.draw_pixel(0, 0, 'H') }.to change { area_1x1.pixel(0, 0).color }.from(' ').to('H')
      expect { area_7x7.draw_pixel(3, 5, 'X') }.to change { area_7x7.pixel(3, 5).color }.from('K').to('X')
      expect { area_500x500.draw_pixel(327, 151, 'C') }.to change { area_500x500.pixel(327, 151).color }.from('K').to('C')
    end
  end

  describe '#picture', :area_context do
    it 'returns stringified representation of the data under specified coordinates', :aggregate_failures do
      expect(area_1x1.picture(0, 0, 0, 0)).to eq(picture_from_file('bitmap_1x1', '0_0'))

      expect(area_1x2.picture(0, 0, 0, 1)).to eq(picture_from_file('bitmap_1x2', '0_0'))
      expect(area_1x2.picture(0, 1, 0, 0)).to eq(picture_from_file('bitmap_1x2', '0_0'))

      expect(area_2x1.picture(0, 0, 1, 0)).to eq(picture_from_file('bitmap_2x1', '0_0'))
      expect(area_2x1.picture(1, 0, 0, 0)).to eq(picture_from_file('bitmap_2x1', '0_0'))
      expect(area_2x1.picture(1, 0, 1, 0)).to eq(picture_from_file('bitmap_2x1', '1_0'))

      expect(area_7x7.picture(2, 2, 5, 4)).to eq(picture_from_file('bitmap_7x7', '2_2_5_4'))
      expect(area_7x7.picture(5, 4, 2, 2)).to eq(picture_from_file('bitmap_7x7', '2_2_5_4'))
      expect(area_7x7.picture(5, 2, 2, 4)).to eq(picture_from_file('bitmap_7x7', '2_2_5_4'))
      expect(area_7x7.picture(2, 4, 5, 2)).to eq(picture_from_file('bitmap_7x7', '2_2_5_4'))

      expect(area_500x500.picture(494, 496, 498, 498)).to eq(picture_from_file('bitmap_500x500', '494_496_498_498'))
      expect(area_500x500.picture(498, 498, 494, 496)).to eq(picture_from_file('bitmap_500x500', '494_496_498_498'))
      expect(area_500x500.picture(498, 496, 494, 498)).to eq(picture_from_file('bitmap_500x500', '494_496_498_498'))
      expect(area_500x500.picture(494, 498, 498, 496)).to eq(picture_from_file('bitmap_500x500', '494_496_498_498'))
    end
  end

  describe '#draw_line' do
    before do
      area0.draw_line(0, 0, 0, 2, 'X')
      area1.draw_line(0, 0, 2, 0, 'X')
      area2.draw_line(0, 0, 2, 2, 'X')
      area3.draw_line(0, 0, 2, 1, 'X')
    end

    let(:area0) { described_class.new(3, 3, ' ') }
    let(:area1) { described_class.new(3, 3, ' ') }
    let(:area2) { described_class.new(3, 3, ' ') }
    let(:area3) { described_class.new(3, 3, ' ') }

    it 'updates color of the pixels on specified line', :aggregate_failures do
      expect(area0.picture(0, 0, 2, 2)).to eq("X  \nX  \nX  ")
      expect(area1.picture(0, 0, 2, 2)).to eq("XXX\n   \n   ")
      expect(area2.picture(0, 0, 2, 2)).to eq("X  \n X \n  X")
      expect(area3.picture(0, 0, 2, 2)).to eq("XX \n  X\n   ")
    end
  end
end
