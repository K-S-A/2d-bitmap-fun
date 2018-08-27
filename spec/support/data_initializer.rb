# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    RSpec::DATA_FROM_FILE = YAML.load_file(File.join(File.dirname(__FILE__), 'data.yml'))
  end
end
