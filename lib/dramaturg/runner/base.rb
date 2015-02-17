module Dramaturg
  class Runner::Base
    def initialize(script,config={})
      @script = script
      @last_success = true
    end

    def call(cmd)
      unless cmd.skipped?
        line = cmd.map { |v| v.for_run }.join('')

        cmd.ran = line
        cmd.ok = _call(line, cmd)

        if !cmd.ok? && !cmd.fail_ok
          handle_fail(cmd)
        end
      end

      cmd.success?
    end

    def last_success?
      @last_success
    end


    def handle_fail(cmd)
      raise RuntimeError, "#{cmd.ran} failed"
    end
  end
end
