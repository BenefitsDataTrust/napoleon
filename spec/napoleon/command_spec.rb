require 'spec_helper'

describe Napoleon::Command do
  let(:user) { SystemUser.new }

  context '#enact' do
    it 'performs a command, returning its result' do
      result = user.test_command
      expect(result).to be
    end
  end
  
end
