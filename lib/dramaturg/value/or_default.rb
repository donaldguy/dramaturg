require_relative 'base'

module Dramaturg
  module Value
    class OrDefault < Base
      def initialize(value)
        @default = value
        super(value)
      end

      def input(i)
        @value = i
      end

      def to_s
        "{#@value}"
      end

      def inspect
        "{#@value (default: #@dfault)}"
      end
    end
  end
end
