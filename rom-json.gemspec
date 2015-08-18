# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rom/json/version'

Gem::Specification.new do |spec|
  spec.name          = 'rom-json'
  spec.version       = ROM::JSON::VERSION.dup
  spec.authors       = ['Piotr Solnica', "Rolf Bjaanes"]
  spec.email         = ['piotr.solnica@gmail.com']
  spec.summary       = 'JSON support for Ruby Object Mapper'
  spec.description   = spec.summary
  spec.homepage      = 'http://rom-rb.org'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency "rom", "~> 0.9.0.rc1"

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop', '~> 0.28.0'
end
