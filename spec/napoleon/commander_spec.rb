require 'spec_helper'

describe Napoleon::Commander do
  let(:user) { Napoleon::SystemUser.new }

  it 'finds the appropriate command' do
    result = user.test_command arg1:"test_command_result"

    expect(result).to be
  end

  it 'raises an error if passed an incorrect method/command' do
    expect{ user.test_fake_command }.to raise_error RuntimeError
  end

end
