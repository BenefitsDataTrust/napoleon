require "napoleon/version"
require "napoleon/command_builder"
require "napoleon/command_result"
require "napoleon/command"
require "napoleon/commander"
require "napoleon/command_broadcaster"

module Napoleon
  mattr_accessor :eventory_post, :eventory_postback

  def self.register broadcaster
    broadcasters << broadcaster
  end

  def self.broadcasters
    @broadcasters ||= []
  end

end