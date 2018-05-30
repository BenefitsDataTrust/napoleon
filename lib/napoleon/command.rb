module Napoleon
  class Command

    attr_reader :user, :channel, :extra_broadcasts, :return_function, :args#, :broadcast_server_response

    def self.by user
      new user
    end

    def initialize user=SystemUser.new, args
      @user = user
      @channel = args.delete(:channel)
      # allows you to generate additional broadcasts to various pubsub topics
      @extra_broadcasts = *args.delete(:extra_broadcasts)
      # changes the return object
      @return_function = args.delete(:return_function)
      @args = args
    end

    def enact
      result = if return_function
        send(return_function.to_sym, args)
      else
        perform args
      end

      CommandBroadcaster.new(object:result, event_name:event_name, broadcast:broadcast_override?).broadcast

      handle_extra_broadcasts(result) if extra_broadcasts.present?

      # Napoleon::CommandResponse.new result, broadcast_server_response
      result
    end

    def callback **args
      perform **args
    end

    def event_name
      ""
    end


    private

    def handle_extra_broadcasts result
      extra_broadcasts.each do |callback|
        send(callback.to_sym, result:result, args)
      end
    end

    def perform
      raise "A command must have a perform method."
    end

    def broadcast_override?
      respond_to?(:broadcast!) && broadcast!
    end

  end
end