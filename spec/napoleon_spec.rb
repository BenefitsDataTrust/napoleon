require 'spec_helper'

describe Napoleon do
  it 'has a version number' do
    expect(Napoleon::VERSION).not_to be nil
  end

  context ".register" do
    it "allows the registration of a broadcaster" do
      expect { Napoleon.register TestBroadcaster.new }.to change { Napoleon.broadcasters.count }.by 1
    end
  end

  context ".broadcasters" do
    before :each do
      Napoleon.register TestBroadcaster.new
    end

    it "is an array of all registered broadcasters" do
      expect(Napoleon.broadcasters).to be_a Array
      expect(Napoleon.broadcasters.length).to be > 0
    end

    it "individual broadcasters should be able to #perform" do
      expect(Napoleon.broadcasters.first.perform).to be
    end
  end
  
end
