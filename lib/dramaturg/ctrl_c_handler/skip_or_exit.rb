module Dramaturg
  class CtrlCHandler
    class SkipOrExit
      def self.call(prompter, cmd)
        puts "\n^C again to exit; Any other key to skip '#{cmd.name}'"

        require 'mad_clibs/util/iohelper'
        key = IOHelper.read_key(false)

        if key == 'ctrl-c'
          puts "Okay, bye!"
          exit!
        else
          prompter.abort!
        end
      end
    end
  end
end
