module Napoleon
  module Commander

    def method_missing method_key, **args
      perform method_key, **args
      super
    end

    def perform method_key, **args
    	CommandBuilder.new(self).send(method_key.to_s, **args)
    end

  end
end
