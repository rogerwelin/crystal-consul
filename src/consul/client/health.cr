require "../transport"
require "../types/*"
require "../util"

module Consul
  class Health < Consul::Transport
    # get_checks_for_node returns the checks specific to the node provided on the path
    def get_checks_for_node(
      node : String,
      datacenter : String? = nil,
      filter : String? = nil
    ) : Array(Consul::Types::Health::Check)
      endpoint = "/v1/health/node/#{node}"
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
      return Array(Consul::Types::Health::Check).from_json(resp.body)
    end

    # get_checks_for_service returns the checks associated with the service provided on the path
    def get_checks_for_service(
      service : String,
      datacenter : String? = nil,
      near : String? = nil,
      node_meta : String? = nil,
      filter : String? = nil
    ) : Array(Consul::Types::Health::Check)
      endpoint = "/v1/health/checks/#{service}"
      consistency = get_consistency()

      val = Consul::Util.build_query_params({
        "#{consistency}" => "",
        "dc"             => datacenter,
        "near"           => near,
        "node-meta"      => node_meta,
        "filter"         => filter,
      })

      if val
        endpoint = "#{endpoint}#{val}"
      end

      resp = get(endpoint)
      return Array(Consul::Types::Health::Check).from_json(resp.body)
    end

    # get_nodes_for_service returns the nodes providing the service indicated on the path
    def get_nodes_for_service(
      service : String,
      datacenter : String? = nil,
      near : String? = nil,
      tag : String? = nil,
      node_meta : String? = nil,
      passing : String? = nil,
      filter : String? = nil
    ) : Array(Consul::Types::Health::NodeService)
      endpoint = "/v1/health/service/#{service}"
      consistency = get_consistency()

      val = Consul::Util.build_query_params({
        "#{consistency}" => "",
        "dc"             => datacenter,
        "near"           => near,
        "tag"            => tag,
        "passing"        => passing,
        "node-meta"      => node_meta,
        "filter"         => filter,
      })

      if val
        endpoint = "#{endpoint}#{val}"
      end

      resp = get(endpoint)
      return Array(Consul::Types::Health::NodeService).from_json(resp.body)
    end

    # get_connect_nodes returns the nodes providing a Connect-capable service in a given datacenter.
    # This will include both proxies and native integrations
    def get_connect_nodes(service : String) : Array(Consul::Types::Health::NodeService)
      resp = get("/v1/health/connect/#{service}")
      return Array(Consul::Types::Health::NodeService).from_json(resp.body)
    end

    # get_checks_in_state returns the checks in the state provided on the path
    def get_checks_in_state(
      state : String,
      datacenter : String? = nil,
      near : String? = nil,
      node_meta : String? = nil,
      filter : String? = nil
    ) : Array(Consul::Types::Health::Check)
      endpoint = "/v1/health/state/#{state}"
      consistency = get_consistency()

      val = Consul::Util.build_query_params({
        "#{consistency}" => "",
        "dc"             => datacenter,
        "near"           => near,
        "node-meta"      => node_meta,
        "filter"         => filter,
      })

      if val
        endpoint = "#{endpoint}#{val}"
      end

      resp = get(endpoint)
      return Array(Consul::Types::Health::Check).from_json(resp.body)
    end
  end
end
