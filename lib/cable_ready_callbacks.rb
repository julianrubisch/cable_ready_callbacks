require "cable_ready_callbacks/version"
require "cable_ready_callbacks/engine"

module CableReadyCallbacks
  def cable_ready_morph
    CableReadyCallbacks::StreamResourceJob.perform_later self
  end

  def self.included(mod)
    class_eval do
      channel = "#{mod.name.pluralize}Channel"
      Object.const_set(channel, Class.new(ApplicationCable::Channel) {
                                  def subscribed
                                    resource_class = self.class.name.match(/\A(?<resource>\w*)Channel\Z/)[:resource].singularize.safe_constantize

                                    stream_or_reject_for resource_class.find(params[:id])
                                  end
                                })
    end
  end
end
