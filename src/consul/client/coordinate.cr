module Consul
  class Coordinate < Consul::HttpAgent

    # get_wan_coordinates returns the WAN network coordinates for all Consul servers, organized by datacenters
    def get_wan_coordinates()
    end

    # get_lan_coordinates returns the LAN network coordinates for all nodes in a given datacenter
    def get_lan_coordinates()
    end

    # get_lan_coordinates with node returns the LAN network coordinates for the given node
    def get_lan_coordinates(node : String)
    end

    # set_lan_coordinate updates the LAN network coordinates for a node in a given datacenter
    def set_lan_coordinate()
    end

  end
end