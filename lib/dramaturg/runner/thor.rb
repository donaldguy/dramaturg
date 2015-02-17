require_relative 'base'

module Dramaturg
  class Runner::Thor < Runner::Base
    def initialize(script, config={})
      super
      @thor_actions = config[:thor_actions]
    end

    def _call(line,cmd)
      if cmd.capture_output
        cmd[:output] = @thor_actions.run(line, verbose: false, capture: true)
        cmd.ok = !cmd[:output].empty?
      else
        cmd.ok = @thor_actions.run(line, verbose:false)
      end
    end
  end
end
