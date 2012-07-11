$:.push File.expand_path("../lib", __FILE__)
require 'verso'
require 'vcr'

VCR.configure do |c|
  c.hook_into :fakeweb
  c.ignore_localhost = true
  c.cassette_library_dir = 'tmp/cassettes'
end

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate
  # line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  config.extend VCR::RSpec::Macros
end
