module Dramaturg
  module Value
    extend ActiveSupport::Autoload

    autoload :Fixed
    autoload :OrDefault
    autoload :Silent
    autoload :Masked
    autoload :Unknown
  end
end
