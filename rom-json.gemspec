# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rom/json/version'

Gem::Specification.new do |spec|
  spec.name          = 'rom-json'
  spec.version       = ROM::JSON::VERSION.dup
  spec.authors       = ['Piotr Solnica', 'Rolf Bjaanes']
  spec.email         = ['piotr.solnica@gmail.com']
  spec.summary       = 'JSON support for Ruby Object Mapper'
  spec.description   = spec.summary
  spec.homepage      = 'http://rom-rb.org'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.4.0'

  spec.add_runtime_dependency 'rom-core', '~> 5.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
end
