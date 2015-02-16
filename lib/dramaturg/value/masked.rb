module Dramaturg
  class Value::Masked
    def initialize(val)
      @val = val
    end

    def to_str
      @val
    end

    def name(s=nil)
      @name ||= s
      if s == nil
        @name
      else
        self
      end
    end
  end
end
