[![Build Status](https://travis-ci.com/K-S-A/2d-bitmap-fun.svg?branch=master)](https://travis-ci.com/K-S-A/2d-bitmap-fun)
[![Test Coverage](https://api.codeclimate.com/v1/badges/79dfc961451bdb33db81/test_coverage)](https://codeclimate.com/github/K-S-A/2d-bitmap-fun/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/79dfc961451bdb33db81/maintainability)](https://codeclimate.com/github/K-S-A/2d-bitmap-fun/maintainability)
[![Depfu](https://badges.depfu.com/badges/98b38f769188cb97c7968a2ea8951db3/overview.svg)](https://depfu.com/github/K-S-A/2d-bitmap-fun?project=Bundler)
[![Inch CI](https://inch-ci.org/github/K-S-A/2d-bitmap-fun.svg?branch=master&amp;style=flat)](https://inch-ci.org/github/K-S-A/2d-bitmap-fun)

# 2D-bitmap-fun

`Bitmap` class implements some primitive operations on images.
Image is a rectangle canvas where (`0`,`0`) is the top left coordinate and (`width - 1`,`height - 1`) is bottom right coordinate. Color is a character of latin alphabet. At the beginning all images are transperent.

## Installation
Execute:

```console
$ bundle insall
```

## Usage

Open console:

```console
$ irb -I lib
```

Basic usage:

```ruby
require 'bitmap'

bitmap = Bitmap.new(10, 10)
# => #<Bitmap:0x00... >>

bitmap.draw_pixel(2, 6, 'K')
# => "K"

bitmap.pixel(3, 7)
# => " "

bitmap.draw_line(3, 7, 1, 2, 'Y')
# => [[1, 2], [1, 3], [2, 4], [2, 5], [3, 6], [3, 7]]

bitmap.picture
# => "          \n          \n Y        \n Y        \n  Y       \n  Y       \n  KY      \n   Y      \n          \n          "

bitmap.picture(3, 3, 7, 7)
# => "     \n     \n     \nY    \nY    "

bitmap.clear
# => #<Bitmap:0x00... >>
```
## Tests

To run RSpec tests

* `bundle exec rspec` or just `rspec`
* run any test file directly, e.g. `rspec spec/area_spec.rb`

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rspec` to run the tests. You can also run `irb -I lib` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/K-S-A/2d-bitmap-fun. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The lib is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the A project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/K-S-A/2d-bitmap-fun/blob/master/CODE_OF_CONDUCT.md).
