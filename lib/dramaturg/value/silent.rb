module Dramaturg
  class Value::Silent
    def initialize(val)
      @val = val
    end

    def default
      @val
    end

    def to_str
      @val
    end
  end
end
