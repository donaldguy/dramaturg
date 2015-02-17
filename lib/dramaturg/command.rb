require_relative 'command/as_collection'
require_relative 'command/opt'

module Dramaturg
  class Command
    include Command::AsCollection
    include Command::Opt

    opt :name, ->(cmd) { cmd[0].to_s.strip }
    opt :program_name, ->(cmd){cmd[0].for_run[/^\S+/]}

    #prompt behavior
    opt :allow_suffix, ->(cmd){!!(cmd[-1].for_prompt =~ /\s+$/)}

    #run behavior
    opt :fail_ok, false

    #output direction
    opt :capture_output, false
    opt :save_to_file, false

    def initialize(cmd_str, script)
      @input_string = cmd_str
      @script = script
      @values = []
      @outputs = {}
    end

    def run
      @script.execute(self)
      self
    end
    attr_accessor :ran
    def ran?; @ran ||= false; end

    def skip
      @ok = :skipped
      @skipped = true
      @outputs.each {|k,_| @outputs[k] = Value::Unknown }
    end
    def skipped?; @skipped ||= false; end

    attr_accessor :ok
    alias ok? ok
    alias success? ok
    alias succeeded? ok

    def to_s
      if @values.empty?
        @input_string
      else
        self.map {|t| t.to_s}.join ''
      end
    end
  end
end
