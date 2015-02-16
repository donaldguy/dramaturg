module Dramaturg
  class Value::Default
    def initialize(val)
      @val = val
    end

    def default
      @val
    end
  end
end
