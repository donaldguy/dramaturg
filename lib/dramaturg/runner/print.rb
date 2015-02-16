module Dramaturg
  class Runner::Print
    def initialize(script,config={})
    end

    def call(cmd)
      line = cmd.map { |v| cmd.get(v) }.join(' ')

      print "Would run: #{line}"
      cmd.ran = line

      puts ""
    end
  end
end
