require "./spec_helper"

describe Consul do
  context ".KV" do
    it "should create & return expected kv type" do
      c = Consul.client
      c.kv.create_key("animal/monkey", "gorilla")
      c.kv.get_key("animal/monkey").should be_a Consul::Types::KV::KvPair
    end

    it "should return expected recurse kv type" do
      c = Consul.client
      c.kv.create_key("animal/monkey", "gorilla")
      c.kv.get_key("animal/monkey", recurse: true).should be_a Array(Consul::Types::KV::KvPair)
    end

    it "should return expected kv value" do
      c = Consul.client
      c.kv.get_key("animal/monkey").value.should eq "gorilla"
    end

    it "should delete & raise expected exception" do
      c = Consul.client
      c.kv.delete_key("animal/monkey")
      begin
        c.kv.get_key("animal/monkey")
      rescue ex : Consul::Error::NotFound
        ex.should be_a Consul::Error::NotFound
      end
    end

    it "should raise expected exception on bad input" do
      c = Consul.client
      begin
        c.kv.get_key("animal monkey")
      rescue ex : Consul::Error::BadRequest
        ex.should be_a Consul::Error::BadRequest
      end
    end
  end
end
