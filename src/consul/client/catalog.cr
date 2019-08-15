require "../types/*"
require "../httpagent"
require "../models/service"

module Consul
  class Catalog < Consul::HttpAgent

    # register is a low-level mechanism for registering or updating entries in the catalog. 
    # It is usually preferable to instead use the agent endpoints for registration as they are simpler and perform anti-entropy
    def register(
      node        : String, 
      address     : String,
      id          : String? = nil,
      datacenter  : String? = nil,
      #service     : Hash(String, String | Array(String))? = nil,
      service     : Consul::Service? = nil,
      check       : Hash(String, String)? = nil,
      node_meta   : Hash(String, String)? = nil
      )

      data = {"Node" => node, "Address" => address}

      unless id.nil?
        data["ID"] = id
      end

      unless datacenter.nil?
        data["Datacenter"] = datacenter
      end

      unless service.nil?
        data = data.merge({"Service" => service})
      end

      unless check.nil?
        data = data.merge({"Check" => check})
      end

      unless node_meta.nil?
        data = data.merge({"NodeMeta" => service})
      end

      put("/v1/catalog/register", data: data.to_json)
    end

    # deregister is a low-level mechanism for directly removing entries from the Catalog. 
    # It is usually preferable to instead use the agent endpoints for deregistration as they are simpler and perform anti-entropy
    def deregister(
      node        : String,
      datacenter  : String? = nil,
      check_id    : String? = nil,
      service_id  : String? = nil?
      )

      data = {"Node" => node}

      unless datacenter.nil?
        data = data.merge({"Datacenter" => datacenter})
      end

      unless check_id.nil?
        data = data.merge({"CheckID" => check_id})
      end

      unless service_id.nil?
        data = data.merge({"ServiceID" => service_id})
      end

      put(client, "/v1/catalog/deregister", data: data.to_json)
    end

    # list_services returns the services registered in a given datacenter
    def list_services() : Hash(String, Array(String))
      resp = get("/v1/catalog/services")
      return Hash(String, Array(String)).from_json(resp.body)
    end

    # list_nodes_for_service returns the nodes providing a service in a given datacenter
    def list_nodes_for_service(service : String) : Array(Consul::Types::Catalog::NodeService)
      resp  = get("/v1/catalog/service/#{service}")
      nodes = Array(Consul::Types::Catalog::NodeService).from_json(resp.body)
      return nodes
    end

    # list_services_for_node returns the node's registered services
    def list_services_for_node()
    end

    # list_datacenters returns the list of all known datacenters. 
    # The datacenters will be sorted in ascending order based on the estimated median 
    # round trip time from the server to the servers in that datacenter
    def list_datacenters() : Array(String)
      resp = get("/v1/catalog/datacenters")
      dc = Array(String).from_json(resp.body)
    end

    # list_nodes returns the nodes registered in a given datacenter
    def list_nodes() : Array(Consul::Types::Catalog::Node)
      resp  = get("/v1/catalog/nodes")
      nodes = Array(Consul::Types::Catalog::Node).from_json(resp.body)
      return nodes
    end

  end
end