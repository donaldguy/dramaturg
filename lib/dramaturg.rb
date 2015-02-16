require 'dramaturg/version'
require 'active_support/dependencies/autoload'
require 'active_support/core_ext/hash/deep_merge'

module Dramaturg
  extend ActiveSupport::Autoload
    autoload :Script
    autoload :Command
    autoload :Value
    autoload :Prompter
    autoload :Runner
    autoload :CtrlCHandler
end
