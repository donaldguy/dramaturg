require_relative 'base'

module Dramaturg
  module Prompter
    class UseDefaults < Base
      def initialize(script,config)
        super
      end

      def _call(cmd)
        print(prompt, " ", values_to_strings(cmd).join(" "), "\n")

        return if @abort

        @values.each do |key,value|
          cmd[key] = cmd.get(cmd.default(key))
        end
      end

    private
      def values_to_strings(cmd)
        @values = {}

        unfmt = cmd.map do |value|
          if value.is_a? Symbol
            @values[value] = cmd.get(value)
          else
            value
          end
        end

        unfmt.map do |v|
          @formatters[v.class].(v)
        end
      end
    end
  end
end
