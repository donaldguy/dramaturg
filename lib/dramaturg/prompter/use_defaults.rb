require_relative 'base'

module Dramaturg
  module Prompter
    class UseDefaults < Base
      def initialize(script,config)
        super
      end

      private
      def tr_method_map
        proc {|s| Kernel.method :String }
      end

      def format_for_display(map)
        prompt_for_display +
          map.map do |k,v|
            @formatters[k.class].(v)
          end.join('')
      end

      def doIO(display,map)
        puts display
        true
      end

      def process_results(*args)
        #no input
      end
    end
  end
end
