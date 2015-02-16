require 'active_support/concern'


module Dramaturg::Command::Opt
  extend ActiveSupport::Concern

  class_methods do
    def opt(name, default)
      self.send(:define_method, name, ->(arg=nil) do
        iv_symbol = "@opt_#{name.to_s}".to_sym

        if arg.nil? && !self.instance_variable_defined?(iv_symbol)
          default_value = default.respond_to?(:call)? default.(self) : default
          self.instance_variable_set(iv_symbol, default_value)
        end

        if arg != nil
          arg_value = arg.respond_to?(:call)? arg.(self) : arg
          self.instance_variable_set(iv_symbol, arg_value)
          return self #allow chaining
        end

        self.instance_variable_get(iv_symbol)
      end)
    end
  end
end
