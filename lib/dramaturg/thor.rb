require 'dramaturg'

module Dramaturg
  def self.Thor(thor_actions_object, config = {})
    config.deep_merge({
      runner: {
        class: Dramaturg::Runner::Thor,
        thor_actions: thor_actions_object
      }
    })

    Dramaturg::Script.new(config)
  end
end
