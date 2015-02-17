module Dramaturg
  module Prompter
    class Base
      attr_reader :script

      def initialize(script,config)
        @script = script
        @prompt = config[:prompt]
        @formatters = config[:format]
        @abort = false

        @current_command = nil
      end

      def call(cmd)
        @current_command = cmd
        value_map = prepare_values(cmd)
        display = format_for_display(value_map)

        results = doIO(display, value_map)
        abort! unless results

        process_results(results, value_map)
      end

      def abort!
        @abort = true
        @current_command.skip
        return false
      end

      private
      def prompt_for_display
        if @prompt.respond_to? :call
          @prompt.(self)
        else
          @prompt
        end
      end

      def prepare_values(cmd, debug=false)
        cmd.map do |v|
          str = debug ? v.debug_prompt_as : v.prompt_as
          [v, tr_method_map[v].(str)]
        end.to_h
      end
    end
  end
end
