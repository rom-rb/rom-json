require 'json'

require 'rom/gateway'
require 'rom/json/dataset'

module ROM
  module JSON
    # JSON gateway
    #
    # Connects to a json file and uses it as a data-source
    #
    # @example
    #   ROM.setup(:json, '/path/to/data.yml')
    #
    #   rom = ROM.finalize.env
    #
    #   gateway = rom.gateways[:default]
    #
    #   gateway.dataset?(:users) # => true
    #   gateway[:users] # => data under 'users' key from the json file
    #
    # @api public
    class Gateway < ROM::Gateway
      # @attr_reader [Hash] sources Data loaded from files
      #
      # @api private
      attr_reader :sources

      # @attr_reader [Hash] datasets JSON datasets from sources
      #
      # @api private
      attr_reader :datasets

      # Create a new json gateway from a path to file(s)
      #
      # @example
      #   gateway = ROM::JSON::Gateway.new('/path/to/files')
      #
      # @param [String, Pathname] path The path to your JSON file(s)
      #
      # @return [Gateway]
      #
      # @api public
      def self.new(path)
        super(load_from(path))
      end

      # Load data from json file(s)
      #
      # @api private
      def self.load_from(path)
        if File.directory?(path)
          load_files(path)
        else
          load_file(path)
        end
      end

      # Load json files from a given directory and return a name => data map
      #
      # @api private
      def self.load_files(path)
        Dir["#{path}/*.js"].each_with_object({}) do |file, h|
          name = File.basename(file, '.*')
          h[name] = load_file(file).fetch(name)
        end
      end

      # Load json file
      #
      # @api private
      def self.load_file(path)
        ::JSON.parse(File.read(path))
      end

      # @param [String] path The absolute path to json file
      #
      # @api private
      def initialize(sources)
        @sources = sources
        @datasets = {}
      end

      # Return dataset by its name
      #
      # @param [Symbol]
      #
      # @return [Array<Hash>]
      #
      # @api public
      def [](name)
        datasets.fetch(name)
      end

      # Register a new dataset
      #
      # @param [Symbol]
      #
      # @return [Dataset]
      #
      # @api public
      def dataset(name)
        datasets[name] = Dataset.new(sources.fetch(name.to_s))
      end

      # Return if a dataset with provided name exists
      #
      # @api public
      def dataset?(name)
        datasets.key?(name)
      end
    end
  end
end
