module Dramaturg
  class Parser
  class <<self
    def call(cmd)
      tokens = tokenize(cmd.to_s)

      tokens.each do |t|
        case t
        when /^\{(\w+):(.+)\}$/
          add_named_value(cmd, $1.to_sym, $2)
        when /^\{([^\$].*)\}$/
          add_anon_value(cmd, $1)
        when /^\{(\$.+)\}/
          add_var_value(cmd, $1)
        else
          cmd << Value::Fixed.new(t)
        end
      end

      if cmd.allow_suffix
        suffix = Value::OrDefault.new("")
        cmd[:_suffix] = suffix
        cmd << suffix
      end

      if cmd.save_to_file
        cmd << Value::Silent.new(" | tee #{cmd.save_to_file}")
      end
    end

    private
    def tokenize(s)
      s.split /(?=\{)|(?<=\})/
    end

    def add_anon_value(cmd, expression)
      cmd << Value::OrDefault.new(expression)
    end

    def add_named_value(cmd, name, value)
      value = Value::OrDefault.new(value)
      cmd[name] = value
      cmd << value
    end

    def add_var_value(cmd, var)
      exists = eval("defined? #{var}")
      key = var.to_sym

      if exists == 'global-variable'
        value = eval(var)
        value = Value::Fixed(value) unless value.is_a? Value::Base
        value.display = var if value.respond_to? :display=

        cmd << value
      else
        $stderr.puts "WARN: Reference to undefined global #{$1} at #{caller(7).join("\n\t")}"
      end
    end
  end
  end
end
