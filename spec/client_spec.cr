require "./spec_helper"

describe Consul do
  context ".Client" do
    it "should be a Consul::Client" do
      Consul.client().should be_a Consul::Client
    end

    it "should set default host to 127.0.01" do
      Consul.client().host.should eq "127.0.0.1"
    end

    it "shoul set default port to 8500" do
      Consul.client().port.should eq 8500
    end

    it "should set default scheme to http" do
      Consul.client().scheme.should eq "http"
    end

    it "should se default token to empty" do
      Consul.client().token.should eq ""
    end

    it "should set token 'X-Consul-Token' when provided" do
      Consul.client(token: "abc123").token.should eq "abc123"
    end

    it "should set default consistency" do
      Consul.client().consistency.should eq "default"
    end

    it "should set consistency when provided" do
      Consul.client(consistency: "stale").consistency.should eq "stale"
    end

    it "should raise error on invalid consistency value" do
      begin
        Consul.client(consistency: "notknown")
      rescue ex : Exception
        ex.should be_a Exception
      end
    end

    it "should set consistency when provided" do
      Consul.client(consistency: "stale").consistency.should eq "stale"
    end

    it "should set host when provided" do
      Consul.client(host: "localhost").host.should eq "localhost"
    end

    it "should set port when provided" do
      Consul.client(port: 9000).port.should eq 9000
    end

    it "should set scheme when provided" do
      Consul.client(scheme: "https").scheme.should eq "https"
    end

    it "instances should not override each other" do
      client1 = Consul.client(host: "127.0.0.1")
      client2 = Consul.client(host: "consul.example.com")
      client1.host.should eq "127.0.0.1"
      client2.host.should eq "consul.example.com"
    end
  end
end