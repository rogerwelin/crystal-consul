require "../util"
require "../types/*"

module Consul
  class Health

    getter client

    def initialize(@client : HTTP::Client)
    end

    # get_checks_for_node returns the checks specific to the node provided on the path
    def get_checks_for_node(node : String, datacenter : String? = nil) : Array(Consul::Types::Health::Check)
      endpoint = "/v1/health/node/#{node}"

      unless datacenter.nil?
        url = "#{endpoint}?dc=#{datacenter}"
      end

      resp = Consul::Util.get(client, endpoint)
      return Array(Consul::Types::Health::Check).from_json(resp.body)
    end

    # get_checks_for_service returns the checks associated with the service provided on the path
    # TO-DO: build up the url parameters
    def get_checks_for_service(
      service       : String,
      datacenter    : String? = nil,
      near          : String? = nil,
      node_meta     : String? = nil
      ) :  Array(Consul::Types::Health::Check)

      endpoint = "/v1/health/checks/#{service}"

      val = Consul::Util.validate_query_parameters({"dc" => datacenter, "near" => near, "node-meta" => node_meta})

      if val
        endpoint = "#{endpoint}#{val}"
      end

      resp = Consul::Util.get(client, endpoint)
      return Array(Consul::Types::Health::Check).from_json(resp.body)
    end

    # get_nodes_for_service returns the nodes providing the service indicated on the path
    # TO-DO: build up the url parameters
    def get_nodes_for_service(
      service       : String,
      datacenter    : String? = nil,
      near          : String? = nil,
      tag           : String? = nil,
      node_meta     : String? = nil,
      passing       : String? = nil
      )

      endpoint = "/v1/health/service/#{service}"

      val = Consul::Util.validate_query_parameters({"dc" => datacenter, 
        "near" => near, 
        "tag" => tag, 
        "passing" => passing, 
        "node-meta" => node_meta})

      if val
        endpoint = "#{endpoint}#{val}"
      end


    end

    # get_connect_nodes returns the nodes providing a Connect-capable service in a given datacenter. 
    # This will include both proxies and native integrations
    # TO-DO: implement
    def get_connect_nodes()
    end

    # get_checks_in_state returns the checks in the state provided on the path
    # TO-DO: build up the url parameters
    def get_checks_in_state(
      state         : String,
      datacenter    : String? = nil,
      near          : String? = nil,
      node_meta     : String? = nil
      ) : Array(Consul::Types::Health::Check)

      endpoint = "/v1/health/state/#{state}"

      val = Consul::Util.validate_query_parameters({"dc" => datacenter, 
        "near" => near, 
        "node-meta" => node_meta})

      resp = Consul::Util.get(client, endpoint)
      return Array(Consul::Types::Health::Check).from_json(resp.body)
    end

  end
end