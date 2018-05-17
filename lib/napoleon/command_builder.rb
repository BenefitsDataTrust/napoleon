module Napoleon
	class CommandBuilder

		attr_reader :issuer, :method_key

		def initialize issuer, method_key
			@issuer = issuer
			@method_key = method_key
		end

		def enact **args, &block
			command.enact **args
		end

		def enact_results **args
			command.enact_results **args
		end


		private

		def command
			"Commands::#{method_key.to_s.camelize}".constantize.new(issuer)
		end

	end
end