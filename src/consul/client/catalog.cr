require "../types/*"
require "../transport"
require "../models/service"
require "../util"

module Consul
  class Catalog < Consul::Transport
    # register is a low-level mechanism for registering or updating entries in the catalog.
    # It is usually preferable to instead use the agent endpoints for registration as they are simpler and perform anti-entropy
    def register(
      node : String,
      address : String,
      id : String? = nil,
      datacenter : String? = nil,
      service : Consul::Service? = nil,
      check : Hash(String, String)? = nil,
      node_meta : Hash(String, String)? = nil
    )
      data = Consul::Util.build_hash({
        "Node"       => node,
        "Address"    => address,
        "ID"         => id,
        "Datacenter" => datacenter,
        "Service"    => service,
        "Check"      => check,
        "NodeMeta"   => node_meta,
      })

      put("/v1/catalog/register", data: data.to_json)
    end

    # deregister is a low-level mechanism for directly removing entries from the Catalog.
    # It is usually preferable to instead use the agent endpoints for deregistration as they are simpler and perform anti-entropy
    def deregister(
      node : String,
      datacenter : String? = nil,
      check_id : String? = nil,
      service_id : String? = nil?
    )
      data = Consul::Util.build_hash({
        "Node"       => node,
        "Datacenter" => datacenter,
        "ServiceID"  => service_id,
        "CheckID"    => check_id,
      })

      put(client, "/v1/catalog/deregister", data: data.to_json)
    end

    # get_services returns the services registered in a given datacenter
    def get_services(datacenter : String? = nil, node_meta : String? = nil) : Hash(String, Array(String))
      endpoint = "/v1/catalog/services"
      consistency = get_consistency()
      val = Consul::Util.build_query_params({
        "#{consistency}" => "",
        "dc"             => datacenter,
        "node-meta"      => node_meta,
      })

      if val
        endpoint = "#{endpoint}#{val}"
      end

      resp = get(endpoint)
      return Hash(String, Array(String)).from_json(resp.body)
    end

    # get_nodes_for_service returns the nodes providing a service in a given datacenter
    def get_nodes_for_service(
      service : String,
      datacenter : String? = nil,
      tag : String? = nil,
      near : String? = nil,
      node_meta : String? = nil,
      filter : String? = nil
    ) : Array(Consul::Types::Catalog::NodeService)
      endpoint = "/v1/catalog/service/#{service}"
      consistency = get_consistency()

      val = Consul::Util.build_query_params({
        "#{consistency}" => "",
        "dc"             => datacenter,
        "tag"            => tag,
        "near"           => near,
        "node-meta"      => node_meta,
        "filter"         => filter,
      })

      if val
        endpoint = "#{endpoint}#{val}"
      end

      resp = get(endpoint)
      nodes = Array(Consul::Types::Catalog::NodeService).from_json(resp.body)
      return nodes
    end

    # get_services_for_node returns the node's registered services
    def get_service_for_node(
      node : String,
      datacenter : String? = nil,
      filter : String? = nil
    ) : Array(Consul::Types::Catalog::NodeService)
      endpoint = "/v1/catalog/node/#{node}"
      consistency = get_consistency()

      val = Consul::Util.build_query_params({
        "#{consistency}" => "",
        "dc"             => datacenter,
        "filter"         => filter,
      })

      if val
        endpoint = "#{endpoint}#{val}"
      end

      resp = get(endpoint)
      services = Array(Consul::Types::Catalog::NodeService).from_json(resp.body)
      return services
    end

    # get_datacenters returns the list of all known datacenters.
    # The datacenters will be sorted in ascending order based on the estimated median
    # round trip time from the server to the servers in that datacenter
    def get_datacenters : Array(String)
      resp = get("/v1/catalog/datacenters")
      dc = Array(String).from_json(resp.body)
    end

    # get_nodes returns the nodes registered in a given datacenter
    def get_nodes(
      dc : String? = nil,
      near : String? = nil,
      node_meta : String? = nil
    ) : Array(Consul::Types::Catalog::Node)
      endpoint = "/v1/catalog/nodes"
      consistency = get_consistency()
      val = Consul::Util.build_query_params({
        "#{consistency}" => "",
        "near"           => near,
        "node-meta"      => node_meta,
      })

      if val
        endpoint = "#{endpoint}#{val}"
      end

      resp = get("/v1/catalog/nodes?#{consistency}")
      nodes = Array(Consul::Types::Catalog::Node).from_json(resp.body)
      return nodes
    end
  end
end
