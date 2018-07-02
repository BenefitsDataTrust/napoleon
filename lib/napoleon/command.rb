require 'napoleon/command_broadcaster'

module Napoleon
  class Command

    attr_reader :user, :args#, :extra_broadcasts, :return_function#, :broadcast_server_response

    # def self.by user
    #   new user
    # end

    def initialize user:SystemUser.new, **args
      @user = user
      # allows you to generate additional broadcasts, using custom command methods, to custom topics
      # @extra_broadcasts = *args.delete(:extra_broadcasts)
      # # changes the returned object using a custom command method
      # @return_function = args.delete(:return_function)
      @args = args
    end

    def enact

      before_command

      result = perform args
      # result = if return_function
      #   send(return_function.to_sym, args)
      # else
      #   perform args
      # end

      CommandBroadcaster.broadcast(
        object:result, 
        event_name:event_name, 
        # broadcast_override:command_broadcast_override
      )

      # handle_extra_broadcasts(result) if extra_broadcasts.present?

      after_command(result:result)

      # Napoleon::CommandResponse.new result, broadcast_server_response
      # transform(raw_result:result)
    end

    def callback **args
      perform **args
    end

    def event_name
      ""
    end

    # def transform_result raw_result:
    #   raw_result
    # end

    def before_command
    end

    def after_command result:
      result
    end


    private

    # def handle_extra_broadcasts result
    #   extra_broadcasts.each do |callback|
    #     send(callback.to_sym, result, args)
    #   end
    # end

    def perform
      raise "A command must have a perform method."
    end

    # def command_broadcast_override
    #   respond_to?(:broadcast!) && broadcast!
    # end

  end
end