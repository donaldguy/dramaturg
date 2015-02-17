require_relative 'base'

module Dramaturg
  class Value::Silent < Value::Base
    def initialize(value)
      super(value)
    end

    def for_prompt
      ""
    end

    def inspect
      "{{silent: '#{@value}'}}"
    end
  end
end
