require 'rspec/simplecov'

SimpleCov.minimum_coverage(100)

SimpleCov.start do
  add_group 'Validators', 'lib/validators'
  add_group 'Utility', 'lib/utility'
  add_filter(%r{^/spec/})
end

RSpec::SimpleCov.start
