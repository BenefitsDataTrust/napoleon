require 'napoleon/command_broadcaster'

module Napoleon
  class Command

    attr_reader :user, :extra_broadcasts, :return_function, :args#, :broadcast_server_response

    def self.by user
      new user
    end

    def initialize user:SystemUser.new, **args
      @user = user
      # allows you to generate additional broadcasts, using custom command methods, to custom topics
      @extra_broadcasts = *args.delete(:extra_broadcasts)
      # changes the returned object using a custom command method
      @return_function = args.delete(:return_function)
      @args = args
    end

    def enact
      result = if return_function
        p "return function: #{return_function}"
        send(return_function.to_sym, args)
      else
        p "no return function"
        perform args
      end

      CommandBroadcaster.new(object:result, event_name:event_name, broadcast_override:command_broadcast_override).broadcast

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
        send(callback.to_sym, result, args)
      end
    end

    def perform
      raise "A command must have a perform method."
    end

    def command_broadcast_override
      respond_to?(:broadcast!) && broadcast!
    end

  end
end