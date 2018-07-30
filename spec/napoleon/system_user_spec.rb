require 'spec_helper'

describe Napoleon::SystemUser do
  let(:user) { Napoleon::SystemUser.new }

  it 'is able to perform commands' do
    result = user.test_command arg1:"test_command_result"

    expect(result).to be
    expect(result).to eq({arg1:"test_command_result"})
  end
  
end
