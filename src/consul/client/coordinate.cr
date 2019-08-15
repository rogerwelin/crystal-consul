require "../types/*"

module Consul
  class Coordinate < Consul::HttpAgent

    # get_wan_coordinates returns the WAN network coordinates for all Consul servers, organized by datacenters
    def get_wan_coordinates() : Array(Consul::Types::Coordinate::Wan)
      resp = get("/v1/coordinate/datacenters")
      return Array(Consul::Types::Coordinate::Wan).from_json(resp.body)
    end

    # get_lan_coordinates returns the LAN network coordinates for all nodes in a given datacenter
    def get_lan_coordinates() : Array(Consul::Types::Coordinate::Lan)
      resp = get("/v1/coordinate/nodes")
      return Array(Consul::Types::Coordinate::Lan).from_json(resp.body)
    end

    # get_lan_coordinates with node returns the LAN network coordinates for the given node
    def get_node_lan_coordinates(node : String) : Array(Consul::Types::Coordinate::Lan)
      resp = get("/v1/coordinate/node/#{node}")
      return Array(Consul::Types::Coordinate::Lan).from_json(resp.body)
    end

    # set_lan_coordinate updates the LAN network coordinates for a node in a given datacenter
    def set_lan_coordinate(data)
      put("/coordinate/update", data: data.to_json)
    end

  end
end