require "./spec_helper"

describe Consul do
  context ".Status" do
    it "should return a string for leader endpoint" do
      c = Consul.client
      c.status.get_leader.should be_a String
    end

    it "should return a array of strings for raft peers" do
      c = Consul.client
      c.status.get_raft_peers.should be_a Array(String)
    end
  end
end
