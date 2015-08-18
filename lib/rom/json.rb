require 'rom'

require 'rom/json/version'
require 'rom/json/gateway'
require 'rom/json/relation'

ROM.use :auto_registration
ROM.register_adapter(:json, ROM::JSON)
