$:.push File.expand_path("../lib", __FILE__)
require 'verso'
require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.ignore_localhost = true
  c.cassette_library_dir = 'tmp/cassettes'
  c.default_cassette_options = { :record => :new_episodes }
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.mock_with :rspec
end
