require 'active_support/all'
require "napoleon/version"
require "napoleon/command"
require "napoleon/commander"
require "napoleon/system_user"

module Napoleon

  def self.register broadcaster
    broadcasters << broadcaster
  end

  def self.broadcasters
    @broadcasters ||= []
  end

end