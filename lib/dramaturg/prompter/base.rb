module Dramaturg
  module Prompter
    class Base
      attr_reader :current_command

      def initialize(script,config)
        @script = script
        @prompt = config[:prompt]
        @formatters = config[:format]
        @current_command = nil
        @abort = false
      end

      def prompt
        if @prompt.respond_to? :call
          @prompt.()
        else
          @prompt
        end
      end

      def abort!
        @abort = true
        self.current_command.aborted(true)
        return false
      end
    end
  end
end
