# frozen_string_literal: true

require 'bundler'
Bundler.setup

require 'rom-json'

if RUBY_ENGINE == 'rbx'
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end
