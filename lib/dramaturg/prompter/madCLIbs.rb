require_relative 'base'
require 'madCLIbs'

module Dramaturg
  module Prompter
    class MadCLIbs < Base
      attr_reader :current_command

      def initialize(script,config)
        super
        @cli = ::MadCLIbs.new(separator: '')
        @cli.interrupt_handler = ->() { config[:ctrlc].(self, self.current_command) }
      end

      private
      def tr_method_map
        proc do |v|
          if v.kind_of? Value::OrDefault
            @cli.method :string
          else
            String.method :new
          end
        end
      end

      def format_for_display(map)
        ([prompt_for_display] +
          map.map do |k,v|
            @formatters[k.class].(v)
          end
        )
      end

      def doIO(display, map)
        @cli.prompt(*display)
        true
      end

      def process_results(results, map)
        map.each do |dmt_v, mcli_t|
          dmt_v.input(mcli_t.to_s) if dmt_v.respond_to? :input
        end
      end
    end
  end
end
