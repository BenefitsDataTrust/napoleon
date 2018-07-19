module Commands
  class TestCommand < Napoleon::Command

    def perform **args
      result = "test command result"
    end

    def event_name
      "test.command"
    end
  end
end