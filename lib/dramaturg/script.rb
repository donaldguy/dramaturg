require 'term/ansicolor'

COLORS = Term::ANSIColor

module Dramaturg
  class Script

    DEFAULT_CONFIG = {
      prompter: {
        class: Prompter::MadCLIbs,
        prompt: ->(p) {
          if p.script.runner.last_success?
            COLORS.bold(COLORS.green("$ "))
          else
            COLORS.bold(COLORS.red("$ "))
          end
        },
        format: {
          Value::Default => ->(s) { COLORS.bold(COLORS.cyan(s)) },
          Value::Fixed   => ->(s) { s },
          Value::Silent  => ->(s) { "" },
          Value::Masked  => ->(s) { s.name }
        },
        ctrlc: CtrlCHandler::SkipOrExit
      },
      runner: {
        class: Runner::Shell
      }
    }

    def initialize(config = {})
      @config = DEFAULT_CONFIG.deep_merge(config)

      @commands = []
    end

    def cmd(command_str, &opts)
      run_all if @config[:run_previous_on_declare]
      c = Command.new(command_str, self)
      @commands << c

      if opts
        c.instance_eval &opts
      end

      c
    end
    alias call cmd
    alias [] cmd

    def masked_value(str)
      Value::Masked.new(str)
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
  end
end
