# frozen_string_literal: true

RSpec.shared_context 'with bitmap context', :bitmap_context do
  before(:all) do
    @bitmap_1x1 = bitmap_factory(valid_colors_generator(1, 1))
    @bitmap_1x2 = bitmap_factory(valid_colors_generator(2, 1))
    @bitmap_2x1 = bitmap_factory(valid_colors_generator(2, 2))
    @bitmap_2x2 = bitmap_factory(valid_colors_generator(4, 2))
    @bitmap_2x3 = bitmap_factory(valid_colors_generator(6, 2))
    @bitmap_3x2 = bitmap_factory(valid_colors_generator(6, 3))
    @bitmap_7x7 = bitmap_factory(valid_colors_generator(49, 7))
    @bitmap_500x500 = bitmap_factory(valid_colors_generator(250_000, 500))
  end

  let(:bitmap_1x1) { @bitmap_1x1 }
  let(:bitmap_1x2) { @bitmap_1x2 }
  let(:bitmap_2x1) { @bitmap_2x1 }
  let(:bitmap_2x2) { @bitmap_2x2 }
  let(:bitmap_2x3) { @bitmap_2x3 }
  let(:bitmap_3x2) { @bitmap_3x2 }
  let(:bitmap_7x7) { @bitmap_7x7 }
  let(:bitmap_500x500) { @bitmap_500x500 }
end
