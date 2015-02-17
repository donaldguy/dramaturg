require_relative 'base'

module Dramaturg
  class Value::Masked
    def initialize(display, value)
      @display = display
      super(value)
    end

    def prompt_as
      @display
    end

    def inspect
      "{#@display}"
    end
  end
end
