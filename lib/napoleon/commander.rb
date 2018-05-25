module Napoleon
  module Commander

    def method_missing method_key, **args
      perform method_key, **args
    end

    def perform method_key, **args
    	CommandBuilder.new(user:self, method_key:method_key.to_s, args:args).enact
    end

  end
end