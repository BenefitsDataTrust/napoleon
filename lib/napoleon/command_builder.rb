module Napoleon
	class CommandBuilder
		attr_reader :user

		def initialize user
			@user = user
		end

		def method_missing method_key, **args, &block
			klass = "Commands::#{camelize(method_key.to_s)}"
			eval(klass).new(user).enact(**args)
		end


		private

		def camelize key
	    key.split("_").each {|s| s.capitalize! }.join("")
	  end

	end
end