require 'madCLIbs'
require 'term/ansicolor'

module Dramaturg
  class Prompter
    include Term::ANSIColor

    def initialize(config={})
      @cli = MadCLIbs.new
      @prompt = config[:prompt] || bold(green("$"))
      @formats = config[:format] || ({
        MadCLIbs::Blanks::String => ->(s){ bold(cyan(s)) },
        Value::Fixed => -> (s) { s }
      })
    end

    def call(cmd)
      @cli.prompt(prompt, *values_to_madclib_tokens(cmd))

      @values.each do |key, entered|
        cmd[key] = entered.value
      end
    end

    def prompt
      if @prompt.respond_to? :call
        @prompt.()
      else
        @prompt
      end
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
        @formats[v.class].(v)
      end
    end
  end
end
