require 'rom/relation'

module ROM
  module JSON
    # JSON-specific relation subclass
    #
    # @api private
    class Relation < ROM::Relation
      forward :join, :project, :restrict, :order
    end
  end
end
