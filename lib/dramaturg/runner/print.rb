require_relative 'base'

module Dramaturg
  class Runner::Print < Runner::Base
    def initialize(script,config={})
      super
    end

    def _call(line,cmd)
      puts "Would run: #{line}"

      cmd.ok = true
    end
  end
end
