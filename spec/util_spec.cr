require "./spec_helper"

describe Consul do
  context ".Util" do
    it "should return a valid url query params" do
      c = Consul::Util.build_query_params({"service" => "service-test", "near" => "node-x"})
      c.should eq "?service=service-test&near=node-x"
    end

    it "should return a valid url query param" do
      c = Consul::Util.build_query_params({"service" => "service-test"})
      c.should eq "?service=service-test"
    end

    it "should return a valid url query param" do
      c = Consul::Util.build_query_params({"service" => ""})
      c.should eq "?service"
    end

    it "should return a valid url encoded filter query params" do
      c = Consul::Util.build_query_params({"service" => "service-x", "filter" => "Meta.env == qa"})
      c.should eq "?service=service-x&filter%3DMeta.env%20%3D%3D%20qa"
    end

    it "should return expected hash" do
      expected = {"ape" => "gorilla", "number" => 8}
      c = Consul::Util.build_hash({"ape" => "gorilla", "number" => 8})
      c.should eq expected
    end

    it "should return expected hash with no nil keys" do
      given = {"ape" => "gorilla", "given" => nil, "number" => 8, "ip" => nil, "nested" => {"val" => 1}}
      expected = {"ape" => "gorilla", "number" => 8, "nested" => {"val" => 1}}
      c = Consul::Util.build_hash(given)
      c.should eq expected
    end
  end
end
