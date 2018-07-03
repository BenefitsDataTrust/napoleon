module Napoleon
  class CommandBroadcaster

    def self.broadcast event_name:"", object:
      Napoleon.broadcasters.each { |broadcaster|
        broadcaster.perform event_name, object
      }
    end

  end
end
