require 'active_support/dependencies/autoload'
require 'active_support/core_ext/hash/deep_merge'
require 'term/ansicolor'

module Dramaturg
  extend ActiveSupport::Autoload
  autoload :Parser
  autoload :Script
  autoload :Command
  autoload :Value
  autoload :Prompter
  autoload :Runner
  autoload :CtrlCHandler

  COLORS = Term::ANSIColor


  DEFAULT_CONFIG = {
    parser: {
      class: Parser
    },
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
        Value::OrDefault => ->(s) { COLORS.bold(COLORS.cyan(s)) },
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
end
