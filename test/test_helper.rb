$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'samsung_wam_api'
require 'samsung_wam_api/device'

require 'vcr'
require 'minitest/autorun'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
end
