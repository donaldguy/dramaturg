module Dramaturg
  class Script
    def initialize(config = {})
      @config = Dramaturg::DEFAULT_CONFIG.deep_merge(config)

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
      #require 'pry'; binding.pry
      parser.(cmd)
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

    def parser
      @config[:parser][:class]
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
