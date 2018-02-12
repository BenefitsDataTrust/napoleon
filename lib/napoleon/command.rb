module Napoleon
  class Command

    def self.by user
      new user
    end

    attr_reader :user, :broadcast_server_response

    def initialize user=SystemUser.new
      @user = user
    end

    def enact **args
      result = perform **args
      broadcast result
      Napoleon::CommandResult.new result, broadcast_server_response
      result
    end

    def callback **args
      perform **args
    end

    def event_name
      ""
    end


    private

    def perform
      args.first
    end

    def broadcast object
      if object && event_name?
        Napoleon.broadcasters.each { |broadcaster|
          broadcaster.perform(event_name, object) if broadcast?(broadcaster)
        }
      end
    end

    def event_name?
      !event_name.empty?
    end

    def broadcast? broadcaster
      return true if !broadcaster.respond_to?(:broadcast_all_events)
      return true if broadcaster.broadcast_all_events
      return true if respond_to?(:broadcast!) && broadcast!
    end

  end
end