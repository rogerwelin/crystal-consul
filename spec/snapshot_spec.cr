require "./spec_helper"

describe Consul do
  context ".Snapshot" do
    it "should return a string for create snapshot" do
      c = Consul.client
      c.snapshot.create_snapshot.should be_a String
    end
  end
end
