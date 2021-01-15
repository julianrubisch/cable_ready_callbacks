module CableReadyCallbacks
  module ClassMethods
    def cable_ready_after_save
      class_eval do
        channel = "#{name.pluralize}Channel"
        Object.const_set(channel, Class.new(ApplicationCable::Channel) do |klass|
                         def subscribed
                           resource_class = self.class.name.match(/\A(?<resource>\w*)Channel\Z/)[:resource].singularize.safe_constantize

                           stream_or_reject_for resource_class.find(params[:id])
                         end
                       end)
      end

      class_exec do
        after_save_commit do
          CableReadyCallbacks::StreamResourceJob.perform_later self
        end
      end
    end
  end
end
