require "./spec_helper"

describe Consul do
  context ".Catalog" do

    it "should list datacenters with expected type" do
      c = Consul.client()
      c.catalog.list_datacenters().should be_a Array(String)
    end
      
    it "should list nodes with expected type" do
      c = Consul.client()
      c.catalog.list_nodes().should be_a Array(Consul::Types::Catalog::Node)
    end
  
  end
end
  