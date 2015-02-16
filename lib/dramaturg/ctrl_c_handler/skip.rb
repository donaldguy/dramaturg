module Dramaturg
  class CtrlCHandler
    class Skip
      def self.call(prompter, cmd)
        puts "\nSkipping #{cmd.name}"
        prompter.abort!
      end
    end
  end
end
