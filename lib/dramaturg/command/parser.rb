module Dramaturg
  class Command
    module Parser
      def parse!
        tokens = tokenize(self.to_s)

        tokens.each do |t|
          case t
          when /^\{(\w+):(.+)\}$/
            key = $1.to_sym
            self[key] = Value::Default.new($2)
            self << key
          when /^\{(.+)\}$/
            key = $1.to_sym
            self[key] = Value::Default.new($1)
            self << key
          else
            self << Value::Fixed.new(t)
          end
        end

        if self.allow_suffix
          self[:__suffix] = Value::Default.new("")
          self << :__suffix
        end
      end

      private
      def tokenize(s)
        s.split /(?=\{)|(?<=\})/
      end
    end
  end
end
