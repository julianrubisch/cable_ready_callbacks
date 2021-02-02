require "cable_ready_callbacks/version"
require "cable_ready_callbacks/engine"

module CableReadyCallbacks
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

  class CableReadyMorph
    def initialize(operations = nil)
      @operations = CableReady::OperationsSerializer.new(*operations) unless operations.nil?
    end

    def after_commit(resource)
      CableReadyCallbacks::StreamResourceJob.perform_later resource, @operations&.verified
    end
  end
end
