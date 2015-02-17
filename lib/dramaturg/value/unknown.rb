require_relative 'or_default'

module Dramaturg
  module Value
    class Unknown < OrDefault
      def initialize()
        super(nil)
      end

      def for_prompt
        '???'
      end

      def for_run
        if @value == nil
          raise ArgumentError, "You must set a value"
        else
          @value
        end
      end

      def inspect
        "[unknown]"
      end
    end
  end
end
