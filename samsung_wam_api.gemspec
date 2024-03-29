# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'samsung_wam_api/version'

Gem::Specification.new do |spec|
  spec.name          = "samsung_wam_api"
  spec.version       = SamsungWamApi::VERSION
  spec.authors       = ["Marek Hulan"]
  spec.email         = ["mhulan@redhat.com"]

  spec.summary       = 'Gem provides Ruby Samsung WAM API wrapper'
  spec.description   = 'Gem provides Ruby Samsung WAM API wrapper'
  spec.homepage      = 'https://github.com/ares/samsung_wam_api'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "webmock", "~> 3.2"
  spec.add_development_dependency "vcr", "~> 4.0"
  spec.add_development_dependency "pry"

  spec.add_dependency 'activesupport'
  spec.add_dependency 'libxml-ruby'
  spec.add_dependency 'rexml'
end
