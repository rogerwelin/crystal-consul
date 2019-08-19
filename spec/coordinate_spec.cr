require "./spec_helper"

describe Consul do
  context ".Coordinate" do
    it "should list wan coordinates with expected type" do
      c = Consul.client
      c.coordinate.get_wan_coordinates.should be_a Array(Consul::Types::Coordinate::Wan)
    end

    it "should list lan coordinates with expected type" do
      c = Consul.client
      c.coordinate.get_lan_coordinates.should be_a Array(Consul::Types::Coordinate::Lan)
    end
  end
end
