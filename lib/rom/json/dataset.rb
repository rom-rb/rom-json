require 'rom/memory/dataset'

module ROM
  module JSON
    # JSON in-memory dataset used by JSON gateways
    #
    # @api public
    class Dataset < ROM::Memory::Dataset
      # Data-row transformation proc
      #
      # @api private
      def self.row_proc
        Transproc[:hash_recursion, Transproc[:symbolize_keys]]
      end
    end
  end
end
