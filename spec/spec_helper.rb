# encoding: utf-8

require 'bundler'
Bundler.setup

require 'rom-json'

if RUBY_ENGINE == 'rbx'
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

begin
  require 'byebug'
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

root = Pathname(__FILE__).dirname

Dir[root.join('shared/*.rb').to_s].each { |f| require f }
