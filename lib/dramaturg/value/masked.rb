require_relative 'base'

module Dramaturg
  class Value::Masked < Value::Base
    attr_writer :display

    def initialize(value)
      @display = '$SECRET'
      super(value)
    end

    def for_prompt
      @display
    end

    def to_s
      "{#@display}"
    end

    def inspect
      "{#@display = #@value}"
    end
  end
end
