module Napoleon
  module Commander

    def results_for_command method_key, **args
      CommandBuilder.new(self, method_key.to_s).enact_results(**args)
    end

    def method_missing method_key, **args
      perform method_key, **args
    end

    def perform method_key, **args
    	CommandBuilder.new(self, method_key.to_s).enact(**args)
    end

  end
end