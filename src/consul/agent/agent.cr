require "../util"

module Consul
  class Agent
    getter base_url

    def initialize(@port : Int32, @endpoint =  "")
        @base_url = "http://localhost:#{port}/v1/agent"
    end

    # get_services returns all the services that are registered with the local agent
    def get_services() : JSON::Any
      resp = Consul::Util.get("#{base_url}/services")

      return JSON.parse(resp.body)
    end

    # get_service_conf returns the full service definition for a single service instance registered on the local agent
    def get_service_conf(name : String) : Consul::Types::ServiceConf
      resp = Consul::Util.get("#{base_url}/service/#{name}")
      return Consul::Types::ServiceConf.from_json(resp.body)
    end

    # register_service adds a new service, with an optional health check, to the local agent
    # TO-DO: implement kind, proxy, connect
    def register_service(
      name                : String,
      port                : Int32,
      id                  : String? = nil,
      tags                : Array(String)? = nil,
      address             : String? = nil,
      meta                : Hash(String, String)? = nil,
      check               : Hash(String, String | Array(String))? = nil,
      enable_tag_override : Bool = false,
      )

      data = {"Name" => name, "Port" => port, "EnableTagOverride" => enable_tag_override}

      unless id.nil?
        data["ID"] = id
      end

      unless address.nil?
        data["Address"] = address
      end

      unless tags.nil?
        data = data.merge({"Tags" => tags})
      end

      unless meta.nil?
        data = data.merge({"Meta" => meta})
      end

      unless check.nil?
        data = data.merge({"Check" => check})
      end

      resp = Consul::Util.put("#{base_url}/service/register", data: data.to_json)
    end

    # deregister_service removes a service from the local agent. If the service does not exist, no action is taken
    def deregister_service()
    end

    # set_serice_maintenence places a given service into "maintenance mode". 
    # During maintenance mode, the service will be marked as unavailable and will not be present in DNS or API queries
    def set_service_maintenenance()
    end

    # get_checks returns all checks that are registered with the local agent. 
    def get_checks()
    end

    # register_check adds a new check to the local agent. Checks may be of script, HTTP, TCP, or TTL type. 
    # The agent is responsible for managing the status of the check and keeping the Catalog in sync
    def register_check()
    end

    # deregister_check remove a check from the local agent. The agent will take care of deregistering the check from 
    # the catalog. If the check with the provided ID does not exist, no action is taken
    def deregister_check()
    end

    # ttl_check_pass is used with a TTL type check to set the status of the check to passing and to reset the TTL clock
    def ttl_check_pass()
    end

    # ttl_check_warn is used with a TTL type check to set the status of the check to warning and to reset the TTL clock
    def ttl_check_warn()
    end

    # ttl_check_fail is used with a TTL type check to set the status of the check to critical and to reset the TTL clock
    def ttl_check_fail()
    end

    # ttl_check_upate is used with a TTL type check to set the status of the check and to reset the TTL clock
    def ttl_check_update()
    end

  end
end
