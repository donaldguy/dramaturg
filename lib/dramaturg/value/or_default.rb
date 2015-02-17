require_relative 'base'

module Dramaturg
  module Value
    class OrDefault < Base
      def initialize(value)
        @default = value
        super(value)
      end

      def for_prompt
        @default
      end

      def input(i)
        @value = i
      end

      def inspect
        "{#{@value}}"
      end
    end
  end
end
