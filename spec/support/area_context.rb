# frozen_string_literal: true

RSpec.shared_context 'with area context', :area_context do
  before(:all) do
    @area_1x1 = area_factory(valid_colors_generator(1, 1))
    @area_1x2 = area_factory(valid_colors_generator(2, 1))
    @area_2x1 = area_factory(valid_colors_generator(2, 2))
    @area_2x2 = area_factory(valid_colors_generator(4, 2))
    @area_2x3 = area_factory(valid_colors_generator(6, 2))
    @area_3x2 = area_factory(valid_colors_generator(6, 3))
    @area_7x7 = area_factory(valid_colors_generator(49, 7))
    @area_500x500 = area_factory(valid_colors_generator(250_000, 500))
  end

  let(:area_1x1) { @area_1x1 }
  let(:area_1x2) { @area_1x2 }
  let(:area_2x1) { @area_2x1 }
  let(:area_2x2) { @area_2x2 }
  let(:area_2x3) { @area_2x3 }
  let(:area_3x2) { @area_3x2 }
  let(:area_7x7) { @area_7x7 }
  let(:area_500x500) { @area_500x500 }
end
