module Dramaturg
  class Runner::Shell
    def initialize(script, config={})
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

      cmd.ran = line

      if !ok && !cmd.fail_ok
        handle_fail(cmd)
      end

      ok
    end


    def handle_fail(cmd)
      raise RuntimeError, "#{cmd.ran} failed"
    end
  end
end
