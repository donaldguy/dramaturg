require_relative 'base'

module Dramaturg
  class Runner::Shell < Runner::Base
    def initialize(script, config={})
      super
    end

    def _call(line,cmd)
      if cmd.capture_output
        output = `#{line}`
        cmd[:output] = output
        cmd.ok = !output.empty?
      else
        cmd.ok = system(line)
      end
    end
  end
end
