require "./spec_helper"

describe Consul do
  context ".KV" do
    it "should create & return expected kv type" do
      c = Consul.client
      c.kv.create_key("animal/ape", "gorilla")
      c.kv.get_key("animal/ape").should be_a Consul::Types::KV::KvPair
    end

    it "should return expected recurse kv type" do
      c = Consul.client
      c.kv.create_key("animal/ape", "gorilla")
      c.kv.get_key("animal/ape", recurse: true).should be_a Array(Consul::Types::KV::KvPair)
    end

    it "should return expected recurse keys as an array" do
      c = Consul.client
      c.kv.get_key("animal/ape", recurse: true, keys: true).should be_a Array(String)
    end

    it "should return expected kv value" do
      c = Consul.client
      c.kv.get_key("animal/ape").value.should eq "gorilla"
    end

    it "should delete & raise expected exception" do
      c = Consul.client
      c.kv.delete_key("animal/ape")
      expect_raises(Consul::Error::NotFound) do
        c.kv.get_key("animal/ape")
      end
    end

    it "should raise expected exception on bad input" do
      c = Consul.client
      expect_raises(Consul::Error::BadRequest) do
        c.kv.get_key("animal ape")
      end
    end
  end
end
