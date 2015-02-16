module Dramaturg
  class Runner::Base
    def initialize(script,config={})
    end

    def call(cmd)
      if !cmd.aborted
        line = cmd.map { |v| cmd.get(v) }.join(' ')

        ok = _call(line, cmd)

        cmd.ran = line

        if !ok && !cmd.fail_ok
          handle_fail(cmd)
        end
      else
        cmd.ran = :aborted
        ok = false
      end

      ok
    end

    def handle_fail(cmd)
      raise RuntimeError, "#{cmd.ran} failed"
    end
  end
end
