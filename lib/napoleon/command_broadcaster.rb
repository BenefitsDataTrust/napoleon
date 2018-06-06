module Napoleon
  class CommandBroadcaster

    attr_reader :object, :channels, :event_name, :broadcast_override

    def initialize object:, channels:["portfolio-events"], event_name:"", broadcast_override:false
      @object = object
      @channels = channels
      @event_name = event_name
      @broadcast_override = broadcast_override
    end

    def broadcast
      Napoleon.broadcasters.each { |broadcaster|
        broadcaster.perform(event_name, object, channels) if broadcast?(broadcaster)
      }
    end

    def broadcast? broadcaster
      return true if !broadcaster.respond_to?(:broadcast_all_events)
      return true if broadcaster.broadcast_all_events
      broadcast_override
    end

  end
end
