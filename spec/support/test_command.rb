module Commands
  class TestCommand < Napoleon::Command

    def perform **args
      args
    end

    def event_name
      "test.command"
    end

    def before_command args:{}
      "before command success!, args: #{args}"
    end

    def after_command result:{}, args:{}
      "after command success!, result: #{result}, args: #{args}"
    end

  end
end
