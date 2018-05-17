module Napoleon
  class Command

    attr_reader :issuer#, :broadcast_server_response

    def initialize issuer=SystemUser.new
      @issuer = issuer
    end

    def enact **args
      result = perform **args
      broadcast result
      # Napoleon::CommandResult.new result, broadcast_server_response
      result
    end

    def enact_results **args
      result = perform_results **args
      broadcast result
      # Napoleon::CommandResult.new result, broadcast_server_response
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
      raise "A command must have a perform method."
    end

    def perform_results **args
      perform **args
    end

    def broadcast object
      if object && event_name?
        Napoleon.broadcasters.each { |broadcaster|
          broadcaster.perform(event_name, object) if broadcast?(broadcaster)
        }
      end
    end

    def event_name?
      event_name.present?
    end

    def broadcast? broadcaster
      return true if !broadcaster.respond_to?(:broadcast_all_events)
      return true if broadcaster.broadcast_all_events
      return true if respond_to?(:broadcast!) && broadcast!
    end

  end
end