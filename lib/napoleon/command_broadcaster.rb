module Napoleon
  class CommandBroadcaster

    # def self.broadcast object:, channels:["portfolio-events"], event_name:"", broadcast_override:false
    #   Napoleon.broadcasters.each { |broadcaster|
    #     broadcaster.perform(event_name, object, channels) if broadcast?(broadcaster, broadcast_override)
    #   }
    # end

    def self.broadcast event_name:"", object:#, channels:["portfolio-events"]#,broadcast_override:false
      Napoleon.broadcasters.each { |broadcaster|
        broadcaster.perform event_name, object#, channels)# if broadcast?(broadcaster, broadcast_override)
      }
    end


    # private

    # def self.broadcast? broadcaster, broadcast_override
    #   return true if !broadcaster.respond_to?(:broadcast_all_events)
    #   return true if broadcaster.broadcast_all_events
    #   broadcast_override
    # end

  end
end
