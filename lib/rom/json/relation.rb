# frozen_string_literal: true

require 'rom/memory'
require 'rom/json/schema'

module ROM
  module JSON
    # JSON-specific relation subclass
    #
    # @api private
    class Relation < ROM::Memory::Relation
      adapter :json

      schema_class JSON::Schema
    end
  end
end
