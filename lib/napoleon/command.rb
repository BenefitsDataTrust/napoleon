require 'napoleon/command_broadcaster'

module Napoleon
  class Command

    attr_reader :user, :args

    def initialize user:SystemUser.new, **args
      @user = user
      @args = args
    end

    def enact
      before_command args:args

      result = perform args
      CommandBroadcaster.broadcast(
        object:result, 
        event_name:event_name, 
      )

      after_command result:result, args:args

      result
    end

    def callback **args
      perform **args
    end

    def event_name
      ""
    end

    def before_command args:nil
    end

    def after_command result:nil, args:{}
    end


    private

    def perform
      raise "A command must have a perform method."
    end

  end
end