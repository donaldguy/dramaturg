require_relative 'base'
require 'madCLIbs'

module Dramaturg
  module Prompter
    class MadCLIbs < Base
      def initialize(script,config)
        super
        @cli = ::MadCLIbs.new(separator: '')
        @cli.interrupt_handler = ->() { config[:ctrlc].(self, self.current_command) }
      end

      def _call(cmd)
        @current_command = cmd
        @cli.prompt(prompt, *values_to_madclib_tokens(cmd))

        return if @abort

        @values.each do |key, entered|
          cmd[key] = entered.value
        end
      end

    private
      def value_type_to_token_type(t)
        @type_map ||=
        {
          Value::Default => ::MadCLIbs::Blanks::String,
          Value::Fixed => Value::Fixed #i.e. ::String
        }
        @type_map[t]
      end

      def token_type_to_value_type(t)
        value_type_to_token_type(t)
        @reverse_type_map ||= Hash[@type_map.to_a.map(&:reverse)]
        @reverse_type_map[t]
      end

      def values_to_madclib_tokens(cmd)
        @values = {}

        unfmt = cmd.map do |value|
          if value.is_a? Symbol
            @values[value] = @cli.string(cmd.default(value))
          else
            value
          end
        end

        unfmt.map do |v|
          @formatters[token_type_to_value_type(v.class)].(v)
        end
      end
    end
  end
end
