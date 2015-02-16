require 'term/ansicolor'


module Dramaturg
  class Script
    include Term::ANSIColor

    def initialize(config = {})
      @config = config.reverse_merge({
        prompter: {
          class: Prompter::MadCLIbs,
          prompt: ->() {
            if self.runner.last_success?
              bold(green("$"))
            else
              bold(red("$"))
            end
          },
          format: {
            Value::Default => ->(s){ bold(cyan(s)) },
            Value::Fixed => -> (s) { s }
          },
          ctrlc: CtrlCHandler::SkipOrExit
        },
        runner: {
          class: Runner::Shell
        },
      })

      @commands = []
    end

    def cmd(command_str, &opts)
      c = Command.new(command_str, self)
      @commands << c

      if opts
        c.instance_eval &opts
      end

      c
    end
    alias call cmd
    alias [] cmd

    def prompter
      @prompter ||= @config[:prompter][:class].new(
        self,
        @config[:prompter]
      )
    end

    def runner
      @runner ||= @config[:runner][:class].new(
        self,
        @config[:runner]
      )
    end

    def execute(cmd)
      cmd.parse!
      prompter.(cmd)
      runner.(cmd)
    end

    def run_all
      @commands.each do |cmd|
        unless cmd.ran?
          execute(cmd)
        end
      end
    end
  end
end
