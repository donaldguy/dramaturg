require_relative 'base'

module Dramaturg
  module Value
    class Fixed < Base
      def inspect
        @value
      end
    end
  end
end
