module Dramaturg
  class Script
    def initialize(config = {})
      @config = config.reverse_merge({
        prompter: Prompter.new,
        runner: Runner::Shell.new(self),
      })

      @commands = []
    end

    def call(command_str, &opts)
      c = Command.new(command_str, self)
      @commands << c

      if opts
        c.instance_eval &opts
      end

      c
    end

    def [](c,&s)
      self.call(c,&s)
    end

    def run(cmd)
      cmd.parse!
      @config[:prompter].(cmd)
      @config[:runner].(cmd)
      cmd.ran = true
    end

    def run_all
      @commands.each do |cmd|
        unless cmd.ran?
          run(cmd)
        end
      end
    end
  end
end
