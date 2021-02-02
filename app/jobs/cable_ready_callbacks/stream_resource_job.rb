module CableReadyCallbacks
  class StreamResourceJob < ActiveJob::Base
    include CableReady::Broadcaster

    queue_as :default

    def perform(resource, operations = nil)
      channel_name = "#{resource.class.name.pluralize}Channel".safe_constantize

      if operations.nil?
        cable_ready[channel_name].morph(
          selector: dom_id(resource),
          html: ApplicationController.render(resource)
        ).broadcast_to(resource)
      else
        cable_ready[channel_name].apply(operations).broadcast_to(resource)
      end
    end
  end
end
