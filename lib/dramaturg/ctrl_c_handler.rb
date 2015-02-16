module Dramaturg
  class CtrlCHandler
    extend ActiveSupport::Autoload

    autoload :Skip
    autoload :SkipOrExit
  end
end
