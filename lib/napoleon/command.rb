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

    def broadcast?
      !event_name.empty?
    end

    def event_name
      ""
    end

    private

    def perform
      args.first
    end

    def broadcast object
      if object && broadcast?
        Napoleon.broadcasters.each { |broadcast|
          broadcast.perform event_name, object
        }
      end
    end

  end
end