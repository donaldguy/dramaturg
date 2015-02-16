require_relative 'command/hash_like'
require_relative 'command/parser'
require_relative 'command/opt'

module Dramaturg
  class Command
    include Command::HashLike
    include Command::Parser
    include Command::Opt

    opt :name, ->(cmd) { cmd.program_name }
    opt :program_name, ->(cmd){cmd.to_s[/^\S+/]}
    opt :aborted, false

    opt :allow_suffix, ->(cmd){!!(cmd.to_s =~ /\s+$/)}
    opt :capture_output, false
    opt :fail_ok, false

    attr_accessor :ran
    alias ran? ran

    def initialize(cmd_str, script)
      @cmd_str = cmd_str
      @script = script
      @ran = false
    end

    def run
      @script.execute(self)
      self
    end

    def default(v)
      self.get(v).default
    end

    def to_s
      @cmd_str
    end
  end
end
