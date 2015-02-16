module Dramaturg
  class Runner::Print
    def initialize()
    end

    def call(cmd)
      print "Would run: "
      cmd.each do |v|
        print cmd.get(v)
        print " "
      end

      puts ""
    end
  end
end
