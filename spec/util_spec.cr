require "./spec_helper"

describe Consul do
  context ".Util" do
    it "should return a valid url encoded query params" do
      c = Consul::Util.build_query_params({"service" => "service-test", "near" => "node-x"})
      c.should eq "%3Fservice%3Dservice-test%26near%3Dnode-x"
    end

    it "should return a valid url query param" do
      c = Consul::Util.build_query_params({"service" => "service-test"})
      c.should eq "?service=service-test"
    end

    it "should return a valid url query param" do
      c = Consul::Util.build_query_params({"service" => ""})
      c.should eq "?service"
    end

    it "should return a valid url encoded query params" do
      c = Consul::Util.build_query_params({"service" => "service-x", "filter" => "filter=Meta.env == qa"})
      c.should eq "%3Fservice%3Dservice-x%26filter%3Dfilter%3DMeta.env%20%3D%3D%20qa"
    end

  end
end
