# module Napoleon
# 	class CommandBuilder

# 		attr_reader :user, :method_key, :args

# 		def initialize user:, method_key:, args:{}
# 			@user = user
# 			@method_key = method_key
# 			@args = args
# 		end

# 		def enact
# 			command.enact
# 		end


# 		private

# 		def command
# 			"Commands::#{method_key.to_s.camelize}".constantize.new(user, args)
# 		end

# 	end
# end