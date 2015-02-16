require_relative 'base'

module Dramaturg
  class Runner::Print < Runner::Base
    def initialize(script,config={})
      super
    end

    def _call(line,cmd)
      print "Would run: #{line}"
      cmd.ran = line

      puts ""
    end
  end
end
