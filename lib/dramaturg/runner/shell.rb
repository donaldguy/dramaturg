module Dramaturg
  class Runner::Shell
    def initialize(script)
      @script = script
    end

    def call(cmd)
      line = cmd.map { |v| cmd.get(v) }.join(' ')

      if cmd.capture_output
        cmd[:output] = `#{line}`
        ok = !cmd[:output].empty?
      else
        ok = system(line)
      end

      if !ok && !cmd.fail_ok
        @script.handle_fail(cmd)
      end

      ok
    end
  end
end
