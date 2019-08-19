require "./spec_helper"

describe Consul do
  context ".Catalog" do
    it "should list datacenters with expected type" do
      c = Consul.client
      c.catalog.get_datacenters.should be_a Array(String)
    end

    it "should list nodes with expected type" do
      c = Consul.client
      c.catalog.get_nodes.should be_a Array(Consul::Types::Catalog::Node)
    end

    it "should list services with expected type" do
      c = Consul.client
      c.catalog.get_services.should be_a Hash(String, Array(String))
    end
  end
end
