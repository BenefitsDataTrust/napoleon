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
      puts "COMMAND.enact result: #{result.inspect}"
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

    # default update, basic update on object, most likely temp
    def update **args
      object = args[:object]
      attrs = args[:attrs]
      obj = object.class.find(object.id)
      obj.class.update_attributes attrs
    end

    def broadcast object
      puts "broadcast, #{object.inspect}"
      if object
        puts "#{Napoleon.broadcasters.inspect}"
        Napoleon.broadcasters.each { |broadcast|
          puts "IN BROADCAST: #{broadcast.inspect}"
          puts "EVENTNAME: #{self.event_name}"
          puts "OBJ: #{object.inspect}"
          broadcast.perform self.event_name, object
        }
      end
    end

    def event_name
      "default.command"
    end

  end
end