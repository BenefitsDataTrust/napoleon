module Napoleon
  class Command

    def initialize user:Napoleon::SystemUser.new, **args
      @user = user
      @args = args
    end

    def enact
      before_command args:args
      result = perform **args
      broadcast object:result, event_name:event_name
      after_command result:result, args:args

      result
    end


    private
    
    attr_reader :user, :args

    def event_name
      ""
    end

    def before_command args:nil
    end

    def after_command result:nil, args:{}
    end

    def perform
      raise "A command must have a perform method."
    end

    def broadcast object:, event_name:""
      Napoleon.broadcasters.each { |broadcaster|
        broadcaster.perform event_name, object
      }
    end

  end
end