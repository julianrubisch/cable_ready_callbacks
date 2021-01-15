module CableReadyCallbacks
  class Channel < ActionCable::Channel::Base
    def subscribed
      stream_or_reject_for # TODO
    end
  end
end
