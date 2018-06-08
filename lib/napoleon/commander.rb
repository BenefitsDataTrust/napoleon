module Napoleon
  module Commander

    def method_missing method_key, **args
      perform method_key, **args
    end

    def perform method_key, **args
    	"Commands::#{method_key.to_s.camelize}".constantize.new(user:self, **args).enact
    # rescue NameError
    #   p "Method #{method_key} does not exist on #{self.class}, nor is it a defined command"
    end

  end
end