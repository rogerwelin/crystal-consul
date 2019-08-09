require "./spec_helper"

describe Consul do
  context ".client" do
    it "should be a Consul::Client" do
      Consul.client().should be_a Consul::Client
    end

    it "sets default host to 127.0.01" do
      Consul.client().host.should eq "127.0.0.1"
    end

    it "sets default port to 8500" do
      Consul.client().port.should eq 8500
    end

    it "sets default scheme to http" do
      Consul.client().scheme.should eq "http"
    end

    it "sets default token to empty" do
      Consul.client().token.should eq ""
    end

    it "sets token 'X-Consul-Token' when provided" do
      Consul.client(token: "abc123").token.should eq "abc123"
    end

    it "sets host when provided" do
      Consul.client(host: "localhost").host.should eq "localhost"
    end

    it "sets port when provided" do
      Consul.client(port: 9000).port.should eq 9000
    end

    it "sets scheme when provided" do
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