module Napoleon
  class Command

    attr_reader :user, :channel, :return_function, :args#, :broadcast_server_response

    def self.by user
      new user
    end

    def initialize user=SystemUser.new, args
      @user = user
      @channel = args.delete(:channel)
      @return_function = args.delete(:return_function)
      @args = args
    end

    def enact
      result = if return_function
        send(return_function.to_sym, args)
      else
        perform args
      end

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

    def broadcast object
      if object && event_name?
        Napoleon.broadcasters.each { |broadcaster|
          broadcaster.perform(event_name, object, channel) if broadcast?(broadcaster)
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