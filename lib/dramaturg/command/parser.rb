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
          when /^\{([^\$].+)\}$/
            key = $1.to_sym
            self[key] = Value::Default.new($1)
            self << key
          when /^\{(\$.+)\}/
            exists = eval("defined? #{$1}")
            if exists == 'global-variable'
              self << eval($1).name($1)
            else
              $stderr.puts "WARN: Reference to undefined global #{$1} at #{caller(7).join("\n\t")}"
            end
          else
            self << Value::Fixed.new(t)
          end
        end

        if self.allow_suffix
          self[:__suffix] = Value::Default.new("")
          self << :__suffix
        end

        if self.save_to_file
          self << Value::Silent.new(" | tee #{self.save_to_file}")
        end
      end

      private
      def tokenize(s)
        s.split /(?=\{)|(?<=\})/
      end
    end
  end
end
