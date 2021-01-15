module CableReadyCallbacks
  class StreamResourceJob < ActiveJob::Base
    include CableReady::Broadcaster

    queue_as :default

    def perform(resource)
      channel_name = "#{resource.class.name.pluralize}Channel".safe_constantize

      if block_given?
        yield cable_ready[channel_name]
      else
        cable_ready[channel_name].morph(
          selector: dom_id(resource),
          html: ApplicationController.render(resource)
        ).broadcast_to(resource)
      end
    end
  end
end
