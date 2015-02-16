module Dramaturg
  class Command
    module HashLike
      include Enumerable

      #as part of the interface allowing eager evaluation.
      #for internal/pre- or mid-run use, use #get
      def [](k)
        run if !ran?
        get(k)
      end

      def get(k)
        @values ||= {}
        if k.is_a? Symbol
          @values[k]
        elsif k.respond_to? :to_str
          k.to_str
        end
      end

      def []=(k,v)
        @values ||= {}
        @values[k] = v
      end

      def <<(v)
        @line ||= []
        @line << v
      end

      def each &b
        @line.each &b
      end
    end
  end
end
