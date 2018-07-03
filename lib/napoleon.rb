require "napoleon/version"
require "napoleon/command"
require "napoleon/commander"
require "napoleon/command_broadcaster"

module Napoleon

  def self.register broadcaster
    broadcasters << broadcaster
  end

  def self.broadcasters
    @broadcasters ||= []
  end

end