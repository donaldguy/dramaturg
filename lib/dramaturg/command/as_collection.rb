module Dramaturg
  class Command
    module AsCollection
      include Enumerable

      def each &b
        @values.each &b
      end

      def [](i)
        run unless ran?
        if self.respond_to? i
          self.send i
        else
          @outputs[i].for_prompt
        end
      end

      def []=(i,v)
        @outputs[i] = v
      end

      def <<(v)
        @values << v
      end

      def output
        @outputs[:output]
      end
    end
  end
end
