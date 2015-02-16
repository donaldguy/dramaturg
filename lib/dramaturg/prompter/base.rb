module Dramaturg
  module Prompter
    class Base

      def initialize(script,config)
        @script = script
        @prompt = config[:prompt]
        @formatters = config[:format]
      end

      def prompt
        if @prompt.respond_to? :call
          @prompt.()
        else
          @prompt
        end
      end
    end
  end
end
