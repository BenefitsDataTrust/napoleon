module Napoleon
  class Command

    def self.by user
      new user
    end

    attr_reader :user, :broadcast_server_response, :websocket_channel

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

    private
    def perform
      args.first
    end

    def broadcast object
      if object
        puts "#{Napoleon.broadcasters.inspect}"
        Napoleon.broadcasters.each { |broadcast|
          broadcast.perform self.event_name, object, websocket_channel
        }
      end
    end

    def event_name
      "default.command"
    end

  end
end