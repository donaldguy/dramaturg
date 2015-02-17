require_relative 'command/as_collection'
require_relative 'command/opt'

module Dramaturg
  class Command
    include Command::AsCollection
    include Command::Opt

    opt :name, ->(cmd) { cmd[0].to_s.strip }
    opt :program_name, ->(cmd){cmd[0].run_as[/^\S+/]}

    #prompt behavior
    opt :allow_suffix, ->(cmd){!!(cmd[-1].prompt_as =~ /\s+$/)}

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
    alias ran? ran

    def skip
      @ran = :skipped
      @skipped = true
      @outputs.each {|k,_| @outputs[k] = Value::Unknown }
    end
    def skipped?; @skipped ||= false; end

    def to_s
      if @values.empty?
        @input_string
      else
        self.map {|t| t.to_s}.join ''
      end
    end
  end
end
