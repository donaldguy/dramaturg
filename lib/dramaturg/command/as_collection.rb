module Dramaturg
  class Command
    module AsCollection
      include Enumerable

      def each &b
        @values.each &b
      end

      def [](i)
        if i.class == Symbol
          run unless ran?
          @outputs[i].for_prompt
        else
          @values[i]
        end
      end

      def []=(i,v)
        @outputs[i] = v
      end

      def <<(v)
        @values << v
      end
    end
  end
end
