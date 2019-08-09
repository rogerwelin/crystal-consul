module Consul
  class Health

    getter client

    def initialize(@client : HTTP::Client)
        #@base_url = "http://#{host}:#{port}/v1/health"
    end

    # get_checks_for_node returns the checks specific to the node provided on the path
    def get_checks_for_node(node : String, datacenter : String? = nil)
    end

    # get_checks_for_service returns the checks associated with the service provided on the path
    def get_checks_for_service(
      service   : String,
      near      : String? = nil,
      node_meta : String? = nil
      )

    end

    # get_nodes_for_service returns the nodes providing the service indicated on the path
    def get_nodes_for_service(
      service       : String,
      datacenter    : String? = nil,
      near          : String? = nil,
      tag           : String = nil,
      node_meta     : String? = nil,
      passing       : String? = nil
      )

    end

    # get_checks_in_state returns the checks in the state provided on the path
    def get_checks_in_state(
      state         : String,
      datacenter    : String? = nil,
      near          : String? = nil,
      node_meta     : String? = nil
      )
    end




  end
end