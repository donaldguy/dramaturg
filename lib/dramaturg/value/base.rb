module Dramaturg
  module Value
    class Base
      def initialize(value)
        @value = value
      end

      def for_prompt
        @value
      end

      def for_debug_prompt
        @value
      end

      def for_run
        @value
      end

      #for tokens which accept input add a
      #def input(i)
      # # modify state
      #end

      # should match parser input
      def to_s
        for_prompt
      end
    end
  end
end
