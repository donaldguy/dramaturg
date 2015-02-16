require_relative 'base'

module Dramaturg
  class Runner::Shell < Runner::Base
    def initialize(script, config={})
      super
    end

    def _call(line,cmd)
      if cmd.capture_output
        cmd[:output] = `#{line}`
        ok = !cmd[:output].empty?
      else
        ok = system(line)
      end
    end
  end
end
