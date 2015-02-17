require 'dramaturg'

module Dramaturg
  def self.Thor(thor_actions_object, config = {})
    config = ({
      runner: {
        class: Dramaturg::Runner::Thor,
        thor_actions: thor_actions_object
      }
    }).deep_merge(config)

    Dramaturg::Script.new(config)
  end
end
