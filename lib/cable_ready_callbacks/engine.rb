module CableReadyCallbacks
  class Engine < ::Rails::Engine
    initializer "connect active record to cable_ready_callbacks" do
      ActiveSupport.on_load(:active_record) do
        extend CableReadyCallbacks::ClassMethods
      end
    end
  end
end
