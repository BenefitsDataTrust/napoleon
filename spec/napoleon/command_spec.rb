require 'spec_helper'

describe Napoleon::Command do
  let(:user) { Napoleon::SystemUser.new }
  let(:command) { Commands::TestCommand.new(user:user) }

  it '#enacts (#performs) a command, returning its result' do
    result = user.test_command arg1:"test_command_result"

    expect(result).to be
    expect(result).to eq({arg1:"test_command_result"})
  end

  it 'has an event name' do
    expect(command.event_name).to eq "test.command"
  end

  it 'performs a before command when supplied' do
    expect(command.before_command).to be_present
  end

  it 'performs an after command when supplied' do
    expect(command.after_command).to be_present
  end
  
end
