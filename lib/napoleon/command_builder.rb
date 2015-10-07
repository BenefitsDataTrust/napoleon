module Napoleon
	class CommandBuilder
		attr_reader :user

		def initialize user
			@user = user
		end

		def method_missing method_key, **args, &block
			klass = "Commands::#{method_key.to_s.camelize}"
			klass.constantize.new(user).enact(**args)
		end

	end
end